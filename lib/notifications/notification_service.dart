import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

import '../data/app_repositories.dart';
import '../models/models.dart';
import 'background_handler.dart';
import 'notification_ids.dart';

/// A perzisztens, eszkalálódó gyógyszeremlékeztető helyi értesítés-rétege
/// (brief §3.2). Három valódi, az OS által kézbesített szintet ütemez elő:
///   1. szint — a tervezett időpontban
///   2. szint — `repeatIntervalMinutes` múlva (ismételt emlékeztető)
///   3. szint — még `repeatIntervalMinutes` múlva, erősebb csatornán
///      (Android: max importance + full-screen intent; a brief szerint
///      javasolt megoldás az „áttörő" riasztásra Critical Alerts hiányában)
/// A 4. szint (gondozó értesítése) ebben a fázisban nem valódi push — nincs
/// backend/FCM-infrastruktúra a gondozó saját eszközének eléréséhez. Helyette
/// az app előtérbe kerülésekor lefutó egyeztetés (lásd
/// AppRepositories.reconcileMissedIntakes) jelöli `escalatedToCaregiver`-nek
/// a rég lejárt, visszaigazolatlan bejegyzéseket — a valódi, többfelhasználós
/// gondozó-push a Fázis 2/3 backend-munka része (brief §9).
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const channelDefaultId = 'med_reminder_default';
  static const channelUrgentId = 'med_reminder_urgent';
  static const channelQuietId = 'med_reminder_quiet';

  Future<void> initialize(AppRepositories repositories) async {
    if (_initialized) return;

    tz_data.initializeTimeZones();
    try {
      final locationName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    } catch (_) {
      // Ismeretlen/nem támogatott időzóna esetén UTC marad; éles eszközön
      // ellenőrizendő, hogy a helyi idő és a nyári/téli időszámítás-váltás
      // helyesen érvényesül (brief §7 konfliktuskezelés).
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    final darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: [
        DarwinNotificationCategory(
          notificationCategoryId,
          actions: [
            DarwinNotificationAction.plain(notificationActionConfirmId, 'Bevettem'),
            DarwinNotificationAction.plain(notificationActionSnoozeId, 'Később emlékeztess'),
          ],
        ),
      ],
    );

    await _plugin.initialize(
      InitializationSettings(android: androidInit, iOS: darwinInit),
      onDidReceiveNotificationResponse: (response) =>
          _onForegroundResponse(response, repositories),
      onDidReceiveBackgroundNotificationResponse: notificationBackgroundHandler,
    );

    if (Platform.isAndroid) {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.createNotificationChannel(const AndroidNotificationChannel(
        channelDefaultId,
        'Gyógyszeremlékeztetők',
        description: 'Ütemezett gyógyszerbevételi emlékeztetők.',
        importance: Importance.high,
      ));
      await androidPlugin?.createNotificationChannel(const AndroidNotificationChannel(
        channelUrgentId,
        'Sürgős gyógyszeremlékeztető',
        description: 'Erősebb riasztás, ha a bevétel sokáig nincs visszaigazolva.',
        importance: Importance.max,
      ));
      await androidPlugin?.createNotificationChannel(const AndroidNotificationChannel(
        channelQuietId,
        'Halk gyógyszeremlékeztető (csendes időszak)',
        description: 'Csendes időszakban kézbesített, hang és rezgés nélküli emlékeztető.',
        importance: Importance.low,
        playSound: false,
        enableVibration: false,
      ));
    }

    _initialized = true;
  }

  /// Android: értesítési engedély (13+) és pontos ébresztés engedély (12+)
  /// kérése. A visszatérési érték jelzi, hogy mindkettő megvan-e.
  Future<bool> requestAndroidPermissions() async {
    if (!Platform.isAndroid) return false;
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
    return await androidPlugin?.canScheduleExactNotifications() ?? false;
  }

  /// iOS: Critical Alerts kérése. Csak akkor engedélyezhető ténylegesen, ha
  /// az Apple külön jóváhagyta az entitlementet (brief §3.2) — enélkül a
  /// rendszer sima riasztásra fallbackel, amit a Focus/Ne zavarjanak
  /// elnémíthat.
  Future<bool> requestIosCriticalAlerts() async {
    if (!Platform.isIOS) return false;
    final iosPlugin = _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    final granted = await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
      critical: true,
    );
    return granted ?? false;
  }

  /// Előre beütemezi az 1-3. eszkalációs szint értesítéseit egy adott
  /// gyógyszerbevételi naplóbejegyzéshez. Csendes időszakban a szintek
  /// halkabb csatornát kapnak (lásd osztály-dokumentáció).
  Future<void> scheduleForIntakeLog({
    required MedicationIntakeLog log,
    required Medication medication,
    required NotificationPreference preference,
  }) async {
    final quiet = _isWithinQuietHours(log.scheduledTime, preference);
    final title = medication.name;
    final body = '${_formatTime(log.scheduledTime)} — ${medication.dosage}';

    final times = <int, DateTime>{
      1: log.scheduledTime,
      2: log.scheduledTime.add(Duration(minutes: preference.repeatIntervalMinutes)),
      3: log.scheduledTime.add(Duration(minutes: preference.repeatIntervalMinutes * 2)),
    };

    for (final level in escalationLevels) {
      final when = times[level]!;
      if (when.isBefore(DateTime.now())) continue;
      await _plugin.zonedSchedule(
        notificationIdFor(log.id, level),
        level == 1 ? title : '$title — még mindig várunk',
        body,
        tz.TZDateTime.from(when, tz.local),
        _detailsFor(level: level, quiet: quiet),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: log.id,
      );
    }
  }

  Future<void> cancelForIntakeLog(String logId) async {
    for (final level in escalationLevels) {
      await _plugin.cancel(notificationIdFor(logId, level));
    }
  }

  /// Minden beütemezett/megjelenített értesítés lemondása — a beteg adatainak
  /// teljes törlésekor (brief §8 GDPR „adattörlés") használt.
  Future<void> cancelAll() => _plugin.cancelAll();

  /// A „Később emlékeztess" választás után: törli a még ki nem küldött
  /// eszkalációs szinteket, és egyetlen új emlékeztetőt ütemez
  /// `repeatIntervalMinutes` múlva (nem az eredeti dózisidőponthoz képest).
  Future<void> scheduleSnoozeReminder({
    required MedicationIntakeLog log,
    required Medication medication,
    required NotificationPreference preference,
  }) async {
    await cancelForIntakeLog(log.id);
    final when = DateTime.now().add(Duration(minutes: preference.repeatIntervalMinutes));
    final quiet = _isWithinQuietHours(when, preference);
    await _plugin.zonedSchedule(
      notificationIdFor(log.id, 1),
      medication.name,
      '${_formatTime(log.scheduledTime)} — ${medication.dosage} (elhalasztva)',
      tz.TZDateTime.from(when, tz.local),
      _detailsFor(level: 1, quiet: quiet),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: log.id,
    );
  }

  Future<void> _onForegroundResponse(
    NotificationResponse response,
    AppRepositories repositories,
  ) async {
    final logId = response.payload;
    if (logId == null) return;

    final status = statusForNotificationAction(response.actionId);
    if (status == null) return; // sima koppintás — csak megnyitja az appot

    await repositories.medications.updateIntakeStatus(
      logId: logId,
      status: status,
      confirmedAt: status == IntakeStatus.confirmed ? DateTime.now() : null,
    );
    await cancelForIntakeLog(logId);
  }

  NotificationDetails _detailsFor({required int level, required bool quiet}) {
    final urgent = level >= 3 && !quiet;
    final channelId = quiet ? channelQuietId : (urgent ? channelUrgentId : channelDefaultId);
    final channelName = quiet
        ? 'Halk gyógyszeremlékeztető (csendes időszak)'
        : (urgent ? 'Sürgős gyógyszeremlékeztető' : 'Gyógyszeremlékeztetők');

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: quiet ? Importance.low : (urgent ? Importance.max : Importance.high),
        priority: quiet ? Priority.low : (urgent ? Priority.max : Priority.high),
        playSound: !quiet,
        enableVibration: !quiet,
        fullScreenIntent: urgent,
        category:
            urgent ? AndroidNotificationCategory.alarm : AndroidNotificationCategory.reminder,
        actions: const [
          AndroidNotificationAction(notificationActionConfirmId, 'Bevettem',
              showsUserInterface: false),
          AndroidNotificationAction(notificationActionSnoozeId, 'Később',
              showsUserInterface: false),
        ],
      ),
      iOS: DarwinNotificationDetails(
        categoryIdentifier: notificationCategoryId,
        presentSound: !quiet,
        interruptionLevel: quiet
            ? InterruptionLevel.passive
            : (urgent ? InterruptionLevel.critical : InterruptionLevel.active),
      ),
    );
  }

  bool _isWithinQuietHours(DateTime time, NotificationPreference preference) {
    final start = preference.quietHoursStart;
    final end = preference.quietHoursEnd;
    if (start == null || end == null) return false;

    final minutesOfDay = time.hour * 60 + time.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    if (startMinutes == endMinutes) return false;
    if (startMinutes < endMinutes) {
      return minutesOfDay >= startMinutes && minutesOfDay < endMinutes;
    }
    // Éjfélen átnyúló időszak (pl. 22:00–07:00).
    return minutesOfDay >= startMinutes || minutesOfDay < endMinutes;
  }

  String _formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}
