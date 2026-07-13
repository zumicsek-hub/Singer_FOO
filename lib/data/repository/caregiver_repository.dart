import 'package:drift/drift.dart';

import '../../models/models.dart';
import '../database/app_database.dart' as db;
import 'id_generator.dart';

class CaregiverWithGrant {
  final CaregiverProfile caregiver;
  final ConsentGrant grant;

  const CaregiverWithGrant({required this.caregiver, required this.grant});
}

class CaregiverRepository {
  final db.AppDatabase _db;

  CaregiverRepository(this._db);

  Stream<List<CaregiverWithGrant>> watchCaregivers(String patientId) {
    final query = _db.select(_db.consentGrants).join([
      innerJoin(_db.caregiverProfiles,
          _db.caregiverProfiles.id.equalsExp(_db.consentGrants.caregiverId)),
    ])
      ..where(_db.consentGrants.patientId.equals(patientId))
      ..orderBy([OrderingTerm.asc(_db.consentGrants.grantedAt)]);
    return query.watch().map((rows) => rows
        .map((row) => CaregiverWithGrant(
              caregiver: _caregiverFromRow(row.readTable(_db.caregiverProfiles)),
              grant: _grantFromRow(row.readTable(_db.consentGrants)),
            ))
        .toList());
  }

  /// Egyszeri (nem reaktív) lekérdezés — indításkori egyeztetéshez, ahol
  /// nincs szükség folyamatos figyelésre.
  Future<List<CaregiverWithGrant>> getCaregivers(String patientId) async {
    final query = _db.select(_db.consentGrants).join([
      innerJoin(_db.caregiverProfiles,
          _db.caregiverProfiles.id.equalsExp(_db.consentGrants.caregiverId)),
    ])
      ..where(_db.consentGrants.patientId.equals(patientId))
      ..orderBy([OrderingTerm.asc(_db.consentGrants.grantedAt)]);
    final rows = await query.get();
    return rows
        .map((row) => CaregiverWithGrant(
              caregiver: _caregiverFromRow(row.readTable(_db.caregiverProfiles)),
              grant: _grantFromRow(row.readTable(_db.consentGrants)),
            ))
        .toList();
  }

  Future<void> inviteCaregiver({
    required String patientId,
    required String relationshipToPatient,
    required List<ConsentScope> scopes,
  }) async {
    final caregiverId = newId();
    await _db.into(_db.caregiverProfiles).insert(
          db.CaregiverProfilesCompanion.insert(
            id: caregiverId,
            userId: newId(),
            relationshipToPatient: relationshipToPatient,
          ),
        );
    await _db.into(_db.consentGrants).insert(
          db.ConsentGrantsCompanion.insert(
            id: newId(),
            patientId: patientId,
            caregiverId: caregiverId,
            scopes: scopes.map((s) => s.name).join(','),
            grantedAt: DateTime.now(),
          ),
        );
  }

  Future<void> revokeConsent(String grantId) {
    return (_db.update(_db.consentGrants)..where((t) => t.id.equals(grantId)))
        .write(db.ConsentGrantsCompanion(revokedAt: Value(DateTime.now())));
  }

  /// GDPR törléshez: a beteghez tartozó összes hozzájárulás és a hozzájuk
  /// tartozó gondozói profilok törlése.
  Future<void> deleteAllForPatient(String patientId) async {
    final caregiverIds = (await (_db.select(_db.consentGrants)
              ..where((t) => t.patientId.equals(patientId)))
            .get())
        .map((g) => g.caregiverId)
        .toSet()
        .toList();

    await (_db.delete(_db.consentGrants)..where((t) => t.patientId.equals(patientId))).go();
    if (caregiverIds.isNotEmpty) {
      await (_db.delete(_db.caregiverProfiles)..where((t) => t.id.isIn(caregiverIds))).go();
    }
  }

  CaregiverProfile _caregiverFromRow(db.CaregiverProfile row) => CaregiverProfile(
        id: row.id,
        userId: row.userId,
        relationshipToPatient: row.relationshipToPatient,
      );

  ConsentGrant _grantFromRow(db.ConsentGrant row) => ConsentGrant(
        id: row.id,
        patientId: row.patientId,
        caregiverId: row.caregiverId,
        scopes: row.scopes.isEmpty
            ? const []
            : row.scopes.split(',').map((s) => ConsentScope.values.byName(s)).toList(),
        grantedAt: row.grantedAt,
        revokedAt: row.revokedAt,
      );
}
