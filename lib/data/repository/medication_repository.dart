import 'package:drift/drift.dart';

import '../../models/models.dart';
import '../database/app_database.dart' as db;
import 'id_generator.dart';

/// Gyógyszerek, ütemtervek, bevételi naplók és fehérjeablakok DB-rétege.
/// A drift táblák generált sorosztályai (pl. `db.Medication`) ütköznének a
/// domain modellekkel, ezért az adatbázis importja `db.` előtaggal történik.
class MedicationRepository {
  final db.AppDatabase _db;

  MedicationRepository(this._db);

  Stream<List<Medication>> watchActiveMedications(String patientId) {
    final query = _db.select(_db.medications)
      ..where((t) => t.patientId.equals(patientId) & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.watch().map((rows) => rows.map(_medicationFromRow).toList());
  }

  /// Egyszeri (nem reaktív) lekérdezés — indításkori egyeztetéshez és
  /// értesítés-ütemezéshez, ahol nincs szükség folyamatos figyelésre.
  Future<List<Medication>> getActiveMedications(String patientId) async {
    final query = _db.select(_db.medications)
      ..where((t) => t.patientId.equals(patientId) & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    final rows = await query.get();
    return rows.map(_medicationFromRow).toList();
  }

  Future<Medication> addMedication({
    required String patientId,
    required String name,
    required String dosage,
    required MedicationForm form,
    String? activeIngredient,
    bool proteinRuleEnabled = false,
    bool isRescueDose = false,
    String? note,
  }) async {
    final id = newId();
    final createdAt = DateTime.now();
    await _db.into(_db.medications).insert(db.MedicationsCompanion.insert(
          id: id,
          patientId: patientId,
          name: name,
          dosage: dosage,
          form: form.name,
          createdAt: createdAt,
          activeIngredient: Value(activeIngredient),
          isParkinsonMedication: Value(proteinRuleEnabled || isRescueDose),
          proteinRuleEnabled: Value(proteinRuleEnabled),
          isRescueDose: Value(isRescueDose),
          note: Value(note),
        ));
    return Medication(
      id: id,
      patientId: patientId,
      name: name,
      dosage: dosage,
      form: form,
      createdAt: createdAt,
      activeIngredient: activeIngredient,
      isParkinsonMedication: proteinRuleEnabled || isRescueDose,
      proteinRuleEnabled: proteinRuleEnabled,
      isRescueDose: isRescueDose,
      note: note,
    );
  }

  Future<void> setSchedule({
    required String medicationId,
    required List<DailyTime> dailyTimes,
  }) async {
    final existing = await (_db.select(_db.medicationSchedules)
          ..where((t) => t.medicationId.equals(medicationId)))
        .getSingleOrNull();

    final scheduleId = existing?.id ?? newId();
    if (existing == null) {
      await _db.into(_db.medicationSchedules).insert(
            db.MedicationSchedulesCompanion.insert(
              id: scheduleId,
              medicationId: medicationId,
              scheduleType: ScheduleType.customTimes.name,
              startDate: DateTime.now(),
              firstDoseHour: dailyTimes.first.hour,
              firstDoseMinute: dailyTimes.first.minute,
            ),
          );
    } else {
      await (_db.update(_db.medicationSchedules)
            ..where((t) => t.id.equals(scheduleId)))
          .write(db.MedicationSchedulesCompanion(
        firstDoseHour: Value(dailyTimes.first.hour),
        firstDoseMinute: Value(dailyTimes.first.minute),
      ));
    }

    await (_db.delete(_db.medicationScheduleTimes)
          ..where((t) => t.scheduleId.equals(scheduleId)))
        .go();
    await _db.batch((batch) {
      batch.insertAll(
        _db.medicationScheduleTimes,
        dailyTimes.map((t) => db.MedicationScheduleTimesCompanion.insert(
              scheduleId: scheduleId,
              hour: t.hour,
              minute: t.minute,
            )),
      );
    });
  }

  Stream<MedicationSchedule?> watchSchedule(String medicationId) {
    final query = _db.select(_db.medicationSchedules)
      ..where((t) => t.medicationId.equals(medicationId));
    return query.watchSingleOrNull().asyncMap((row) async {
      if (row == null) return null;
      final times = await (_db.select(_db.medicationScheduleTimes)
            ..where((t) => t.scheduleId.equals(row.id))
            ..orderBy([(t) => OrderingTerm.asc(t.hour)]))
          .get();
      return _scheduleFromRow(row, times);
    });
  }

  Future<void> setProteinWindow({
    required String medicationId,
    required double hoursBeforeDose,
    required double hoursAfterDose,
    required bool prescribedByPhysician,
    required bool active,
  }) async {
    final existing = await (_db.select(_db.proteinRestrictionWindows)
          ..where((t) => t.medicationId.equals(medicationId)))
        .getSingleOrNull();
    final companion = db.ProteinRestrictionWindowsCompanion(
      medicationId: Value(medicationId),
      hoursBeforeDose: Value(hoursBeforeDose),
      hoursAfterDose: Value(hoursAfterDose),
      prescribedByPhysician: Value(prescribedByPhysician),
      active: Value(active),
    );
    if (existing == null) {
      await _db.into(_db.proteinRestrictionWindows).insert(
            companion.copyWith(id: Value(newId())),
          );
    } else {
      await (_db.update(_db.proteinRestrictionWindows)
            ..where((t) => t.id.equals(existing.id)))
          .write(companion);
    }
  }

  Stream<ProteinRestrictionWindow?> watchProteinWindow(String medicationId) {
    final query = _db.select(_db.proteinRestrictionWindows)
      ..where((t) => t.medicationId.equals(medicationId));
    return query.watchSingleOrNull().map(
        (row) => row == null ? null : _proteinWindowFromRow(row));
  }

  /// Az adott napra generálja a hiányzó bevételi naplóbejegyzéseket az
  /// aktív, egyedi időpontos ütemtervek alapján. Idempotens: már létező
  /// (medicationId + scheduledTime) bejegyzést nem duplikál.
  Future<void> ensureTodayIntakeLogsGenerated(String patientId) async {
    final medicationRows = await (_db.select(_db.medications)
          ..where((t) => t.patientId.equals(patientId) & t.isActive.equals(true)))
        .get();
    final today = DateTime.now();

    for (final med in medicationRows) {
      final schedule = await (_db.select(_db.medicationSchedules)
            ..where((t) => t.medicationId.equals(med.id)))
          .getSingleOrNull();
      if (schedule == null) continue;
      final times = await (_db.select(_db.medicationScheduleTimes)
            ..where((t) => t.scheduleId.equals(schedule.id)))
          .get();

      for (final t in times) {
        final scheduledTime =
            DateTime(today.year, today.month, today.day, t.hour, t.minute);
        final exists = await (_db.select(_db.medicationIntakeLogs)
              ..where((l) =>
                  l.medicationId.equals(med.id) &
                  l.scheduledTime.equals(scheduledTime)))
            .getSingleOrNull();
        if (exists == null) {
          await _db.into(_db.medicationIntakeLogs).insert(
                db.MedicationIntakeLogsCompanion.insert(
                  id: newId(),
                  scheduleId: schedule.id,
                  medicationId: med.id,
                  scheduledTime: scheduledTime,
                  status: IntakeStatus.scheduled.name,
                ),
              );
        }
      }
    }
  }

  Stream<List<MedicationIntakeLog>> watchTodayIntakeLogs(String patientId) {
    final now = DateTime.now();
    final dayStart = DateTime(now.year, now.month, now.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final query = _db.select(_db.medicationIntakeLogs).join([
      innerJoin(_db.medications, _db.medications.id.equalsExp(_db.medicationIntakeLogs.medicationId)),
    ])
      ..where(_db.medications.patientId.equals(patientId) &
          _db.medicationIntakeLogs.scheduledTime.isBiggerOrEqualValue(dayStart) &
          _db.medicationIntakeLogs.scheduledTime.isSmallerThanValue(dayEnd))
      ..orderBy([OrderingTerm.asc(_db.medicationIntakeLogs.scheduledTime)]);
    return query.watch().map((rows) => rows
        .map((row) => _intakeLogFromRow(row.readTable(_db.medicationIntakeLogs)))
        .toList());
  }

  /// Egyszeri (nem reaktív) lekérdezés — indításkori egyeztetéshez és
  /// értesítés-ütemezéshez, ahol nincs szükség folyamatos figyelésre.
  Future<List<MedicationIntakeLog>> getTodayIntakeLogs(String patientId) async {
    final now = DateTime.now();
    final dayStart = DateTime(now.year, now.month, now.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final query = _db.select(_db.medicationIntakeLogs).join([
      innerJoin(_db.medications, _db.medications.id.equalsExp(_db.medicationIntakeLogs.medicationId)),
    ])
      ..where(_db.medications.patientId.equals(patientId) &
          _db.medicationIntakeLogs.scheduledTime.isBiggerOrEqualValue(dayStart) &
          _db.medicationIntakeLogs.scheduledTime.isSmallerThanValue(dayEnd))
      ..orderBy([OrderingTerm.asc(_db.medicationIntakeLogs.scheduledTime)]);
    final rows = await query.get();
    return rows.map((row) => _intakeLogFromRow(row.readTable(_db.medicationIntakeLogs))).toList();
  }

  /// Azok a bejegyzések, amelyek státusza még nem lezárt (scheduled/
  /// notified/snoozed), és a tervezett időponttól számítva már legalább
  /// [threshold] idő eltelt — az egyeztetési (reconciliation) lépéshez
  /// (lásd AppRepositories.reconcileMissedIntakes és brief §7).
  Future<List<MedicationIntakeLog>> overdueUnresolvedLogs(
    String patientId,
    Duration threshold,
  ) async {
    final unresolved = [
      IntakeStatus.scheduled.name,
      IntakeStatus.notified.name,
      IntakeStatus.snoozed.name,
    ];
    final query = _db.select(_db.medicationIntakeLogs).join([
      innerJoin(_db.medications, _db.medications.id.equalsExp(_db.medicationIntakeLogs.medicationId)),
    ])
      ..where(_db.medications.patientId.equals(patientId) &
          _db.medicationIntakeLogs.status.isIn(unresolved));
    final rows = await query.get();
    final now = DateTime.now();
    return rows
        .map((row) => _intakeLogFromRow(row.readTable(_db.medicationIntakeLogs)))
        .where((log) => now.difference(log.scheduledTime) >= threshold)
        .toList();
  }

  Future<void> updateIntakeStatus({
    required String logId,
    required IntakeStatus status,
    DateTime? confirmedAt,
    String? confirmedByUserId,
  }) {
    return (_db.update(_db.medicationIntakeLogs)..where((t) => t.id.equals(logId)))
        .write(db.MedicationIntakeLogsCompanion(
      status: Value(status.name),
      confirmedAt: Value(confirmedAt),
      confirmedByUserId: Value(confirmedByUserId),
    ));
  }

  Medication _medicationFromRow(db.Medication row) => Medication(
        id: row.id,
        patientId: row.patientId,
        name: row.name,
        dosage: row.dosage,
        form: MedicationForm.values.byName(row.form),
        createdAt: row.createdAt,
        activeIngredient: row.activeIngredient,
        isParkinsonMedication: row.isParkinsonMedication,
        proteinRuleEnabled: row.proteinRuleEnabled,
        isRescueDose: row.isRescueDose,
        note: row.note,
        isActive: row.isActive,
      );

  MedicationSchedule _scheduleFromRow(
    db.MedicationSchedule row,
    List<db.MedicationScheduleTime> times,
  ) =>
      MedicationSchedule(
        id: row.id,
        medicationId: row.medicationId,
        scheduleType: ScheduleType.values.byName(row.scheduleType),
        startDate: row.startDate,
        firstDoseTime: DailyTime(row.firstDoseHour, row.firstDoseMinute),
        endDate: row.endDate,
        intervalHours: row.intervalHours,
        customTimes: times.map((t) => DailyTime(t.hour, t.minute)).toList(),
      );

  ProteinRestrictionWindow _proteinWindowFromRow(db.ProteinRestrictionWindow row) =>
      ProteinRestrictionWindow(
        id: row.id,
        medicationId: row.medicationId,
        hoursBeforeDose: row.hoursBeforeDose,
        hoursAfterDose: row.hoursAfterDose,
        prescribedByPhysician: row.prescribedByPhysician,
        active: row.active,
      );

  MedicationIntakeLog _intakeLogFromRow(db.MedicationIntakeLog row) =>
      MedicationIntakeLog(
        id: row.id,
        scheduleId: row.scheduleId,
        medicationId: row.medicationId,
        scheduledTime: row.scheduledTime,
        status: IntakeStatus.values.byName(row.status),
        confirmedAt: row.confirmedAt,
        confirmedByUserId: row.confirmedByUserId,
        note: row.note,
      );
}
