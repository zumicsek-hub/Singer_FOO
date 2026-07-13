import '../models/models.dart';

/// Determinisztikus, log-azonosítóból származtatott értesítés-ID-k.
/// A plugin 32 bites egész ID-kat vár; a hash-ütközés esélye elhanyagolható
/// ennyi napi bejegyzésnél, de nem kriptográfiai garancia — skeleton-szintű
/// megoldás.
int notificationIdFor(String intakeLogId, int escalationLevel) {
  final combined = '$intakeLogId#$escalationLevel';
  return combined.hashCode & 0x7fffffff;
}

const List<int> escalationLevels = [1, 2, 3];

/// Értesítési művelet-gombok azonosítói (brief §3.1: „Bevettem" /
/// „Később emlékeztess"), amelyeket a foreground és a background
/// válasz-kezelő is felismer.
const String notificationActionConfirmId = 'confirm';
const String notificationActionSnoozeId = 'snooze';
const String notificationCategoryId = 'medicationReminder';

/// Egy értesítés-művelet azonosítóját fordítja le [IntakeStatus]-ra.
/// Sima koppintás (nincs actionId) esetén `null`-t ad vissza — az csak
/// megnyitja az alkalmazást, státuszváltás nélkül.
IntakeStatus? statusForNotificationAction(String? actionId) => switch (actionId) {
      notificationActionConfirmId => IntakeStatus.confirmed,
      notificationActionSnoozeId => IntakeStatus.snoozed,
      _ => null,
    };
