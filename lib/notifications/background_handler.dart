import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../data/database/app_database.dart';
import '../data/repository/medication_repository.dart';
import '../models/models.dart';
import 'notification_ids.dart';

/// Amikor a felhasználó egy értesítés műveletgombjára koppint úgy, hogy az
/// alkalmazás nincs előtérben ("Bevettem" / "Később"), az OS egy különálló
/// Dart isolate-ban futtatja le ezt a függvényt — Flutter-widget fa és
/// BuildContext nélkül. Ezért az adatbázist közvetlenül, a fő
/// alkalmazás-példánytól függetlenül nyitjuk meg (ugyanahhoz a lemezen lévő
/// fájlhoz kapcsolódva).
///
/// Megjegyzés: ez a mechanizmus Androidon dokumentáltan működik; iOS-en a
/// nem-UI-t megnyitó műveletgombok háttérbeli feldolgozása további natív
/// életciklus-korlátokba ütközhet, amit csak valós eszközön lehet
/// ellenőrizni (ebben a fejlesztői környezetben nincs hozzáférhető
/// szimulátor/eszköz).
@pragma('vm:entry-point')
void notificationBackgroundHandler(NotificationResponse response) {
  _handleInBackgroundIsolate(response);
}

Future<void> _handleInBackgroundIsolate(NotificationResponse response) async {
  final logId = response.payload;
  if (logId == null) return;

  final status = statusForNotificationAction(response.actionId);
  if (status == null) return;

  final db = AppDatabase(openAppDatabaseConnection());
  try {
    final repository = MedicationRepository(db);
    await repository.updateIntakeStatus(
      logId: logId,
      status: status,
      confirmedAt: status == IntakeStatus.confirmed ? DateTime.now() : null,
    );

    final plugin = FlutterLocalNotificationsPlugin();
    for (final level in escalationLevels) {
      await plugin.cancel(notificationIdFor(logId, level));
    }
  } catch (error, stack) {
    debugPrint('notificationBackgroundHandler failed: $error\n$stack');
  } finally {
    await db.close();
  }
}
