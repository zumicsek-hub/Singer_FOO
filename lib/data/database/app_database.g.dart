// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PatientProfilesTable extends PatientProfiles
    with TableInfo<$PatientProfilesTable, PatientProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _diagnosisYearMeta =
      const VerificationMeta('diagnosisYear');
  @override
  late final GeneratedColumn<int> diagnosisYear = GeneratedColumn<int>(
      'diagnosis_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _simplifiedModeEnabledMeta =
      const VerificationMeta('simplifiedModeEnabled');
  @override
  late final GeneratedColumn<bool> simplifiedModeEnabled =
      GeneratedColumn<bool>('simplified_mode_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("simplified_mode_enabled" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _treatingPhysicianNameMeta =
      const VerificationMeta('treatingPhysicianName');
  @override
  late final GeneratedColumn<String> treatingPhysicianName =
      GeneratedColumn<String>('treating_physician_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        dateOfBirth,
        diagnosisYear,
        simplifiedModeEnabled,
        treatingPhysicianName,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patient_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<PatientProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('diagnosis_year')) {
      context.handle(
          _diagnosisYearMeta,
          diagnosisYear.isAcceptableOrUnknown(
              data['diagnosis_year']!, _diagnosisYearMeta));
    }
    if (data.containsKey('simplified_mode_enabled')) {
      context.handle(
          _simplifiedModeEnabledMeta,
          simplifiedModeEnabled.isAcceptableOrUnknown(
              data['simplified_mode_enabled']!, _simplifiedModeEnabledMeta));
    }
    if (data.containsKey('treating_physician_name')) {
      context.handle(
          _treatingPhysicianNameMeta,
          treatingPhysicianName.isAcceptableOrUnknown(
              data['treating_physician_name']!, _treatingPhysicianNameMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth']),
      diagnosisYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diagnosis_year']),
      simplifiedModeEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}simplified_mode_enabled'])!,
      treatingPhysicianName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}treating_physician_name']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $PatientProfilesTable createAlias(String alias) {
    return $PatientProfilesTable(attachedDatabase, alias);
  }
}

class PatientProfile extends DataClass implements Insertable<PatientProfile> {
  final String id;
  final String userId;
  final DateTime? dateOfBirth;
  final int? diagnosisYear;
  final bool simplifiedModeEnabled;
  final String? treatingPhysicianName;
  final String? notes;
  const PatientProfile(
      {required this.id,
      required this.userId,
      this.dateOfBirth,
      this.diagnosisYear,
      required this.simplifiedModeEnabled,
      this.treatingPhysicianName,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || diagnosisYear != null) {
      map['diagnosis_year'] = Variable<int>(diagnosisYear);
    }
    map['simplified_mode_enabled'] = Variable<bool>(simplifiedModeEnabled);
    if (!nullToAbsent || treatingPhysicianName != null) {
      map['treating_physician_name'] = Variable<String>(treatingPhysicianName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PatientProfilesCompanion toCompanion(bool nullToAbsent) {
    return PatientProfilesCompanion(
      id: Value(id),
      userId: Value(userId),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      diagnosisYear: diagnosisYear == null && nullToAbsent
          ? const Value.absent()
          : Value(diagnosisYear),
      simplifiedModeEnabled: Value(simplifiedModeEnabled),
      treatingPhysicianName: treatingPhysicianName == null && nullToAbsent
          ? const Value.absent()
          : Value(treatingPhysicianName),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory PatientProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientProfile(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      diagnosisYear: serializer.fromJson<int?>(json['diagnosisYear']),
      simplifiedModeEnabled:
          serializer.fromJson<bool>(json['simplifiedModeEnabled']),
      treatingPhysicianName:
          serializer.fromJson<String?>(json['treatingPhysicianName']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'diagnosisYear': serializer.toJson<int?>(diagnosisYear),
      'simplifiedModeEnabled': serializer.toJson<bool>(simplifiedModeEnabled),
      'treatingPhysicianName':
          serializer.toJson<String?>(treatingPhysicianName),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PatientProfile copyWith(
          {String? id,
          String? userId,
          Value<DateTime?> dateOfBirth = const Value.absent(),
          Value<int?> diagnosisYear = const Value.absent(),
          bool? simplifiedModeEnabled,
          Value<String?> treatingPhysicianName = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      PatientProfile(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        diagnosisYear:
            diagnosisYear.present ? diagnosisYear.value : this.diagnosisYear,
        simplifiedModeEnabled:
            simplifiedModeEnabled ?? this.simplifiedModeEnabled,
        treatingPhysicianName: treatingPhysicianName.present
            ? treatingPhysicianName.value
            : this.treatingPhysicianName,
        notes: notes.present ? notes.value : this.notes,
      );
  PatientProfile copyWithCompanion(PatientProfilesCompanion data) {
    return PatientProfile(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      diagnosisYear: data.diagnosisYear.present
          ? data.diagnosisYear.value
          : this.diagnosisYear,
      simplifiedModeEnabled: data.simplifiedModeEnabled.present
          ? data.simplifiedModeEnabled.value
          : this.simplifiedModeEnabled,
      treatingPhysicianName: data.treatingPhysicianName.present
          ? data.treatingPhysicianName.value
          : this.treatingPhysicianName,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientProfile(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('diagnosisYear: $diagnosisYear, ')
          ..write('simplifiedModeEnabled: $simplifiedModeEnabled, ')
          ..write('treatingPhysicianName: $treatingPhysicianName, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, dateOfBirth, diagnosisYear,
      simplifiedModeEnabled, treatingPhysicianName, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientProfile &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.dateOfBirth == this.dateOfBirth &&
          other.diagnosisYear == this.diagnosisYear &&
          other.simplifiedModeEnabled == this.simplifiedModeEnabled &&
          other.treatingPhysicianName == this.treatingPhysicianName &&
          other.notes == this.notes);
}

class PatientProfilesCompanion extends UpdateCompanion<PatientProfile> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime?> dateOfBirth;
  final Value<int?> diagnosisYear;
  final Value<bool> simplifiedModeEnabled;
  final Value<String?> treatingPhysicianName;
  final Value<String?> notes;
  final Value<int> rowid;
  const PatientProfilesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.diagnosisYear = const Value.absent(),
    this.simplifiedModeEnabled = const Value.absent(),
    this.treatingPhysicianName = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PatientProfilesCompanion.insert({
    required String id,
    required String userId,
    this.dateOfBirth = const Value.absent(),
    this.diagnosisYear = const Value.absent(),
    this.simplifiedModeEnabled = const Value.absent(),
    this.treatingPhysicianName = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId);
  static Insertable<PatientProfile> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? dateOfBirth,
    Expression<int>? diagnosisYear,
    Expression<bool>? simplifiedModeEnabled,
    Expression<String>? treatingPhysicianName,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (diagnosisYear != null) 'diagnosis_year': diagnosisYear,
      if (simplifiedModeEnabled != null)
        'simplified_mode_enabled': simplifiedModeEnabled,
      if (treatingPhysicianName != null)
        'treating_physician_name': treatingPhysicianName,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PatientProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<DateTime?>? dateOfBirth,
      Value<int?>? diagnosisYear,
      Value<bool>? simplifiedModeEnabled,
      Value<String?>? treatingPhysicianName,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return PatientProfilesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      diagnosisYear: diagnosisYear ?? this.diagnosisYear,
      simplifiedModeEnabled:
          simplifiedModeEnabled ?? this.simplifiedModeEnabled,
      treatingPhysicianName:
          treatingPhysicianName ?? this.treatingPhysicianName,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (diagnosisYear.present) {
      map['diagnosis_year'] = Variable<int>(diagnosisYear.value);
    }
    if (simplifiedModeEnabled.present) {
      map['simplified_mode_enabled'] =
          Variable<bool>(simplifiedModeEnabled.value);
    }
    if (treatingPhysicianName.present) {
      map['treating_physician_name'] =
          Variable<String>(treatingPhysicianName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientProfilesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('diagnosisYear: $diagnosisYear, ')
          ..write('simplifiedModeEnabled: $simplifiedModeEnabled, ')
          ..write('treatingPhysicianName: $treatingPhysicianName, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicationsTable extends Medications
    with TableInfo<$MedicationsTable, Medication> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activeIngredientMeta =
      const VerificationMeta('activeIngredient');
  @override
  late final GeneratedColumn<String> activeIngredient = GeneratedColumn<String>(
      'active_ingredient', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
      'form', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isParkinsonMedicationMeta =
      const VerificationMeta('isParkinsonMedication');
  @override
  late final GeneratedColumn<bool> isParkinsonMedication =
      GeneratedColumn<bool>('is_parkinson_medication', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("is_parkinson_medication" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _proteinRuleEnabledMeta =
      const VerificationMeta('proteinRuleEnabled');
  @override
  late final GeneratedColumn<bool> proteinRuleEnabled = GeneratedColumn<bool>(
      'protein_rule_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("protein_rule_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isRescueDoseMeta =
      const VerificationMeta('isRescueDose');
  @override
  late final GeneratedColumn<bool> isRescueDose = GeneratedColumn<bool>(
      'is_rescue_dose', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_rescue_dose" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        name,
        activeIngredient,
        dosage,
        form,
        isParkinsonMedication,
        proteinRuleEnabled,
        isRescueDose,
        note,
        isActive,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medications';
  @override
  VerificationContext validateIntegrity(Insertable<Medication> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('active_ingredient')) {
      context.handle(
          _activeIngredientMeta,
          activeIngredient.isAcceptableOrUnknown(
              data['active_ingredient']!, _activeIngredientMeta));
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('form')) {
      context.handle(
          _formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    } else if (isInserting) {
      context.missing(_formMeta);
    }
    if (data.containsKey('is_parkinson_medication')) {
      context.handle(
          _isParkinsonMedicationMeta,
          isParkinsonMedication.isAcceptableOrUnknown(
              data['is_parkinson_medication']!, _isParkinsonMedicationMeta));
    }
    if (data.containsKey('protein_rule_enabled')) {
      context.handle(
          _proteinRuleEnabledMeta,
          proteinRuleEnabled.isAcceptableOrUnknown(
              data['protein_rule_enabled']!, _proteinRuleEnabledMeta));
    }
    if (data.containsKey('is_rescue_dose')) {
      context.handle(
          _isRescueDoseMeta,
          isRescueDose.isAcceptableOrUnknown(
              data['is_rescue_dose']!, _isRescueDoseMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Medication map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medication(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      activeIngredient: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}active_ingredient']),
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
      form: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}form'])!,
      isParkinsonMedication: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}is_parkinson_medication'])!,
      proteinRuleEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}protein_rule_enabled'])!,
      isRescueDose: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_rescue_dose'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MedicationsTable createAlias(String alias) {
    return $MedicationsTable(attachedDatabase, alias);
  }
}

class Medication extends DataClass implements Insertable<Medication> {
  final String id;
  final String patientId;
  final String name;
  final String? activeIngredient;
  final String dosage;

  /// [MedicationForm].name
  final String form;
  final bool isParkinsonMedication;
  final bool proteinRuleEnabled;
  final bool isRescueDose;
  final String? note;
  final bool isActive;
  final DateTime createdAt;
  const Medication(
      {required this.id,
      required this.patientId,
      required this.name,
      this.activeIngredient,
      required this.dosage,
      required this.form,
      required this.isParkinsonMedication,
      required this.proteinRuleEnabled,
      required this.isRescueDose,
      this.note,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || activeIngredient != null) {
      map['active_ingredient'] = Variable<String>(activeIngredient);
    }
    map['dosage'] = Variable<String>(dosage);
    map['form'] = Variable<String>(form);
    map['is_parkinson_medication'] = Variable<bool>(isParkinsonMedication);
    map['protein_rule_enabled'] = Variable<bool>(proteinRuleEnabled);
    map['is_rescue_dose'] = Variable<bool>(isRescueDose);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MedicationsCompanion toCompanion(bool nullToAbsent) {
    return MedicationsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      name: Value(name),
      activeIngredient: activeIngredient == null && nullToAbsent
          ? const Value.absent()
          : Value(activeIngredient),
      dosage: Value(dosage),
      form: Value(form),
      isParkinsonMedication: Value(isParkinsonMedication),
      proteinRuleEnabled: Value(proteinRuleEnabled),
      isRescueDose: Value(isRescueDose),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Medication.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medication(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      name: serializer.fromJson<String>(json['name']),
      activeIngredient: serializer.fromJson<String?>(json['activeIngredient']),
      dosage: serializer.fromJson<String>(json['dosage']),
      form: serializer.fromJson<String>(json['form']),
      isParkinsonMedication:
          serializer.fromJson<bool>(json['isParkinsonMedication']),
      proteinRuleEnabled: serializer.fromJson<bool>(json['proteinRuleEnabled']),
      isRescueDose: serializer.fromJson<bool>(json['isRescueDose']),
      note: serializer.fromJson<String?>(json['note']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'name': serializer.toJson<String>(name),
      'activeIngredient': serializer.toJson<String?>(activeIngredient),
      'dosage': serializer.toJson<String>(dosage),
      'form': serializer.toJson<String>(form),
      'isParkinsonMedication': serializer.toJson<bool>(isParkinsonMedication),
      'proteinRuleEnabled': serializer.toJson<bool>(proteinRuleEnabled),
      'isRescueDose': serializer.toJson<bool>(isRescueDose),
      'note': serializer.toJson<String?>(note),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Medication copyWith(
          {String? id,
          String? patientId,
          String? name,
          Value<String?> activeIngredient = const Value.absent(),
          String? dosage,
          String? form,
          bool? isParkinsonMedication,
          bool? proteinRuleEnabled,
          bool? isRescueDose,
          Value<String?> note = const Value.absent(),
          bool? isActive,
          DateTime? createdAt}) =>
      Medication(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        name: name ?? this.name,
        activeIngredient: activeIngredient.present
            ? activeIngredient.value
            : this.activeIngredient,
        dosage: dosage ?? this.dosage,
        form: form ?? this.form,
        isParkinsonMedication:
            isParkinsonMedication ?? this.isParkinsonMedication,
        proteinRuleEnabled: proteinRuleEnabled ?? this.proteinRuleEnabled,
        isRescueDose: isRescueDose ?? this.isRescueDose,
        note: note.present ? note.value : this.note,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  Medication copyWithCompanion(MedicationsCompanion data) {
    return Medication(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      name: data.name.present ? data.name.value : this.name,
      activeIngredient: data.activeIngredient.present
          ? data.activeIngredient.value
          : this.activeIngredient,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      form: data.form.present ? data.form.value : this.form,
      isParkinsonMedication: data.isParkinsonMedication.present
          ? data.isParkinsonMedication.value
          : this.isParkinsonMedication,
      proteinRuleEnabled: data.proteinRuleEnabled.present
          ? data.proteinRuleEnabled.value
          : this.proteinRuleEnabled,
      isRescueDose: data.isRescueDose.present
          ? data.isRescueDose.value
          : this.isRescueDose,
      note: data.note.present ? data.note.value : this.note,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medication(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('activeIngredient: $activeIngredient, ')
          ..write('dosage: $dosage, ')
          ..write('form: $form, ')
          ..write('isParkinsonMedication: $isParkinsonMedication, ')
          ..write('proteinRuleEnabled: $proteinRuleEnabled, ')
          ..write('isRescueDose: $isRescueDose, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      patientId,
      name,
      activeIngredient,
      dosage,
      form,
      isParkinsonMedication,
      proteinRuleEnabled,
      isRescueDose,
      note,
      isActive,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medication &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.name == this.name &&
          other.activeIngredient == this.activeIngredient &&
          other.dosage == this.dosage &&
          other.form == this.form &&
          other.isParkinsonMedication == this.isParkinsonMedication &&
          other.proteinRuleEnabled == this.proteinRuleEnabled &&
          other.isRescueDose == this.isRescueDose &&
          other.note == this.note &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class MedicationsCompanion extends UpdateCompanion<Medication> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> name;
  final Value<String?> activeIngredient;
  final Value<String> dosage;
  final Value<String> form;
  final Value<bool> isParkinsonMedication;
  final Value<bool> proteinRuleEnabled;
  final Value<bool> isRescueDose;
  final Value<String?> note;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MedicationsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.name = const Value.absent(),
    this.activeIngredient = const Value.absent(),
    this.dosage = const Value.absent(),
    this.form = const Value.absent(),
    this.isParkinsonMedication = const Value.absent(),
    this.proteinRuleEnabled = const Value.absent(),
    this.isRescueDose = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationsCompanion.insert({
    required String id,
    required String patientId,
    required String name,
    this.activeIngredient = const Value.absent(),
    required String dosage,
    required String form,
    this.isParkinsonMedication = const Value.absent(),
    this.proteinRuleEnabled = const Value.absent(),
    this.isRescueDose = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        name = Value(name),
        dosage = Value(dosage),
        form = Value(form),
        createdAt = Value(createdAt);
  static Insertable<Medication> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? name,
    Expression<String>? activeIngredient,
    Expression<String>? dosage,
    Expression<String>? form,
    Expression<bool>? isParkinsonMedication,
    Expression<bool>? proteinRuleEnabled,
    Expression<bool>? isRescueDose,
    Expression<String>? note,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (name != null) 'name': name,
      if (activeIngredient != null) 'active_ingredient': activeIngredient,
      if (dosage != null) 'dosage': dosage,
      if (form != null) 'form': form,
      if (isParkinsonMedication != null)
        'is_parkinson_medication': isParkinsonMedication,
      if (proteinRuleEnabled != null)
        'protein_rule_enabled': proteinRuleEnabled,
      if (isRescueDose != null) 'is_rescue_dose': isRescueDose,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? name,
      Value<String?>? activeIngredient,
      Value<String>? dosage,
      Value<String>? form,
      Value<bool>? isParkinsonMedication,
      Value<bool>? proteinRuleEnabled,
      Value<bool>? isRescueDose,
      Value<String?>? note,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MedicationsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      activeIngredient: activeIngredient ?? this.activeIngredient,
      dosage: dosage ?? this.dosage,
      form: form ?? this.form,
      isParkinsonMedication:
          isParkinsonMedication ?? this.isParkinsonMedication,
      proteinRuleEnabled: proteinRuleEnabled ?? this.proteinRuleEnabled,
      isRescueDose: isRescueDose ?? this.isRescueDose,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (activeIngredient.present) {
      map['active_ingredient'] = Variable<String>(activeIngredient.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (isParkinsonMedication.present) {
      map['is_parkinson_medication'] =
          Variable<bool>(isParkinsonMedication.value);
    }
    if (proteinRuleEnabled.present) {
      map['protein_rule_enabled'] = Variable<bool>(proteinRuleEnabled.value);
    }
    if (isRescueDose.present) {
      map['is_rescue_dose'] = Variable<bool>(isRescueDose.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('activeIngredient: $activeIngredient, ')
          ..write('dosage: $dosage, ')
          ..write('form: $form, ')
          ..write('isParkinsonMedication: $isParkinsonMedication, ')
          ..write('proteinRuleEnabled: $proteinRuleEnabled, ')
          ..write('isRescueDose: $isRescueDose, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicationSchedulesTable extends MedicationSchedules
    with TableInfo<$MedicationSchedulesTable, MedicationSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medicationIdMeta =
      const VerificationMeta('medicationId');
  @override
  late final GeneratedColumn<String> medicationId = GeneratedColumn<String>(
      'medication_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduleTypeMeta =
      const VerificationMeta('scheduleType');
  @override
  late final GeneratedColumn<String> scheduleType = GeneratedColumn<String>(
      'schedule_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _intervalHoursMeta =
      const VerificationMeta('intervalHours');
  @override
  late final GeneratedColumn<double> intervalHours = GeneratedColumn<double>(
      'interval_hours', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _firstDoseHourMeta =
      const VerificationMeta('firstDoseHour');
  @override
  late final GeneratedColumn<int> firstDoseHour = GeneratedColumn<int>(
      'first_dose_hour', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _firstDoseMinuteMeta =
      const VerificationMeta('firstDoseMinute');
  @override
  late final GeneratedColumn<int> firstDoseMinute = GeneratedColumn<int>(
      'first_dose_minute', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        medicationId,
        scheduleType,
        startDate,
        endDate,
        intervalHours,
        firstDoseHour,
        firstDoseMinute
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medication_schedules';
  @override
  VerificationContext validateIntegrity(Insertable<MedicationSchedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
          _medicationIdMeta,
          medicationId.isAcceptableOrUnknown(
              data['medication_id']!, _medicationIdMeta));
    } else if (isInserting) {
      context.missing(_medicationIdMeta);
    }
    if (data.containsKey('schedule_type')) {
      context.handle(
          _scheduleTypeMeta,
          scheduleType.isAcceptableOrUnknown(
              data['schedule_type']!, _scheduleTypeMeta));
    } else if (isInserting) {
      context.missing(_scheduleTypeMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('interval_hours')) {
      context.handle(
          _intervalHoursMeta,
          intervalHours.isAcceptableOrUnknown(
              data['interval_hours']!, _intervalHoursMeta));
    }
    if (data.containsKey('first_dose_hour')) {
      context.handle(
          _firstDoseHourMeta,
          firstDoseHour.isAcceptableOrUnknown(
              data['first_dose_hour']!, _firstDoseHourMeta));
    } else if (isInserting) {
      context.missing(_firstDoseHourMeta);
    }
    if (data.containsKey('first_dose_minute')) {
      context.handle(
          _firstDoseMinuteMeta,
          firstDoseMinute.isAcceptableOrUnknown(
              data['first_dose_minute']!, _firstDoseMinuteMeta));
    } else if (isInserting) {
      context.missing(_firstDoseMinuteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationSchedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      medicationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medication_id'])!,
      scheduleType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}schedule_type'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      intervalHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}interval_hours']),
      firstDoseHour: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}first_dose_hour'])!,
      firstDoseMinute: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}first_dose_minute'])!,
    );
  }

  @override
  $MedicationSchedulesTable createAlias(String alias) {
    return $MedicationSchedulesTable(attachedDatabase, alias);
  }
}

class MedicationSchedule extends DataClass
    implements Insertable<MedicationSchedule> {
  final String id;
  final String medicationId;

  /// [ScheduleType].name
  final String scheduleType;
  final DateTime startDate;
  final DateTime? endDate;
  final double? intervalHours;
  final int firstDoseHour;
  final int firstDoseMinute;
  const MedicationSchedule(
      {required this.id,
      required this.medicationId,
      required this.scheduleType,
      required this.startDate,
      this.endDate,
      this.intervalHours,
      required this.firstDoseHour,
      required this.firstDoseMinute});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['medication_id'] = Variable<String>(medicationId);
    map['schedule_type'] = Variable<String>(scheduleType);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || intervalHours != null) {
      map['interval_hours'] = Variable<double>(intervalHours);
    }
    map['first_dose_hour'] = Variable<int>(firstDoseHour);
    map['first_dose_minute'] = Variable<int>(firstDoseMinute);
    return map;
  }

  MedicationSchedulesCompanion toCompanion(bool nullToAbsent) {
    return MedicationSchedulesCompanion(
      id: Value(id),
      medicationId: Value(medicationId),
      scheduleType: Value(scheduleType),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      intervalHours: intervalHours == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalHours),
      firstDoseHour: Value(firstDoseHour),
      firstDoseMinute: Value(firstDoseMinute),
    );
  }

  factory MedicationSchedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationSchedule(
      id: serializer.fromJson<String>(json['id']),
      medicationId: serializer.fromJson<String>(json['medicationId']),
      scheduleType: serializer.fromJson<String>(json['scheduleType']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      intervalHours: serializer.fromJson<double?>(json['intervalHours']),
      firstDoseHour: serializer.fromJson<int>(json['firstDoseHour']),
      firstDoseMinute: serializer.fromJson<int>(json['firstDoseMinute']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'medicationId': serializer.toJson<String>(medicationId),
      'scheduleType': serializer.toJson<String>(scheduleType),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'intervalHours': serializer.toJson<double?>(intervalHours),
      'firstDoseHour': serializer.toJson<int>(firstDoseHour),
      'firstDoseMinute': serializer.toJson<int>(firstDoseMinute),
    };
  }

  MedicationSchedule copyWith(
          {String? id,
          String? medicationId,
          String? scheduleType,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          Value<double?> intervalHours = const Value.absent(),
          int? firstDoseHour,
          int? firstDoseMinute}) =>
      MedicationSchedule(
        id: id ?? this.id,
        medicationId: medicationId ?? this.medicationId,
        scheduleType: scheduleType ?? this.scheduleType,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        intervalHours:
            intervalHours.present ? intervalHours.value : this.intervalHours,
        firstDoseHour: firstDoseHour ?? this.firstDoseHour,
        firstDoseMinute: firstDoseMinute ?? this.firstDoseMinute,
      );
  MedicationSchedule copyWithCompanion(MedicationSchedulesCompanion data) {
    return MedicationSchedule(
      id: data.id.present ? data.id.value : this.id,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      scheduleType: data.scheduleType.present
          ? data.scheduleType.value
          : this.scheduleType,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      intervalHours: data.intervalHours.present
          ? data.intervalHours.value
          : this.intervalHours,
      firstDoseHour: data.firstDoseHour.present
          ? data.firstDoseHour.value
          : this.firstDoseHour,
      firstDoseMinute: data.firstDoseMinute.present
          ? data.firstDoseMinute.value
          : this.firstDoseMinute,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationSchedule(')
          ..write('id: $id, ')
          ..write('medicationId: $medicationId, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('intervalHours: $intervalHours, ')
          ..write('firstDoseHour: $firstDoseHour, ')
          ..write('firstDoseMinute: $firstDoseMinute')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, medicationId, scheduleType, startDate,
      endDate, intervalHours, firstDoseHour, firstDoseMinute);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationSchedule &&
          other.id == this.id &&
          other.medicationId == this.medicationId &&
          other.scheduleType == this.scheduleType &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.intervalHours == this.intervalHours &&
          other.firstDoseHour == this.firstDoseHour &&
          other.firstDoseMinute == this.firstDoseMinute);
}

class MedicationSchedulesCompanion extends UpdateCompanion<MedicationSchedule> {
  final Value<String> id;
  final Value<String> medicationId;
  final Value<String> scheduleType;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<double?> intervalHours;
  final Value<int> firstDoseHour;
  final Value<int> firstDoseMinute;
  final Value<int> rowid;
  const MedicationSchedulesCompanion({
    this.id = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.intervalHours = const Value.absent(),
    this.firstDoseHour = const Value.absent(),
    this.firstDoseMinute = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationSchedulesCompanion.insert({
    required String id,
    required String medicationId,
    required String scheduleType,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.intervalHours = const Value.absent(),
    required int firstDoseHour,
    required int firstDoseMinute,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        medicationId = Value(medicationId),
        scheduleType = Value(scheduleType),
        startDate = Value(startDate),
        firstDoseHour = Value(firstDoseHour),
        firstDoseMinute = Value(firstDoseMinute);
  static Insertable<MedicationSchedule> custom({
    Expression<String>? id,
    Expression<String>? medicationId,
    Expression<String>? scheduleType,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<double>? intervalHours,
    Expression<int>? firstDoseHour,
    Expression<int>? firstDoseMinute,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicationId != null) 'medication_id': medicationId,
      if (scheduleType != null) 'schedule_type': scheduleType,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (intervalHours != null) 'interval_hours': intervalHours,
      if (firstDoseHour != null) 'first_dose_hour': firstDoseHour,
      if (firstDoseMinute != null) 'first_dose_minute': firstDoseMinute,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationSchedulesCompanion copyWith(
      {Value<String>? id,
      Value<String>? medicationId,
      Value<String>? scheduleType,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<double?>? intervalHours,
      Value<int>? firstDoseHour,
      Value<int>? firstDoseMinute,
      Value<int>? rowid}) {
    return MedicationSchedulesCompanion(
      id: id ?? this.id,
      medicationId: medicationId ?? this.medicationId,
      scheduleType: scheduleType ?? this.scheduleType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      intervalHours: intervalHours ?? this.intervalHours,
      firstDoseHour: firstDoseHour ?? this.firstDoseHour,
      firstDoseMinute: firstDoseMinute ?? this.firstDoseMinute,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<String>(medicationId.value);
    }
    if (scheduleType.present) {
      map['schedule_type'] = Variable<String>(scheduleType.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (intervalHours.present) {
      map['interval_hours'] = Variable<double>(intervalHours.value);
    }
    if (firstDoseHour.present) {
      map['first_dose_hour'] = Variable<int>(firstDoseHour.value);
    }
    if (firstDoseMinute.present) {
      map['first_dose_minute'] = Variable<int>(firstDoseMinute.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('medicationId: $medicationId, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('intervalHours: $intervalHours, ')
          ..write('firstDoseHour: $firstDoseHour, ')
          ..write('firstDoseMinute: $firstDoseMinute, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicationScheduleTimesTable extends MedicationScheduleTimes
    with TableInfo<$MedicationScheduleTimesTable, MedicationScheduleTime> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationScheduleTimesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _scheduleIdMeta =
      const VerificationMeta('scheduleId');
  @override
  late final GeneratedColumn<String> scheduleId = GeneratedColumn<String>(
      'schedule_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
      'hour', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
      'minute', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, scheduleId, hour, minute];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medication_schedule_times';
  @override
  VerificationContext validateIntegrity(
      Insertable<MedicationScheduleTime> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
          _scheduleIdMeta,
          scheduleId.isAcceptableOrUnknown(
              data['schedule_id']!, _scheduleIdMeta));
    } else if (isInserting) {
      context.missing(_scheduleIdMeta);
    }
    if (data.containsKey('hour')) {
      context.handle(
          _hourMeta, hour.isAcceptableOrUnknown(data['hour']!, _hourMeta));
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(_minuteMeta,
          minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta));
    } else if (isInserting) {
      context.missing(_minuteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationScheduleTime map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationScheduleTime(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      scheduleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}schedule_id'])!,
      hour: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hour'])!,
      minute: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}minute'])!,
    );
  }

  @override
  $MedicationScheduleTimesTable createAlias(String alias) {
    return $MedicationScheduleTimesTable(attachedDatabase, alias);
  }
}

class MedicationScheduleTime extends DataClass
    implements Insertable<MedicationScheduleTime> {
  final int id;
  final String scheduleId;
  final int hour;
  final int minute;
  const MedicationScheduleTime(
      {required this.id,
      required this.scheduleId,
      required this.hour,
      required this.minute});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['schedule_id'] = Variable<String>(scheduleId);
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    return map;
  }

  MedicationScheduleTimesCompanion toCompanion(bool nullToAbsent) {
    return MedicationScheduleTimesCompanion(
      id: Value(id),
      scheduleId: Value(scheduleId),
      hour: Value(hour),
      minute: Value(minute),
    );
  }

  factory MedicationScheduleTime.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationScheduleTime(
      id: serializer.fromJson<int>(json['id']),
      scheduleId: serializer.fromJson<String>(json['scheduleId']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scheduleId': serializer.toJson<String>(scheduleId),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
    };
  }

  MedicationScheduleTime copyWith(
          {int? id, String? scheduleId, int? hour, int? minute}) =>
      MedicationScheduleTime(
        id: id ?? this.id,
        scheduleId: scheduleId ?? this.scheduleId,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
      );
  MedicationScheduleTime copyWithCompanion(
      MedicationScheduleTimesCompanion data) {
    return MedicationScheduleTime(
      id: data.id.present ? data.id.value : this.id,
      scheduleId:
          data.scheduleId.present ? data.scheduleId.value : this.scheduleId,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationScheduleTime(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scheduleId, hour, minute);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationScheduleTime &&
          other.id == this.id &&
          other.scheduleId == this.scheduleId &&
          other.hour == this.hour &&
          other.minute == this.minute);
}

class MedicationScheduleTimesCompanion
    extends UpdateCompanion<MedicationScheduleTime> {
  final Value<int> id;
  final Value<String> scheduleId;
  final Value<int> hour;
  final Value<int> minute;
  const MedicationScheduleTimesCompanion({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
  });
  MedicationScheduleTimesCompanion.insert({
    this.id = const Value.absent(),
    required String scheduleId,
    required int hour,
    required int minute,
  })  : scheduleId = Value(scheduleId),
        hour = Value(hour),
        minute = Value(minute);
  static Insertable<MedicationScheduleTime> custom({
    Expression<int>? id,
    Expression<String>? scheduleId,
    Expression<int>? hour,
    Expression<int>? minute,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
    });
  }

  MedicationScheduleTimesCompanion copyWith(
      {Value<int>? id,
      Value<String>? scheduleId,
      Value<int>? hour,
      Value<int>? minute}) {
    return MedicationScheduleTimesCompanion(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<String>(scheduleId.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationScheduleTimesCompanion(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute')
          ..write(')'))
        .toString();
  }
}

class $MedicationIntakeLogsTable extends MedicationIntakeLogs
    with TableInfo<$MedicationIntakeLogsTable, MedicationIntakeLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationIntakeLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduleIdMeta =
      const VerificationMeta('scheduleId');
  @override
  late final GeneratedColumn<String> scheduleId = GeneratedColumn<String>(
      'schedule_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medicationIdMeta =
      const VerificationMeta('medicationId');
  @override
  late final GeneratedColumn<String> medicationId = GeneratedColumn<String>(
      'medication_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduledTimeMeta =
      const VerificationMeta('scheduledTime');
  @override
  late final GeneratedColumn<DateTime> scheduledTime =
      GeneratedColumn<DateTime>('scheduled_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _confirmedAtMeta =
      const VerificationMeta('confirmedAt');
  @override
  late final GeneratedColumn<DateTime> confirmedAt = GeneratedColumn<DateTime>(
      'confirmed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _confirmedByUserIdMeta =
      const VerificationMeta('confirmedByUserId');
  @override
  late final GeneratedColumn<String> confirmedByUserId =
      GeneratedColumn<String>('confirmed_by_user_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        scheduleId,
        medicationId,
        scheduledTime,
        status,
        confirmedAt,
        confirmedByUserId,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medication_intake_logs';
  @override
  VerificationContext validateIntegrity(
      Insertable<MedicationIntakeLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
          _scheduleIdMeta,
          scheduleId.isAcceptableOrUnknown(
              data['schedule_id']!, _scheduleIdMeta));
    } else if (isInserting) {
      context.missing(_scheduleIdMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
          _medicationIdMeta,
          medicationId.isAcceptableOrUnknown(
              data['medication_id']!, _medicationIdMeta));
    } else if (isInserting) {
      context.missing(_medicationIdMeta);
    }
    if (data.containsKey('scheduled_time')) {
      context.handle(
          _scheduledTimeMeta,
          scheduledTime.isAcceptableOrUnknown(
              data['scheduled_time']!, _scheduledTimeMeta));
    } else if (isInserting) {
      context.missing(_scheduledTimeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('confirmed_at')) {
      context.handle(
          _confirmedAtMeta,
          confirmedAt.isAcceptableOrUnknown(
              data['confirmed_at']!, _confirmedAtMeta));
    }
    if (data.containsKey('confirmed_by_user_id')) {
      context.handle(
          _confirmedByUserIdMeta,
          confirmedByUserId.isAcceptableOrUnknown(
              data['confirmed_by_user_id']!, _confirmedByUserIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationIntakeLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationIntakeLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      scheduleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}schedule_id'])!,
      medicationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medication_id'])!,
      scheduledTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_time'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      confirmedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}confirmed_at']),
      confirmedByUserId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}confirmed_by_user_id']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $MedicationIntakeLogsTable createAlias(String alias) {
    return $MedicationIntakeLogsTable(attachedDatabase, alias);
  }
}

class MedicationIntakeLog extends DataClass
    implements Insertable<MedicationIntakeLog> {
  final String id;
  final String scheduleId;
  final String medicationId;
  final DateTime scheduledTime;

  /// [IntakeStatus].name
  final String status;
  final DateTime? confirmedAt;
  final String? confirmedByUserId;
  final String? note;
  const MedicationIntakeLog(
      {required this.id,
      required this.scheduleId,
      required this.medicationId,
      required this.scheduledTime,
      required this.status,
      this.confirmedAt,
      this.confirmedByUserId,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['schedule_id'] = Variable<String>(scheduleId);
    map['medication_id'] = Variable<String>(medicationId);
    map['scheduled_time'] = Variable<DateTime>(scheduledTime);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || confirmedAt != null) {
      map['confirmed_at'] = Variable<DateTime>(confirmedAt);
    }
    if (!nullToAbsent || confirmedByUserId != null) {
      map['confirmed_by_user_id'] = Variable<String>(confirmedByUserId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  MedicationIntakeLogsCompanion toCompanion(bool nullToAbsent) {
    return MedicationIntakeLogsCompanion(
      id: Value(id),
      scheduleId: Value(scheduleId),
      medicationId: Value(medicationId),
      scheduledTime: Value(scheduledTime),
      status: Value(status),
      confirmedAt: confirmedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedAt),
      confirmedByUserId: confirmedByUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(confirmedByUserId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory MedicationIntakeLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationIntakeLog(
      id: serializer.fromJson<String>(json['id']),
      scheduleId: serializer.fromJson<String>(json['scheduleId']),
      medicationId: serializer.fromJson<String>(json['medicationId']),
      scheduledTime: serializer.fromJson<DateTime>(json['scheduledTime']),
      status: serializer.fromJson<String>(json['status']),
      confirmedAt: serializer.fromJson<DateTime?>(json['confirmedAt']),
      confirmedByUserId:
          serializer.fromJson<String?>(json['confirmedByUserId']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'scheduleId': serializer.toJson<String>(scheduleId),
      'medicationId': serializer.toJson<String>(medicationId),
      'scheduledTime': serializer.toJson<DateTime>(scheduledTime),
      'status': serializer.toJson<String>(status),
      'confirmedAt': serializer.toJson<DateTime?>(confirmedAt),
      'confirmedByUserId': serializer.toJson<String?>(confirmedByUserId),
      'note': serializer.toJson<String?>(note),
    };
  }

  MedicationIntakeLog copyWith(
          {String? id,
          String? scheduleId,
          String? medicationId,
          DateTime? scheduledTime,
          String? status,
          Value<DateTime?> confirmedAt = const Value.absent(),
          Value<String?> confirmedByUserId = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      MedicationIntakeLog(
        id: id ?? this.id,
        scheduleId: scheduleId ?? this.scheduleId,
        medicationId: medicationId ?? this.medicationId,
        scheduledTime: scheduledTime ?? this.scheduledTime,
        status: status ?? this.status,
        confirmedAt: confirmedAt.present ? confirmedAt.value : this.confirmedAt,
        confirmedByUserId: confirmedByUserId.present
            ? confirmedByUserId.value
            : this.confirmedByUserId,
        note: note.present ? note.value : this.note,
      );
  MedicationIntakeLog copyWithCompanion(MedicationIntakeLogsCompanion data) {
    return MedicationIntakeLog(
      id: data.id.present ? data.id.value : this.id,
      scheduleId:
          data.scheduleId.present ? data.scheduleId.value : this.scheduleId,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      scheduledTime: data.scheduledTime.present
          ? data.scheduledTime.value
          : this.scheduledTime,
      status: data.status.present ? data.status.value : this.status,
      confirmedAt:
          data.confirmedAt.present ? data.confirmedAt.value : this.confirmedAt,
      confirmedByUserId: data.confirmedByUserId.present
          ? data.confirmedByUserId.value
          : this.confirmedByUserId,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationIntakeLog(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('medicationId: $medicationId, ')
          ..write('scheduledTime: $scheduledTime, ')
          ..write('status: $status, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('confirmedByUserId: $confirmedByUserId, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scheduleId, medicationId, scheduledTime,
      status, confirmedAt, confirmedByUserId, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationIntakeLog &&
          other.id == this.id &&
          other.scheduleId == this.scheduleId &&
          other.medicationId == this.medicationId &&
          other.scheduledTime == this.scheduledTime &&
          other.status == this.status &&
          other.confirmedAt == this.confirmedAt &&
          other.confirmedByUserId == this.confirmedByUserId &&
          other.note == this.note);
}

class MedicationIntakeLogsCompanion
    extends UpdateCompanion<MedicationIntakeLog> {
  final Value<String> id;
  final Value<String> scheduleId;
  final Value<String> medicationId;
  final Value<DateTime> scheduledTime;
  final Value<String> status;
  final Value<DateTime?> confirmedAt;
  final Value<String?> confirmedByUserId;
  final Value<String?> note;
  final Value<int> rowid;
  const MedicationIntakeLogsCompanion({
    this.id = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.scheduledTime = const Value.absent(),
    this.status = const Value.absent(),
    this.confirmedAt = const Value.absent(),
    this.confirmedByUserId = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationIntakeLogsCompanion.insert({
    required String id,
    required String scheduleId,
    required String medicationId,
    required DateTime scheduledTime,
    required String status,
    this.confirmedAt = const Value.absent(),
    this.confirmedByUserId = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        scheduleId = Value(scheduleId),
        medicationId = Value(medicationId),
        scheduledTime = Value(scheduledTime),
        status = Value(status);
  static Insertable<MedicationIntakeLog> custom({
    Expression<String>? id,
    Expression<String>? scheduleId,
    Expression<String>? medicationId,
    Expression<DateTime>? scheduledTime,
    Expression<String>? status,
    Expression<DateTime>? confirmedAt,
    Expression<String>? confirmedByUserId,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (medicationId != null) 'medication_id': medicationId,
      if (scheduledTime != null) 'scheduled_time': scheduledTime,
      if (status != null) 'status': status,
      if (confirmedAt != null) 'confirmed_at': confirmedAt,
      if (confirmedByUserId != null) 'confirmed_by_user_id': confirmedByUserId,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationIntakeLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? scheduleId,
      Value<String>? medicationId,
      Value<DateTime>? scheduledTime,
      Value<String>? status,
      Value<DateTime?>? confirmedAt,
      Value<String?>? confirmedByUserId,
      Value<String?>? note,
      Value<int>? rowid}) {
    return MedicationIntakeLogsCompanion(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      medicationId: medicationId ?? this.medicationId,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      status: status ?? this.status,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      confirmedByUserId: confirmedByUserId ?? this.confirmedByUserId,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<String>(scheduleId.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<String>(medicationId.value);
    }
    if (scheduledTime.present) {
      map['scheduled_time'] = Variable<DateTime>(scheduledTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (confirmedAt.present) {
      map['confirmed_at'] = Variable<DateTime>(confirmedAt.value);
    }
    if (confirmedByUserId.present) {
      map['confirmed_by_user_id'] = Variable<String>(confirmedByUserId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationIntakeLogsCompanion(')
          ..write('id: $id, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('medicationId: $medicationId, ')
          ..write('scheduledTime: $scheduledTime, ')
          ..write('status: $status, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('confirmedByUserId: $confirmedByUserId, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProteinRestrictionWindowsTable extends ProteinRestrictionWindows
    with TableInfo<$ProteinRestrictionWindowsTable, ProteinRestrictionWindow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProteinRestrictionWindowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medicationIdMeta =
      const VerificationMeta('medicationId');
  @override
  late final GeneratedColumn<String> medicationId = GeneratedColumn<String>(
      'medication_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hoursBeforeDoseMeta =
      const VerificationMeta('hoursBeforeDose');
  @override
  late final GeneratedColumn<double> hoursBeforeDose = GeneratedColumn<double>(
      'hours_before_dose', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _hoursAfterDoseMeta =
      const VerificationMeta('hoursAfterDose');
  @override
  late final GeneratedColumn<double> hoursAfterDose = GeneratedColumn<double>(
      'hours_after_dose', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _prescribedByPhysicianMeta =
      const VerificationMeta('prescribedByPhysician');
  @override
  late final GeneratedColumn<bool> prescribedByPhysician =
      GeneratedColumn<bool>('prescribed_by_physician', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("prescribed_by_physician" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        medicationId,
        hoursBeforeDose,
        hoursAfterDose,
        prescribedByPhysician,
        active
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'protein_restriction_windows';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProteinRestrictionWindow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
          _medicationIdMeta,
          medicationId.isAcceptableOrUnknown(
              data['medication_id']!, _medicationIdMeta));
    } else if (isInserting) {
      context.missing(_medicationIdMeta);
    }
    if (data.containsKey('hours_before_dose')) {
      context.handle(
          _hoursBeforeDoseMeta,
          hoursBeforeDose.isAcceptableOrUnknown(
              data['hours_before_dose']!, _hoursBeforeDoseMeta));
    }
    if (data.containsKey('hours_after_dose')) {
      context.handle(
          _hoursAfterDoseMeta,
          hoursAfterDose.isAcceptableOrUnknown(
              data['hours_after_dose']!, _hoursAfterDoseMeta));
    }
    if (data.containsKey('prescribed_by_physician')) {
      context.handle(
          _prescribedByPhysicianMeta,
          prescribedByPhysician.isAcceptableOrUnknown(
              data['prescribed_by_physician']!, _prescribedByPhysicianMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProteinRestrictionWindow map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProteinRestrictionWindow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      medicationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medication_id'])!,
      hoursBeforeDose: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}hours_before_dose'])!,
      hoursAfterDose: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}hours_after_dose'])!,
      prescribedByPhysician: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}prescribed_by_physician'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
    );
  }

  @override
  $ProteinRestrictionWindowsTable createAlias(String alias) {
    return $ProteinRestrictionWindowsTable(attachedDatabase, alias);
  }
}

class ProteinRestrictionWindow extends DataClass
    implements Insertable<ProteinRestrictionWindow> {
  final String id;
  final String medicationId;
  final double hoursBeforeDose;
  final double hoursAfterDose;
  final bool prescribedByPhysician;
  final bool active;
  const ProteinRestrictionWindow(
      {required this.id,
      required this.medicationId,
      required this.hoursBeforeDose,
      required this.hoursAfterDose,
      required this.prescribedByPhysician,
      required this.active});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['medication_id'] = Variable<String>(medicationId);
    map['hours_before_dose'] = Variable<double>(hoursBeforeDose);
    map['hours_after_dose'] = Variable<double>(hoursAfterDose);
    map['prescribed_by_physician'] = Variable<bool>(prescribedByPhysician);
    map['active'] = Variable<bool>(active);
    return map;
  }

  ProteinRestrictionWindowsCompanion toCompanion(bool nullToAbsent) {
    return ProteinRestrictionWindowsCompanion(
      id: Value(id),
      medicationId: Value(medicationId),
      hoursBeforeDose: Value(hoursBeforeDose),
      hoursAfterDose: Value(hoursAfterDose),
      prescribedByPhysician: Value(prescribedByPhysician),
      active: Value(active),
    );
  }

  factory ProteinRestrictionWindow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProteinRestrictionWindow(
      id: serializer.fromJson<String>(json['id']),
      medicationId: serializer.fromJson<String>(json['medicationId']),
      hoursBeforeDose: serializer.fromJson<double>(json['hoursBeforeDose']),
      hoursAfterDose: serializer.fromJson<double>(json['hoursAfterDose']),
      prescribedByPhysician:
          serializer.fromJson<bool>(json['prescribedByPhysician']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'medicationId': serializer.toJson<String>(medicationId),
      'hoursBeforeDose': serializer.toJson<double>(hoursBeforeDose),
      'hoursAfterDose': serializer.toJson<double>(hoursAfterDose),
      'prescribedByPhysician': serializer.toJson<bool>(prescribedByPhysician),
      'active': serializer.toJson<bool>(active),
    };
  }

  ProteinRestrictionWindow copyWith(
          {String? id,
          String? medicationId,
          double? hoursBeforeDose,
          double? hoursAfterDose,
          bool? prescribedByPhysician,
          bool? active}) =>
      ProteinRestrictionWindow(
        id: id ?? this.id,
        medicationId: medicationId ?? this.medicationId,
        hoursBeforeDose: hoursBeforeDose ?? this.hoursBeforeDose,
        hoursAfterDose: hoursAfterDose ?? this.hoursAfterDose,
        prescribedByPhysician:
            prescribedByPhysician ?? this.prescribedByPhysician,
        active: active ?? this.active,
      );
  ProteinRestrictionWindow copyWithCompanion(
      ProteinRestrictionWindowsCompanion data) {
    return ProteinRestrictionWindow(
      id: data.id.present ? data.id.value : this.id,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      hoursBeforeDose: data.hoursBeforeDose.present
          ? data.hoursBeforeDose.value
          : this.hoursBeforeDose,
      hoursAfterDose: data.hoursAfterDose.present
          ? data.hoursAfterDose.value
          : this.hoursAfterDose,
      prescribedByPhysician: data.prescribedByPhysician.present
          ? data.prescribedByPhysician.value
          : this.prescribedByPhysician,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProteinRestrictionWindow(')
          ..write('id: $id, ')
          ..write('medicationId: $medicationId, ')
          ..write('hoursBeforeDose: $hoursBeforeDose, ')
          ..write('hoursAfterDose: $hoursAfterDose, ')
          ..write('prescribedByPhysician: $prescribedByPhysician, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, medicationId, hoursBeforeDose,
      hoursAfterDose, prescribedByPhysician, active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProteinRestrictionWindow &&
          other.id == this.id &&
          other.medicationId == this.medicationId &&
          other.hoursBeforeDose == this.hoursBeforeDose &&
          other.hoursAfterDose == this.hoursAfterDose &&
          other.prescribedByPhysician == this.prescribedByPhysician &&
          other.active == this.active);
}

class ProteinRestrictionWindowsCompanion
    extends UpdateCompanion<ProteinRestrictionWindow> {
  final Value<String> id;
  final Value<String> medicationId;
  final Value<double> hoursBeforeDose;
  final Value<double> hoursAfterDose;
  final Value<bool> prescribedByPhysician;
  final Value<bool> active;
  final Value<int> rowid;
  const ProteinRestrictionWindowsCompanion({
    this.id = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.hoursBeforeDose = const Value.absent(),
    this.hoursAfterDose = const Value.absent(),
    this.prescribedByPhysician = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProteinRestrictionWindowsCompanion.insert({
    required String id,
    required String medicationId,
    this.hoursBeforeDose = const Value.absent(),
    this.hoursAfterDose = const Value.absent(),
    this.prescribedByPhysician = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        medicationId = Value(medicationId);
  static Insertable<ProteinRestrictionWindow> custom({
    Expression<String>? id,
    Expression<String>? medicationId,
    Expression<double>? hoursBeforeDose,
    Expression<double>? hoursAfterDose,
    Expression<bool>? prescribedByPhysician,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicationId != null) 'medication_id': medicationId,
      if (hoursBeforeDose != null) 'hours_before_dose': hoursBeforeDose,
      if (hoursAfterDose != null) 'hours_after_dose': hoursAfterDose,
      if (prescribedByPhysician != null)
        'prescribed_by_physician': prescribedByPhysician,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProteinRestrictionWindowsCompanion copyWith(
      {Value<String>? id,
      Value<String>? medicationId,
      Value<double>? hoursBeforeDose,
      Value<double>? hoursAfterDose,
      Value<bool>? prescribedByPhysician,
      Value<bool>? active,
      Value<int>? rowid}) {
    return ProteinRestrictionWindowsCompanion(
      id: id ?? this.id,
      medicationId: medicationId ?? this.medicationId,
      hoursBeforeDose: hoursBeforeDose ?? this.hoursBeforeDose,
      hoursAfterDose: hoursAfterDose ?? this.hoursAfterDose,
      prescribedByPhysician:
          prescribedByPhysician ?? this.prescribedByPhysician,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<String>(medicationId.value);
    }
    if (hoursBeforeDose.present) {
      map['hours_before_dose'] = Variable<double>(hoursBeforeDose.value);
    }
    if (hoursAfterDose.present) {
      map['hours_after_dose'] = Variable<double>(hoursAfterDose.value);
    }
    if (prescribedByPhysician.present) {
      map['prescribed_by_physician'] =
          Variable<bool>(prescribedByPhysician.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProteinRestrictionWindowsCompanion(')
          ..write('id: $id, ')
          ..write('medicationId: $medicationId, ')
          ..write('hoursBeforeDose: $hoursBeforeDose, ')
          ..write('hoursAfterDose: $hoursAfterDose, ')
          ..write('prescribedByPhysician: $prescribedByPhysician, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CaregiverProfilesTable extends CaregiverProfiles
    with TableInfo<$CaregiverProfilesTable, CaregiverProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CaregiverProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relationshipToPatientMeta =
      const VerificationMeta('relationshipToPatient');
  @override
  late final GeneratedColumn<String> relationshipToPatient =
      GeneratedColumn<String>('relationship_to_patient', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, relationshipToPatient];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'caregiver_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<CaregiverProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('relationship_to_patient')) {
      context.handle(
          _relationshipToPatientMeta,
          relationshipToPatient.isAcceptableOrUnknown(
              data['relationship_to_patient']!, _relationshipToPatientMeta));
    } else if (isInserting) {
      context.missing(_relationshipToPatientMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaregiverProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaregiverProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      relationshipToPatient: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}relationship_to_patient'])!,
    );
  }

  @override
  $CaregiverProfilesTable createAlias(String alias) {
    return $CaregiverProfilesTable(attachedDatabase, alias);
  }
}

class CaregiverProfile extends DataClass
    implements Insertable<CaregiverProfile> {
  final String id;
  final String userId;
  final String relationshipToPatient;
  const CaregiverProfile(
      {required this.id,
      required this.userId,
      required this.relationshipToPatient});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['relationship_to_patient'] = Variable<String>(relationshipToPatient);
    return map;
  }

  CaregiverProfilesCompanion toCompanion(bool nullToAbsent) {
    return CaregiverProfilesCompanion(
      id: Value(id),
      userId: Value(userId),
      relationshipToPatient: Value(relationshipToPatient),
    );
  }

  factory CaregiverProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaregiverProfile(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      relationshipToPatient:
          serializer.fromJson<String>(json['relationshipToPatient']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'relationshipToPatient': serializer.toJson<String>(relationshipToPatient),
    };
  }

  CaregiverProfile copyWith(
          {String? id, String? userId, String? relationshipToPatient}) =>
      CaregiverProfile(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        relationshipToPatient:
            relationshipToPatient ?? this.relationshipToPatient,
      );
  CaregiverProfile copyWithCompanion(CaregiverProfilesCompanion data) {
    return CaregiverProfile(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      relationshipToPatient: data.relationshipToPatient.present
          ? data.relationshipToPatient.value
          : this.relationshipToPatient,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaregiverProfile(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('relationshipToPatient: $relationshipToPatient')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, relationshipToPatient);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaregiverProfile &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.relationshipToPatient == this.relationshipToPatient);
}

class CaregiverProfilesCompanion extends UpdateCompanion<CaregiverProfile> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> relationshipToPatient;
  final Value<int> rowid;
  const CaregiverProfilesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.relationshipToPatient = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CaregiverProfilesCompanion.insert({
    required String id,
    required String userId,
    required String relationshipToPatient,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        relationshipToPatient = Value(relationshipToPatient);
  static Insertable<CaregiverProfile> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? relationshipToPatient,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (relationshipToPatient != null)
        'relationship_to_patient': relationshipToPatient,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CaregiverProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? relationshipToPatient,
      Value<int>? rowid}) {
    return CaregiverProfilesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      relationshipToPatient:
          relationshipToPatient ?? this.relationshipToPatient,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (relationshipToPatient.present) {
      map['relationship_to_patient'] =
          Variable<String>(relationshipToPatient.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CaregiverProfilesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('relationshipToPatient: $relationshipToPatient, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConsentGrantsTable extends ConsentGrants
    with TableInfo<$ConsentGrantsTable, ConsentGrant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsentGrantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _caregiverIdMeta =
      const VerificationMeta('caregiverId');
  @override
  late final GeneratedColumn<String> caregiverId = GeneratedColumn<String>(
      'caregiver_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scopesMeta = const VerificationMeta('scopes');
  @override
  late final GeneratedColumn<String> scopes = GeneratedColumn<String>(
      'scopes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _grantedAtMeta =
      const VerificationMeta('grantedAt');
  @override
  late final GeneratedColumn<DateTime> grantedAt = GeneratedColumn<DateTime>(
      'granted_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _revokedAtMeta =
      const VerificationMeta('revokedAt');
  @override
  late final GeneratedColumn<DateTime> revokedAt = GeneratedColumn<DateTime>(
      'revoked_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, patientId, caregiverId, scopes, grantedAt, revokedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consent_grants';
  @override
  VerificationContext validateIntegrity(Insertable<ConsentGrant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('caregiver_id')) {
      context.handle(
          _caregiverIdMeta,
          caregiverId.isAcceptableOrUnknown(
              data['caregiver_id']!, _caregiverIdMeta));
    } else if (isInserting) {
      context.missing(_caregiverIdMeta);
    }
    if (data.containsKey('scopes')) {
      context.handle(_scopesMeta,
          scopes.isAcceptableOrUnknown(data['scopes']!, _scopesMeta));
    } else if (isInserting) {
      context.missing(_scopesMeta);
    }
    if (data.containsKey('granted_at')) {
      context.handle(_grantedAtMeta,
          grantedAt.isAcceptableOrUnknown(data['granted_at']!, _grantedAtMeta));
    } else if (isInserting) {
      context.missing(_grantedAtMeta);
    }
    if (data.containsKey('revoked_at')) {
      context.handle(_revokedAtMeta,
          revokedAt.isAcceptableOrUnknown(data['revoked_at']!, _revokedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConsentGrant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsentGrant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      caregiverId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caregiver_id'])!,
      scopes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scopes'])!,
      grantedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}granted_at'])!,
      revokedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}revoked_at']),
    );
  }

  @override
  $ConsentGrantsTable createAlias(String alias) {
    return $ConsentGrantsTable(attachedDatabase, alias);
  }
}

class ConsentGrant extends DataClass implements Insertable<ConsentGrant> {
  final String id;
  final String patientId;
  final String caregiverId;

  /// Vesszővel elválasztott [ConsentScope].name lista.
  final String scopes;
  final DateTime grantedAt;
  final DateTime? revokedAt;
  const ConsentGrant(
      {required this.id,
      required this.patientId,
      required this.caregiverId,
      required this.scopes,
      required this.grantedAt,
      this.revokedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['caregiver_id'] = Variable<String>(caregiverId);
    map['scopes'] = Variable<String>(scopes);
    map['granted_at'] = Variable<DateTime>(grantedAt);
    if (!nullToAbsent || revokedAt != null) {
      map['revoked_at'] = Variable<DateTime>(revokedAt);
    }
    return map;
  }

  ConsentGrantsCompanion toCompanion(bool nullToAbsent) {
    return ConsentGrantsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      caregiverId: Value(caregiverId),
      scopes: Value(scopes),
      grantedAt: Value(grantedAt),
      revokedAt: revokedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(revokedAt),
    );
  }

  factory ConsentGrant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsentGrant(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      caregiverId: serializer.fromJson<String>(json['caregiverId']),
      scopes: serializer.fromJson<String>(json['scopes']),
      grantedAt: serializer.fromJson<DateTime>(json['grantedAt']),
      revokedAt: serializer.fromJson<DateTime?>(json['revokedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'caregiverId': serializer.toJson<String>(caregiverId),
      'scopes': serializer.toJson<String>(scopes),
      'grantedAt': serializer.toJson<DateTime>(grantedAt),
      'revokedAt': serializer.toJson<DateTime?>(revokedAt),
    };
  }

  ConsentGrant copyWith(
          {String? id,
          String? patientId,
          String? caregiverId,
          String? scopes,
          DateTime? grantedAt,
          Value<DateTime?> revokedAt = const Value.absent()}) =>
      ConsentGrant(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        caregiverId: caregiverId ?? this.caregiverId,
        scopes: scopes ?? this.scopes,
        grantedAt: grantedAt ?? this.grantedAt,
        revokedAt: revokedAt.present ? revokedAt.value : this.revokedAt,
      );
  ConsentGrant copyWithCompanion(ConsentGrantsCompanion data) {
    return ConsentGrant(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      caregiverId:
          data.caregiverId.present ? data.caregiverId.value : this.caregiverId,
      scopes: data.scopes.present ? data.scopes.value : this.scopes,
      grantedAt: data.grantedAt.present ? data.grantedAt.value : this.grantedAt,
      revokedAt: data.revokedAt.present ? data.revokedAt.value : this.revokedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsentGrant(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('caregiverId: $caregiverId, ')
          ..write('scopes: $scopes, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('revokedAt: $revokedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patientId, caregiverId, scopes, grantedAt, revokedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsentGrant &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.caregiverId == this.caregiverId &&
          other.scopes == this.scopes &&
          other.grantedAt == this.grantedAt &&
          other.revokedAt == this.revokedAt);
}

class ConsentGrantsCompanion extends UpdateCompanion<ConsentGrant> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> caregiverId;
  final Value<String> scopes;
  final Value<DateTime> grantedAt;
  final Value<DateTime?> revokedAt;
  final Value<int> rowid;
  const ConsentGrantsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.caregiverId = const Value.absent(),
    this.scopes = const Value.absent(),
    this.grantedAt = const Value.absent(),
    this.revokedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConsentGrantsCompanion.insert({
    required String id,
    required String patientId,
    required String caregiverId,
    required String scopes,
    required DateTime grantedAt,
    this.revokedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        caregiverId = Value(caregiverId),
        scopes = Value(scopes),
        grantedAt = Value(grantedAt);
  static Insertable<ConsentGrant> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? caregiverId,
    Expression<String>? scopes,
    Expression<DateTime>? grantedAt,
    Expression<DateTime>? revokedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (caregiverId != null) 'caregiver_id': caregiverId,
      if (scopes != null) 'scopes': scopes,
      if (grantedAt != null) 'granted_at': grantedAt,
      if (revokedAt != null) 'revoked_at': revokedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConsentGrantsCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? caregiverId,
      Value<String>? scopes,
      Value<DateTime>? grantedAt,
      Value<DateTime?>? revokedAt,
      Value<int>? rowid}) {
    return ConsentGrantsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      caregiverId: caregiverId ?? this.caregiverId,
      scopes: scopes ?? this.scopes,
      grantedAt: grantedAt ?? this.grantedAt,
      revokedAt: revokedAt ?? this.revokedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (caregiverId.present) {
      map['caregiver_id'] = Variable<String>(caregiverId.value);
    }
    if (scopes.present) {
      map['scopes'] = Variable<String>(scopes.value);
    }
    if (grantedAt.present) {
      map['granted_at'] = Variable<DateTime>(grantedAt.value);
    }
    if (revokedAt.present) {
      map['revoked_at'] = Variable<DateTime>(revokedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsentGrantsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('caregiverId: $caregiverId, ')
          ..write('scopes: $scopes, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('revokedAt: $revokedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SymptomLogsTable extends SymptomLogs
    with TableInfo<$SymptomLogsTable, SymptomLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tremorSeverityMeta =
      const VerificationMeta('tremorSeverity');
  @override
  late final GeneratedColumn<int> tremorSeverity = GeneratedColumn<int>(
      'tremor_severity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bradykinesiaMeta =
      const VerificationMeta('bradykinesia');
  @override
  late final GeneratedColumn<int> bradykinesia = GeneratedColumn<int>(
      'bradykinesia', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _rigidityMeta =
      const VerificationMeta('rigidity');
  @override
  late final GeneratedColumn<int> rigidity = GeneratedColumn<int>(
      'rigidity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _balanceIssueMeta =
      const VerificationMeta('balanceIssue');
  @override
  late final GeneratedColumn<bool> balanceIssue = GeneratedColumn<bool>(
      'balance_issue', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("balance_issue" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _fallOccurredMeta =
      const VerificationMeta('fallOccurred');
  @override
  late final GeneratedColumn<bool> fallOccurred = GeneratedColumn<bool>(
      'fall_occurred', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("fall_occurred" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _motorStateMeta =
      const VerificationMeta('motorState');
  @override
  late final GeneratedColumn<String> motorState = GeneratedColumn<String>(
      'motor_state', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _wearingOffObservedMeta =
      const VerificationMeta('wearingOffObserved');
  @override
  late final GeneratedColumn<bool> wearingOffObserved = GeneratedColumn<bool>(
      'wearing_off_observed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("wearing_off_observed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _dyskinesiaObservedMeta =
      const VerificationMeta('dyskinesiaObserved');
  @override
  late final GeneratedColumn<bool> dyskinesiaObserved = GeneratedColumn<bool>(
      'dyskinesia_observed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("dyskinesia_observed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _freezingOfGaitObservedMeta =
      const VerificationMeta('freezingOfGaitObserved');
  @override
  late final GeneratedColumn<bool> freezingOfGaitObserved =
      GeneratedColumn<bool>('freezing_of_gait_observed', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("freezing_of_gait_observed" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _sleepQualityMeta =
      const VerificationMeta('sleepQuality');
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
      'sleep_quality', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
      'mood', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _overallDayRatingMeta =
      const VerificationMeta('overallDayRating');
  @override
  late final GeneratedColumn<String> overallDayRating = GeneratedColumn<String>(
      'overall_day_rating', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        timestamp,
        tremorSeverity,
        bradykinesia,
        rigidity,
        balanceIssue,
        fallOccurred,
        motorState,
        wearingOffObserved,
        dyskinesiaObserved,
        freezingOfGaitObserved,
        sleepQuality,
        mood,
        overallDayRating,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('tremor_severity')) {
      context.handle(
          _tremorSeverityMeta,
          tremorSeverity.isAcceptableOrUnknown(
              data['tremor_severity']!, _tremorSeverityMeta));
    }
    if (data.containsKey('bradykinesia')) {
      context.handle(
          _bradykinesiaMeta,
          bradykinesia.isAcceptableOrUnknown(
              data['bradykinesia']!, _bradykinesiaMeta));
    }
    if (data.containsKey('rigidity')) {
      context.handle(_rigidityMeta,
          rigidity.isAcceptableOrUnknown(data['rigidity']!, _rigidityMeta));
    }
    if (data.containsKey('balance_issue')) {
      context.handle(
          _balanceIssueMeta,
          balanceIssue.isAcceptableOrUnknown(
              data['balance_issue']!, _balanceIssueMeta));
    }
    if (data.containsKey('fall_occurred')) {
      context.handle(
          _fallOccurredMeta,
          fallOccurred.isAcceptableOrUnknown(
              data['fall_occurred']!, _fallOccurredMeta));
    }
    if (data.containsKey('motor_state')) {
      context.handle(
          _motorStateMeta,
          motorState.isAcceptableOrUnknown(
              data['motor_state']!, _motorStateMeta));
    }
    if (data.containsKey('wearing_off_observed')) {
      context.handle(
          _wearingOffObservedMeta,
          wearingOffObserved.isAcceptableOrUnknown(
              data['wearing_off_observed']!, _wearingOffObservedMeta));
    }
    if (data.containsKey('dyskinesia_observed')) {
      context.handle(
          _dyskinesiaObservedMeta,
          dyskinesiaObserved.isAcceptableOrUnknown(
              data['dyskinesia_observed']!, _dyskinesiaObservedMeta));
    }
    if (data.containsKey('freezing_of_gait_observed')) {
      context.handle(
          _freezingOfGaitObservedMeta,
          freezingOfGaitObserved.isAcceptableOrUnknown(
              data['freezing_of_gait_observed']!, _freezingOfGaitObservedMeta));
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
          _sleepQualityMeta,
          sleepQuality.isAcceptableOrUnknown(
              data['sleep_quality']!, _sleepQualityMeta));
    }
    if (data.containsKey('mood')) {
      context.handle(
          _moodMeta, mood.isAcceptableOrUnknown(data['mood']!, _moodMeta));
    }
    if (data.containsKey('overall_day_rating')) {
      context.handle(
          _overallDayRatingMeta,
          overallDayRating.isAcceptableOrUnknown(
              data['overall_day_rating']!, _overallDayRatingMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      tremorSeverity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tremor_severity']),
      bradykinesia: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bradykinesia']),
      rigidity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rigidity']),
      balanceIssue: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}balance_issue'])!,
      fallOccurred: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}fall_occurred'])!,
      motorState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}motor_state']),
      wearingOffObserved: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}wearing_off_observed'])!,
      dyskinesiaObserved: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}dyskinesia_observed'])!,
      freezingOfGaitObserved: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}freezing_of_gait_observed'])!,
      sleepQuality: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_quality']),
      mood: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mood']),
      overallDayRating: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}overall_day_rating']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $SymptomLogsTable createAlias(String alias) {
    return $SymptomLogsTable(attachedDatabase, alias);
  }
}

class SymptomLog extends DataClass implements Insertable<SymptomLog> {
  final String id;
  final String patientId;
  final DateTime timestamp;
  final int? tremorSeverity;
  final int? bradykinesia;
  final int? rigidity;
  final bool balanceIssue;
  final bool fallOccurred;

  /// [MotorState].name, nullable
  final String? motorState;
  final bool wearingOffObserved;
  final bool dyskinesiaObserved;
  final bool freezingOfGaitObserved;
  final int? sleepQuality;
  final int? mood;

  /// [DayRating].name, nullable
  final String? overallDayRating;
  final String? note;
  const SymptomLog(
      {required this.id,
      required this.patientId,
      required this.timestamp,
      this.tremorSeverity,
      this.bradykinesia,
      this.rigidity,
      required this.balanceIssue,
      required this.fallOccurred,
      this.motorState,
      required this.wearingOffObserved,
      required this.dyskinesiaObserved,
      required this.freezingOfGaitObserved,
      this.sleepQuality,
      this.mood,
      this.overallDayRating,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || tremorSeverity != null) {
      map['tremor_severity'] = Variable<int>(tremorSeverity);
    }
    if (!nullToAbsent || bradykinesia != null) {
      map['bradykinesia'] = Variable<int>(bradykinesia);
    }
    if (!nullToAbsent || rigidity != null) {
      map['rigidity'] = Variable<int>(rigidity);
    }
    map['balance_issue'] = Variable<bool>(balanceIssue);
    map['fall_occurred'] = Variable<bool>(fallOccurred);
    if (!nullToAbsent || motorState != null) {
      map['motor_state'] = Variable<String>(motorState);
    }
    map['wearing_off_observed'] = Variable<bool>(wearingOffObserved);
    map['dyskinesia_observed'] = Variable<bool>(dyskinesiaObserved);
    map['freezing_of_gait_observed'] = Variable<bool>(freezingOfGaitObserved);
    if (!nullToAbsent || sleepQuality != null) {
      map['sleep_quality'] = Variable<int>(sleepQuality);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<int>(mood);
    }
    if (!nullToAbsent || overallDayRating != null) {
      map['overall_day_rating'] = Variable<String>(overallDayRating);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SymptomLogsCompanion toCompanion(bool nullToAbsent) {
    return SymptomLogsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      timestamp: Value(timestamp),
      tremorSeverity: tremorSeverity == null && nullToAbsent
          ? const Value.absent()
          : Value(tremorSeverity),
      bradykinesia: bradykinesia == null && nullToAbsent
          ? const Value.absent()
          : Value(bradykinesia),
      rigidity: rigidity == null && nullToAbsent
          ? const Value.absent()
          : Value(rigidity),
      balanceIssue: Value(balanceIssue),
      fallOccurred: Value(fallOccurred),
      motorState: motorState == null && nullToAbsent
          ? const Value.absent()
          : Value(motorState),
      wearingOffObserved: Value(wearingOffObserved),
      dyskinesiaObserved: Value(dyskinesiaObserved),
      freezingOfGaitObserved: Value(freezingOfGaitObserved),
      sleepQuality: sleepQuality == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepQuality),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      overallDayRating: overallDayRating == null && nullToAbsent
          ? const Value.absent()
          : Value(overallDayRating),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory SymptomLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomLog(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      tremorSeverity: serializer.fromJson<int?>(json['tremorSeverity']),
      bradykinesia: serializer.fromJson<int?>(json['bradykinesia']),
      rigidity: serializer.fromJson<int?>(json['rigidity']),
      balanceIssue: serializer.fromJson<bool>(json['balanceIssue']),
      fallOccurred: serializer.fromJson<bool>(json['fallOccurred']),
      motorState: serializer.fromJson<String?>(json['motorState']),
      wearingOffObserved: serializer.fromJson<bool>(json['wearingOffObserved']),
      dyskinesiaObserved: serializer.fromJson<bool>(json['dyskinesiaObserved']),
      freezingOfGaitObserved:
          serializer.fromJson<bool>(json['freezingOfGaitObserved']),
      sleepQuality: serializer.fromJson<int?>(json['sleepQuality']),
      mood: serializer.fromJson<int?>(json['mood']),
      overallDayRating: serializer.fromJson<String?>(json['overallDayRating']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'tremorSeverity': serializer.toJson<int?>(tremorSeverity),
      'bradykinesia': serializer.toJson<int?>(bradykinesia),
      'rigidity': serializer.toJson<int?>(rigidity),
      'balanceIssue': serializer.toJson<bool>(balanceIssue),
      'fallOccurred': serializer.toJson<bool>(fallOccurred),
      'motorState': serializer.toJson<String?>(motorState),
      'wearingOffObserved': serializer.toJson<bool>(wearingOffObserved),
      'dyskinesiaObserved': serializer.toJson<bool>(dyskinesiaObserved),
      'freezingOfGaitObserved': serializer.toJson<bool>(freezingOfGaitObserved),
      'sleepQuality': serializer.toJson<int?>(sleepQuality),
      'mood': serializer.toJson<int?>(mood),
      'overallDayRating': serializer.toJson<String?>(overallDayRating),
      'note': serializer.toJson<String?>(note),
    };
  }

  SymptomLog copyWith(
          {String? id,
          String? patientId,
          DateTime? timestamp,
          Value<int?> tremorSeverity = const Value.absent(),
          Value<int?> bradykinesia = const Value.absent(),
          Value<int?> rigidity = const Value.absent(),
          bool? balanceIssue,
          bool? fallOccurred,
          Value<String?> motorState = const Value.absent(),
          bool? wearingOffObserved,
          bool? dyskinesiaObserved,
          bool? freezingOfGaitObserved,
          Value<int?> sleepQuality = const Value.absent(),
          Value<int?> mood = const Value.absent(),
          Value<String?> overallDayRating = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      SymptomLog(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        timestamp: timestamp ?? this.timestamp,
        tremorSeverity:
            tremorSeverity.present ? tremorSeverity.value : this.tremorSeverity,
        bradykinesia:
            bradykinesia.present ? bradykinesia.value : this.bradykinesia,
        rigidity: rigidity.present ? rigidity.value : this.rigidity,
        balanceIssue: balanceIssue ?? this.balanceIssue,
        fallOccurred: fallOccurred ?? this.fallOccurred,
        motorState: motorState.present ? motorState.value : this.motorState,
        wearingOffObserved: wearingOffObserved ?? this.wearingOffObserved,
        dyskinesiaObserved: dyskinesiaObserved ?? this.dyskinesiaObserved,
        freezingOfGaitObserved:
            freezingOfGaitObserved ?? this.freezingOfGaitObserved,
        sleepQuality:
            sleepQuality.present ? sleepQuality.value : this.sleepQuality,
        mood: mood.present ? mood.value : this.mood,
        overallDayRating: overallDayRating.present
            ? overallDayRating.value
            : this.overallDayRating,
        note: note.present ? note.value : this.note,
      );
  SymptomLog copyWithCompanion(SymptomLogsCompanion data) {
    return SymptomLog(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      tremorSeverity: data.tremorSeverity.present
          ? data.tremorSeverity.value
          : this.tremorSeverity,
      bradykinesia: data.bradykinesia.present
          ? data.bradykinesia.value
          : this.bradykinesia,
      rigidity: data.rigidity.present ? data.rigidity.value : this.rigidity,
      balanceIssue: data.balanceIssue.present
          ? data.balanceIssue.value
          : this.balanceIssue,
      fallOccurred: data.fallOccurred.present
          ? data.fallOccurred.value
          : this.fallOccurred,
      motorState:
          data.motorState.present ? data.motorState.value : this.motorState,
      wearingOffObserved: data.wearingOffObserved.present
          ? data.wearingOffObserved.value
          : this.wearingOffObserved,
      dyskinesiaObserved: data.dyskinesiaObserved.present
          ? data.dyskinesiaObserved.value
          : this.dyskinesiaObserved,
      freezingOfGaitObserved: data.freezingOfGaitObserved.present
          ? data.freezingOfGaitObserved.value
          : this.freezingOfGaitObserved,
      sleepQuality: data.sleepQuality.present
          ? data.sleepQuality.value
          : this.sleepQuality,
      mood: data.mood.present ? data.mood.value : this.mood,
      overallDayRating: data.overallDayRating.present
          ? data.overallDayRating.value
          : this.overallDayRating,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomLog(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('timestamp: $timestamp, ')
          ..write('tremorSeverity: $tremorSeverity, ')
          ..write('bradykinesia: $bradykinesia, ')
          ..write('rigidity: $rigidity, ')
          ..write('balanceIssue: $balanceIssue, ')
          ..write('fallOccurred: $fallOccurred, ')
          ..write('motorState: $motorState, ')
          ..write('wearingOffObserved: $wearingOffObserved, ')
          ..write('dyskinesiaObserved: $dyskinesiaObserved, ')
          ..write('freezingOfGaitObserved: $freezingOfGaitObserved, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('mood: $mood, ')
          ..write('overallDayRating: $overallDayRating, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      patientId,
      timestamp,
      tremorSeverity,
      bradykinesia,
      rigidity,
      balanceIssue,
      fallOccurred,
      motorState,
      wearingOffObserved,
      dyskinesiaObserved,
      freezingOfGaitObserved,
      sleepQuality,
      mood,
      overallDayRating,
      note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomLog &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.timestamp == this.timestamp &&
          other.tremorSeverity == this.tremorSeverity &&
          other.bradykinesia == this.bradykinesia &&
          other.rigidity == this.rigidity &&
          other.balanceIssue == this.balanceIssue &&
          other.fallOccurred == this.fallOccurred &&
          other.motorState == this.motorState &&
          other.wearingOffObserved == this.wearingOffObserved &&
          other.dyskinesiaObserved == this.dyskinesiaObserved &&
          other.freezingOfGaitObserved == this.freezingOfGaitObserved &&
          other.sleepQuality == this.sleepQuality &&
          other.mood == this.mood &&
          other.overallDayRating == this.overallDayRating &&
          other.note == this.note);
}

class SymptomLogsCompanion extends UpdateCompanion<SymptomLog> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<DateTime> timestamp;
  final Value<int?> tremorSeverity;
  final Value<int?> bradykinesia;
  final Value<int?> rigidity;
  final Value<bool> balanceIssue;
  final Value<bool> fallOccurred;
  final Value<String?> motorState;
  final Value<bool> wearingOffObserved;
  final Value<bool> dyskinesiaObserved;
  final Value<bool> freezingOfGaitObserved;
  final Value<int?> sleepQuality;
  final Value<int?> mood;
  final Value<String?> overallDayRating;
  final Value<String?> note;
  final Value<int> rowid;
  const SymptomLogsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.tremorSeverity = const Value.absent(),
    this.bradykinesia = const Value.absent(),
    this.rigidity = const Value.absent(),
    this.balanceIssue = const Value.absent(),
    this.fallOccurred = const Value.absent(),
    this.motorState = const Value.absent(),
    this.wearingOffObserved = const Value.absent(),
    this.dyskinesiaObserved = const Value.absent(),
    this.freezingOfGaitObserved = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.mood = const Value.absent(),
    this.overallDayRating = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SymptomLogsCompanion.insert({
    required String id,
    required String patientId,
    required DateTime timestamp,
    this.tremorSeverity = const Value.absent(),
    this.bradykinesia = const Value.absent(),
    this.rigidity = const Value.absent(),
    this.balanceIssue = const Value.absent(),
    this.fallOccurred = const Value.absent(),
    this.motorState = const Value.absent(),
    this.wearingOffObserved = const Value.absent(),
    this.dyskinesiaObserved = const Value.absent(),
    this.freezingOfGaitObserved = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.mood = const Value.absent(),
    this.overallDayRating = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        timestamp = Value(timestamp);
  static Insertable<SymptomLog> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<DateTime>? timestamp,
    Expression<int>? tremorSeverity,
    Expression<int>? bradykinesia,
    Expression<int>? rigidity,
    Expression<bool>? balanceIssue,
    Expression<bool>? fallOccurred,
    Expression<String>? motorState,
    Expression<bool>? wearingOffObserved,
    Expression<bool>? dyskinesiaObserved,
    Expression<bool>? freezingOfGaitObserved,
    Expression<int>? sleepQuality,
    Expression<int>? mood,
    Expression<String>? overallDayRating,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (timestamp != null) 'timestamp': timestamp,
      if (tremorSeverity != null) 'tremor_severity': tremorSeverity,
      if (bradykinesia != null) 'bradykinesia': bradykinesia,
      if (rigidity != null) 'rigidity': rigidity,
      if (balanceIssue != null) 'balance_issue': balanceIssue,
      if (fallOccurred != null) 'fall_occurred': fallOccurred,
      if (motorState != null) 'motor_state': motorState,
      if (wearingOffObserved != null)
        'wearing_off_observed': wearingOffObserved,
      if (dyskinesiaObserved != null) 'dyskinesia_observed': dyskinesiaObserved,
      if (freezingOfGaitObserved != null)
        'freezing_of_gait_observed': freezingOfGaitObserved,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (mood != null) 'mood': mood,
      if (overallDayRating != null) 'overall_day_rating': overallDayRating,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SymptomLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<DateTime>? timestamp,
      Value<int?>? tremorSeverity,
      Value<int?>? bradykinesia,
      Value<int?>? rigidity,
      Value<bool>? balanceIssue,
      Value<bool>? fallOccurred,
      Value<String?>? motorState,
      Value<bool>? wearingOffObserved,
      Value<bool>? dyskinesiaObserved,
      Value<bool>? freezingOfGaitObserved,
      Value<int?>? sleepQuality,
      Value<int?>? mood,
      Value<String?>? overallDayRating,
      Value<String?>? note,
      Value<int>? rowid}) {
    return SymptomLogsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      timestamp: timestamp ?? this.timestamp,
      tremorSeverity: tremorSeverity ?? this.tremorSeverity,
      bradykinesia: bradykinesia ?? this.bradykinesia,
      rigidity: rigidity ?? this.rigidity,
      balanceIssue: balanceIssue ?? this.balanceIssue,
      fallOccurred: fallOccurred ?? this.fallOccurred,
      motorState: motorState ?? this.motorState,
      wearingOffObserved: wearingOffObserved ?? this.wearingOffObserved,
      dyskinesiaObserved: dyskinesiaObserved ?? this.dyskinesiaObserved,
      freezingOfGaitObserved:
          freezingOfGaitObserved ?? this.freezingOfGaitObserved,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      mood: mood ?? this.mood,
      overallDayRating: overallDayRating ?? this.overallDayRating,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (tremorSeverity.present) {
      map['tremor_severity'] = Variable<int>(tremorSeverity.value);
    }
    if (bradykinesia.present) {
      map['bradykinesia'] = Variable<int>(bradykinesia.value);
    }
    if (rigidity.present) {
      map['rigidity'] = Variable<int>(rigidity.value);
    }
    if (balanceIssue.present) {
      map['balance_issue'] = Variable<bool>(balanceIssue.value);
    }
    if (fallOccurred.present) {
      map['fall_occurred'] = Variable<bool>(fallOccurred.value);
    }
    if (motorState.present) {
      map['motor_state'] = Variable<String>(motorState.value);
    }
    if (wearingOffObserved.present) {
      map['wearing_off_observed'] = Variable<bool>(wearingOffObserved.value);
    }
    if (dyskinesiaObserved.present) {
      map['dyskinesia_observed'] = Variable<bool>(dyskinesiaObserved.value);
    }
    if (freezingOfGaitObserved.present) {
      map['freezing_of_gait_observed'] =
          Variable<bool>(freezingOfGaitObserved.value);
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (overallDayRating.present) {
      map['overall_day_rating'] = Variable<String>(overallDayRating.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomLogsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('timestamp: $timestamp, ')
          ..write('tremorSeverity: $tremorSeverity, ')
          ..write('bradykinesia: $bradykinesia, ')
          ..write('rigidity: $rigidity, ')
          ..write('balanceIssue: $balanceIssue, ')
          ..write('fallOccurred: $fallOccurred, ')
          ..write('motorState: $motorState, ')
          ..write('wearingOffObserved: $wearingOffObserved, ')
          ..write('dyskinesiaObserved: $dyskinesiaObserved, ')
          ..write('freezingOfGaitObserved: $freezingOfGaitObserved, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('mood: $mood, ')
          ..write('overallDayRating: $overallDayRating, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationPreferencesTable extends NotificationPreferences
    with TableInfo<$NotificationPreferencesTable, NotificationPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _repeatIntervalMinutesMeta =
      const VerificationMeta('repeatIntervalMinutes');
  @override
  late final GeneratedColumn<int> repeatIntervalMinutes = GeneratedColumn<int>(
      'repeat_interval_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(7));
  static const VerificationMeta _maxDelayMinutesMeta =
      const VerificationMeta('maxDelayMinutes');
  @override
  late final GeneratedColumn<int> maxDelayMinutes = GeneratedColumn<int>(
      'max_delay_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(45));
  static const VerificationMeta _caregiverEscalationThresholdMinutesMeta =
      const VerificationMeta('caregiverEscalationThresholdMinutes');
  @override
  late final GeneratedColumn<int> caregiverEscalationThresholdMinutes =
      GeneratedColumn<int>(
          'caregiver_escalation_threshold_minutes', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(45));
  static const VerificationMeta _quietHoursStartHourMeta =
      const VerificationMeta('quietHoursStartHour');
  @override
  late final GeneratedColumn<int> quietHoursStartHour = GeneratedColumn<int>(
      'quiet_hours_start_hour', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quietHoursStartMinuteMeta =
      const VerificationMeta('quietHoursStartMinute');
  @override
  late final GeneratedColumn<int> quietHoursStartMinute = GeneratedColumn<int>(
      'quiet_hours_start_minute', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quietHoursEndHourMeta =
      const VerificationMeta('quietHoursEndHour');
  @override
  late final GeneratedColumn<int> quietHoursEndHour = GeneratedColumn<int>(
      'quiet_hours_end_hour', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _quietHoursEndMinuteMeta =
      const VerificationMeta('quietHoursEndMinute');
  @override
  late final GeneratedColumn<int> quietHoursEndMinute = GeneratedColumn<int>(
      'quiet_hours_end_minute', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _criticalAlertsGrantedMeta =
      const VerificationMeta('criticalAlertsGranted');
  @override
  late final GeneratedColumn<bool> criticalAlertsGranted =
      GeneratedColumn<bool>('critical_alerts_granted', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("critical_alerts_granted" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _exactAlarmGrantedMeta =
      const VerificationMeta('exactAlarmGranted');
  @override
  late final GeneratedColumn<bool> exactAlarmGranted = GeneratedColumn<bool>(
      'exact_alarm_granted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("exact_alarm_granted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _batteryOptimizationExemptMeta =
      const VerificationMeta('batteryOptimizationExempt');
  @override
  late final GeneratedColumn<bool> batteryOptimizationExempt =
      GeneratedColumn<bool>('battery_optimization_exempt', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("battery_optimization_exempt" IN (0, 1))'),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        repeatIntervalMinutes,
        maxDelayMinutes,
        caregiverEscalationThresholdMinutes,
        quietHoursStartHour,
        quietHoursStartMinute,
        quietHoursEndHour,
        quietHoursEndMinute,
        criticalAlertsGranted,
        exactAlarmGranted,
        batteryOptimizationExempt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_preferences';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotificationPreference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('repeat_interval_minutes')) {
      context.handle(
          _repeatIntervalMinutesMeta,
          repeatIntervalMinutes.isAcceptableOrUnknown(
              data['repeat_interval_minutes']!, _repeatIntervalMinutesMeta));
    }
    if (data.containsKey('max_delay_minutes')) {
      context.handle(
          _maxDelayMinutesMeta,
          maxDelayMinutes.isAcceptableOrUnknown(
              data['max_delay_minutes']!, _maxDelayMinutesMeta));
    }
    if (data.containsKey('caregiver_escalation_threshold_minutes')) {
      context.handle(
          _caregiverEscalationThresholdMinutesMeta,
          caregiverEscalationThresholdMinutes.isAcceptableOrUnknown(
              data['caregiver_escalation_threshold_minutes']!,
              _caregiverEscalationThresholdMinutesMeta));
    }
    if (data.containsKey('quiet_hours_start_hour')) {
      context.handle(
          _quietHoursStartHourMeta,
          quietHoursStartHour.isAcceptableOrUnknown(
              data['quiet_hours_start_hour']!, _quietHoursStartHourMeta));
    }
    if (data.containsKey('quiet_hours_start_minute')) {
      context.handle(
          _quietHoursStartMinuteMeta,
          quietHoursStartMinute.isAcceptableOrUnknown(
              data['quiet_hours_start_minute']!, _quietHoursStartMinuteMeta));
    }
    if (data.containsKey('quiet_hours_end_hour')) {
      context.handle(
          _quietHoursEndHourMeta,
          quietHoursEndHour.isAcceptableOrUnknown(
              data['quiet_hours_end_hour']!, _quietHoursEndHourMeta));
    }
    if (data.containsKey('quiet_hours_end_minute')) {
      context.handle(
          _quietHoursEndMinuteMeta,
          quietHoursEndMinute.isAcceptableOrUnknown(
              data['quiet_hours_end_minute']!, _quietHoursEndMinuteMeta));
    }
    if (data.containsKey('critical_alerts_granted')) {
      context.handle(
          _criticalAlertsGrantedMeta,
          criticalAlertsGranted.isAcceptableOrUnknown(
              data['critical_alerts_granted']!, _criticalAlertsGrantedMeta));
    }
    if (data.containsKey('exact_alarm_granted')) {
      context.handle(
          _exactAlarmGrantedMeta,
          exactAlarmGranted.isAcceptableOrUnknown(
              data['exact_alarm_granted']!, _exactAlarmGrantedMeta));
    }
    if (data.containsKey('battery_optimization_exempt')) {
      context.handle(
          _batteryOptimizationExemptMeta,
          batteryOptimizationExempt.isAcceptableOrUnknown(
              data['battery_optimization_exempt']!,
              _batteryOptimizationExemptMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPreference(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      repeatIntervalMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}repeat_interval_minutes'])!,
      maxDelayMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_delay_minutes'])!,
      caregiverEscalationThresholdMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}caregiver_escalation_threshold_minutes'])!,
      quietHoursStartHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}quiet_hours_start_hour']),
      quietHoursStartMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}quiet_hours_start_minute']),
      quietHoursEndHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}quiet_hours_end_hour']),
      quietHoursEndMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}quiet_hours_end_minute']),
      criticalAlertsGranted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}critical_alerts_granted'])!,
      exactAlarmGranted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}exact_alarm_granted'])!,
      batteryOptimizationExempt: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}battery_optimization_exempt'])!,
    );
  }

  @override
  $NotificationPreferencesTable createAlias(String alias) {
    return $NotificationPreferencesTable(attachedDatabase, alias);
  }
}

class NotificationPreference extends DataClass
    implements Insertable<NotificationPreference> {
  final String id;
  final String patientId;
  final int repeatIntervalMinutes;
  final int maxDelayMinutes;
  final int caregiverEscalationThresholdMinutes;
  final int? quietHoursStartHour;
  final int? quietHoursStartMinute;
  final int? quietHoursEndHour;
  final int? quietHoursEndMinute;
  final bool criticalAlertsGranted;
  final bool exactAlarmGranted;
  final bool batteryOptimizationExempt;
  const NotificationPreference(
      {required this.id,
      required this.patientId,
      required this.repeatIntervalMinutes,
      required this.maxDelayMinutes,
      required this.caregiverEscalationThresholdMinutes,
      this.quietHoursStartHour,
      this.quietHoursStartMinute,
      this.quietHoursEndHour,
      this.quietHoursEndMinute,
      required this.criticalAlertsGranted,
      required this.exactAlarmGranted,
      required this.batteryOptimizationExempt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['repeat_interval_minutes'] = Variable<int>(repeatIntervalMinutes);
    map['max_delay_minutes'] = Variable<int>(maxDelayMinutes);
    map['caregiver_escalation_threshold_minutes'] =
        Variable<int>(caregiverEscalationThresholdMinutes);
    if (!nullToAbsent || quietHoursStartHour != null) {
      map['quiet_hours_start_hour'] = Variable<int>(quietHoursStartHour);
    }
    if (!nullToAbsent || quietHoursStartMinute != null) {
      map['quiet_hours_start_minute'] = Variable<int>(quietHoursStartMinute);
    }
    if (!nullToAbsent || quietHoursEndHour != null) {
      map['quiet_hours_end_hour'] = Variable<int>(quietHoursEndHour);
    }
    if (!nullToAbsent || quietHoursEndMinute != null) {
      map['quiet_hours_end_minute'] = Variable<int>(quietHoursEndMinute);
    }
    map['critical_alerts_granted'] = Variable<bool>(criticalAlertsGranted);
    map['exact_alarm_granted'] = Variable<bool>(exactAlarmGranted);
    map['battery_optimization_exempt'] =
        Variable<bool>(batteryOptimizationExempt);
    return map;
  }

  NotificationPreferencesCompanion toCompanion(bool nullToAbsent) {
    return NotificationPreferencesCompanion(
      id: Value(id),
      patientId: Value(patientId),
      repeatIntervalMinutes: Value(repeatIntervalMinutes),
      maxDelayMinutes: Value(maxDelayMinutes),
      caregiverEscalationThresholdMinutes:
          Value(caregiverEscalationThresholdMinutes),
      quietHoursStartHour: quietHoursStartHour == null && nullToAbsent
          ? const Value.absent()
          : Value(quietHoursStartHour),
      quietHoursStartMinute: quietHoursStartMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(quietHoursStartMinute),
      quietHoursEndHour: quietHoursEndHour == null && nullToAbsent
          ? const Value.absent()
          : Value(quietHoursEndHour),
      quietHoursEndMinute: quietHoursEndMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(quietHoursEndMinute),
      criticalAlertsGranted: Value(criticalAlertsGranted),
      exactAlarmGranted: Value(exactAlarmGranted),
      batteryOptimizationExempt: Value(batteryOptimizationExempt),
    );
  }

  factory NotificationPreference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPreference(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      repeatIntervalMinutes:
          serializer.fromJson<int>(json['repeatIntervalMinutes']),
      maxDelayMinutes: serializer.fromJson<int>(json['maxDelayMinutes']),
      caregiverEscalationThresholdMinutes:
          serializer.fromJson<int>(json['caregiverEscalationThresholdMinutes']),
      quietHoursStartHour:
          serializer.fromJson<int?>(json['quietHoursStartHour']),
      quietHoursStartMinute:
          serializer.fromJson<int?>(json['quietHoursStartMinute']),
      quietHoursEndHour: serializer.fromJson<int?>(json['quietHoursEndHour']),
      quietHoursEndMinute:
          serializer.fromJson<int?>(json['quietHoursEndMinute']),
      criticalAlertsGranted:
          serializer.fromJson<bool>(json['criticalAlertsGranted']),
      exactAlarmGranted: serializer.fromJson<bool>(json['exactAlarmGranted']),
      batteryOptimizationExempt:
          serializer.fromJson<bool>(json['batteryOptimizationExempt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'repeatIntervalMinutes': serializer.toJson<int>(repeatIntervalMinutes),
      'maxDelayMinutes': serializer.toJson<int>(maxDelayMinutes),
      'caregiverEscalationThresholdMinutes':
          serializer.toJson<int>(caregiverEscalationThresholdMinutes),
      'quietHoursStartHour': serializer.toJson<int?>(quietHoursStartHour),
      'quietHoursStartMinute': serializer.toJson<int?>(quietHoursStartMinute),
      'quietHoursEndHour': serializer.toJson<int?>(quietHoursEndHour),
      'quietHoursEndMinute': serializer.toJson<int?>(quietHoursEndMinute),
      'criticalAlertsGranted': serializer.toJson<bool>(criticalAlertsGranted),
      'exactAlarmGranted': serializer.toJson<bool>(exactAlarmGranted),
      'batteryOptimizationExempt':
          serializer.toJson<bool>(batteryOptimizationExempt),
    };
  }

  NotificationPreference copyWith(
          {String? id,
          String? patientId,
          int? repeatIntervalMinutes,
          int? maxDelayMinutes,
          int? caregiverEscalationThresholdMinutes,
          Value<int?> quietHoursStartHour = const Value.absent(),
          Value<int?> quietHoursStartMinute = const Value.absent(),
          Value<int?> quietHoursEndHour = const Value.absent(),
          Value<int?> quietHoursEndMinute = const Value.absent(),
          bool? criticalAlertsGranted,
          bool? exactAlarmGranted,
          bool? batteryOptimizationExempt}) =>
      NotificationPreference(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        repeatIntervalMinutes:
            repeatIntervalMinutes ?? this.repeatIntervalMinutes,
        maxDelayMinutes: maxDelayMinutes ?? this.maxDelayMinutes,
        caregiverEscalationThresholdMinutes:
            caregiverEscalationThresholdMinutes ??
                this.caregiverEscalationThresholdMinutes,
        quietHoursStartHour: quietHoursStartHour.present
            ? quietHoursStartHour.value
            : this.quietHoursStartHour,
        quietHoursStartMinute: quietHoursStartMinute.present
            ? quietHoursStartMinute.value
            : this.quietHoursStartMinute,
        quietHoursEndHour: quietHoursEndHour.present
            ? quietHoursEndHour.value
            : this.quietHoursEndHour,
        quietHoursEndMinute: quietHoursEndMinute.present
            ? quietHoursEndMinute.value
            : this.quietHoursEndMinute,
        criticalAlertsGranted:
            criticalAlertsGranted ?? this.criticalAlertsGranted,
        exactAlarmGranted: exactAlarmGranted ?? this.exactAlarmGranted,
        batteryOptimizationExempt:
            batteryOptimizationExempt ?? this.batteryOptimizationExempt,
      );
  NotificationPreference copyWithCompanion(
      NotificationPreferencesCompanion data) {
    return NotificationPreference(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      repeatIntervalMinutes: data.repeatIntervalMinutes.present
          ? data.repeatIntervalMinutes.value
          : this.repeatIntervalMinutes,
      maxDelayMinutes: data.maxDelayMinutes.present
          ? data.maxDelayMinutes.value
          : this.maxDelayMinutes,
      caregiverEscalationThresholdMinutes:
          data.caregiverEscalationThresholdMinutes.present
              ? data.caregiverEscalationThresholdMinutes.value
              : this.caregiverEscalationThresholdMinutes,
      quietHoursStartHour: data.quietHoursStartHour.present
          ? data.quietHoursStartHour.value
          : this.quietHoursStartHour,
      quietHoursStartMinute: data.quietHoursStartMinute.present
          ? data.quietHoursStartMinute.value
          : this.quietHoursStartMinute,
      quietHoursEndHour: data.quietHoursEndHour.present
          ? data.quietHoursEndHour.value
          : this.quietHoursEndHour,
      quietHoursEndMinute: data.quietHoursEndMinute.present
          ? data.quietHoursEndMinute.value
          : this.quietHoursEndMinute,
      criticalAlertsGranted: data.criticalAlertsGranted.present
          ? data.criticalAlertsGranted.value
          : this.criticalAlertsGranted,
      exactAlarmGranted: data.exactAlarmGranted.present
          ? data.exactAlarmGranted.value
          : this.exactAlarmGranted,
      batteryOptimizationExempt: data.batteryOptimizationExempt.present
          ? data.batteryOptimizationExempt.value
          : this.batteryOptimizationExempt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreference(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('repeatIntervalMinutes: $repeatIntervalMinutes, ')
          ..write('maxDelayMinutes: $maxDelayMinutes, ')
          ..write(
              'caregiverEscalationThresholdMinutes: $caregiverEscalationThresholdMinutes, ')
          ..write('quietHoursStartHour: $quietHoursStartHour, ')
          ..write('quietHoursStartMinute: $quietHoursStartMinute, ')
          ..write('quietHoursEndHour: $quietHoursEndHour, ')
          ..write('quietHoursEndMinute: $quietHoursEndMinute, ')
          ..write('criticalAlertsGranted: $criticalAlertsGranted, ')
          ..write('exactAlarmGranted: $exactAlarmGranted, ')
          ..write('batteryOptimizationExempt: $batteryOptimizationExempt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      patientId,
      repeatIntervalMinutes,
      maxDelayMinutes,
      caregiverEscalationThresholdMinutes,
      quietHoursStartHour,
      quietHoursStartMinute,
      quietHoursEndHour,
      quietHoursEndMinute,
      criticalAlertsGranted,
      exactAlarmGranted,
      batteryOptimizationExempt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPreference &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.repeatIntervalMinutes == this.repeatIntervalMinutes &&
          other.maxDelayMinutes == this.maxDelayMinutes &&
          other.caregiverEscalationThresholdMinutes ==
              this.caregiverEscalationThresholdMinutes &&
          other.quietHoursStartHour == this.quietHoursStartHour &&
          other.quietHoursStartMinute == this.quietHoursStartMinute &&
          other.quietHoursEndHour == this.quietHoursEndHour &&
          other.quietHoursEndMinute == this.quietHoursEndMinute &&
          other.criticalAlertsGranted == this.criticalAlertsGranted &&
          other.exactAlarmGranted == this.exactAlarmGranted &&
          other.batteryOptimizationExempt == this.batteryOptimizationExempt);
}

class NotificationPreferencesCompanion
    extends UpdateCompanion<NotificationPreference> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<int> repeatIntervalMinutes;
  final Value<int> maxDelayMinutes;
  final Value<int> caregiverEscalationThresholdMinutes;
  final Value<int?> quietHoursStartHour;
  final Value<int?> quietHoursStartMinute;
  final Value<int?> quietHoursEndHour;
  final Value<int?> quietHoursEndMinute;
  final Value<bool> criticalAlertsGranted;
  final Value<bool> exactAlarmGranted;
  final Value<bool> batteryOptimizationExempt;
  final Value<int> rowid;
  const NotificationPreferencesCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.repeatIntervalMinutes = const Value.absent(),
    this.maxDelayMinutes = const Value.absent(),
    this.caregiverEscalationThresholdMinutes = const Value.absent(),
    this.quietHoursStartHour = const Value.absent(),
    this.quietHoursStartMinute = const Value.absent(),
    this.quietHoursEndHour = const Value.absent(),
    this.quietHoursEndMinute = const Value.absent(),
    this.criticalAlertsGranted = const Value.absent(),
    this.exactAlarmGranted = const Value.absent(),
    this.batteryOptimizationExempt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationPreferencesCompanion.insert({
    required String id,
    required String patientId,
    this.repeatIntervalMinutes = const Value.absent(),
    this.maxDelayMinutes = const Value.absent(),
    this.caregiverEscalationThresholdMinutes = const Value.absent(),
    this.quietHoursStartHour = const Value.absent(),
    this.quietHoursStartMinute = const Value.absent(),
    this.quietHoursEndHour = const Value.absent(),
    this.quietHoursEndMinute = const Value.absent(),
    this.criticalAlertsGranted = const Value.absent(),
    this.exactAlarmGranted = const Value.absent(),
    this.batteryOptimizationExempt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId);
  static Insertable<NotificationPreference> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<int>? repeatIntervalMinutes,
    Expression<int>? maxDelayMinutes,
    Expression<int>? caregiverEscalationThresholdMinutes,
    Expression<int>? quietHoursStartHour,
    Expression<int>? quietHoursStartMinute,
    Expression<int>? quietHoursEndHour,
    Expression<int>? quietHoursEndMinute,
    Expression<bool>? criticalAlertsGranted,
    Expression<bool>? exactAlarmGranted,
    Expression<bool>? batteryOptimizationExempt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (repeatIntervalMinutes != null)
        'repeat_interval_minutes': repeatIntervalMinutes,
      if (maxDelayMinutes != null) 'max_delay_minutes': maxDelayMinutes,
      if (caregiverEscalationThresholdMinutes != null)
        'caregiver_escalation_threshold_minutes':
            caregiverEscalationThresholdMinutes,
      if (quietHoursStartHour != null)
        'quiet_hours_start_hour': quietHoursStartHour,
      if (quietHoursStartMinute != null)
        'quiet_hours_start_minute': quietHoursStartMinute,
      if (quietHoursEndHour != null) 'quiet_hours_end_hour': quietHoursEndHour,
      if (quietHoursEndMinute != null)
        'quiet_hours_end_minute': quietHoursEndMinute,
      if (criticalAlertsGranted != null)
        'critical_alerts_granted': criticalAlertsGranted,
      if (exactAlarmGranted != null) 'exact_alarm_granted': exactAlarmGranted,
      if (batteryOptimizationExempt != null)
        'battery_optimization_exempt': batteryOptimizationExempt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationPreferencesCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<int>? repeatIntervalMinutes,
      Value<int>? maxDelayMinutes,
      Value<int>? caregiverEscalationThresholdMinutes,
      Value<int?>? quietHoursStartHour,
      Value<int?>? quietHoursStartMinute,
      Value<int?>? quietHoursEndHour,
      Value<int?>? quietHoursEndMinute,
      Value<bool>? criticalAlertsGranted,
      Value<bool>? exactAlarmGranted,
      Value<bool>? batteryOptimizationExempt,
      Value<int>? rowid}) {
    return NotificationPreferencesCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      repeatIntervalMinutes:
          repeatIntervalMinutes ?? this.repeatIntervalMinutes,
      maxDelayMinutes: maxDelayMinutes ?? this.maxDelayMinutes,
      caregiverEscalationThresholdMinutes:
          caregiverEscalationThresholdMinutes ??
              this.caregiverEscalationThresholdMinutes,
      quietHoursStartHour: quietHoursStartHour ?? this.quietHoursStartHour,
      quietHoursStartMinute:
          quietHoursStartMinute ?? this.quietHoursStartMinute,
      quietHoursEndHour: quietHoursEndHour ?? this.quietHoursEndHour,
      quietHoursEndMinute: quietHoursEndMinute ?? this.quietHoursEndMinute,
      criticalAlertsGranted:
          criticalAlertsGranted ?? this.criticalAlertsGranted,
      exactAlarmGranted: exactAlarmGranted ?? this.exactAlarmGranted,
      batteryOptimizationExempt:
          batteryOptimizationExempt ?? this.batteryOptimizationExempt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (repeatIntervalMinutes.present) {
      map['repeat_interval_minutes'] =
          Variable<int>(repeatIntervalMinutes.value);
    }
    if (maxDelayMinutes.present) {
      map['max_delay_minutes'] = Variable<int>(maxDelayMinutes.value);
    }
    if (caregiverEscalationThresholdMinutes.present) {
      map['caregiver_escalation_threshold_minutes'] =
          Variable<int>(caregiverEscalationThresholdMinutes.value);
    }
    if (quietHoursStartHour.present) {
      map['quiet_hours_start_hour'] = Variable<int>(quietHoursStartHour.value);
    }
    if (quietHoursStartMinute.present) {
      map['quiet_hours_start_minute'] =
          Variable<int>(quietHoursStartMinute.value);
    }
    if (quietHoursEndHour.present) {
      map['quiet_hours_end_hour'] = Variable<int>(quietHoursEndHour.value);
    }
    if (quietHoursEndMinute.present) {
      map['quiet_hours_end_minute'] = Variable<int>(quietHoursEndMinute.value);
    }
    if (criticalAlertsGranted.present) {
      map['critical_alerts_granted'] =
          Variable<bool>(criticalAlertsGranted.value);
    }
    if (exactAlarmGranted.present) {
      map['exact_alarm_granted'] = Variable<bool>(exactAlarmGranted.value);
    }
    if (batteryOptimizationExempt.present) {
      map['battery_optimization_exempt'] =
          Variable<bool>(batteryOptimizationExempt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('repeatIntervalMinutes: $repeatIntervalMinutes, ')
          ..write('maxDelayMinutes: $maxDelayMinutes, ')
          ..write(
              'caregiverEscalationThresholdMinutes: $caregiverEscalationThresholdMinutes, ')
          ..write('quietHoursStartHour: $quietHoursStartHour, ')
          ..write('quietHoursStartMinute: $quietHoursStartMinute, ')
          ..write('quietHoursEndHour: $quietHoursEndHour, ')
          ..write('quietHoursEndMinute: $quietHoursEndMinute, ')
          ..write('criticalAlertsGranted: $criticalAlertsGranted, ')
          ..write('exactAlarmGranted: $exactAlarmGranted, ')
          ..write('batteryOptimizationExempt: $batteryOptimizationExempt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PatientProfilesTable patientProfiles =
      $PatientProfilesTable(this);
  late final $MedicationsTable medications = $MedicationsTable(this);
  late final $MedicationSchedulesTable medicationSchedules =
      $MedicationSchedulesTable(this);
  late final $MedicationScheduleTimesTable medicationScheduleTimes =
      $MedicationScheduleTimesTable(this);
  late final $MedicationIntakeLogsTable medicationIntakeLogs =
      $MedicationIntakeLogsTable(this);
  late final $ProteinRestrictionWindowsTable proteinRestrictionWindows =
      $ProteinRestrictionWindowsTable(this);
  late final $CaregiverProfilesTable caregiverProfiles =
      $CaregiverProfilesTable(this);
  late final $ConsentGrantsTable consentGrants = $ConsentGrantsTable(this);
  late final $SymptomLogsTable symptomLogs = $SymptomLogsTable(this);
  late final $NotificationPreferencesTable notificationPreferences =
      $NotificationPreferencesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        patientProfiles,
        medications,
        medicationSchedules,
        medicationScheduleTimes,
        medicationIntakeLogs,
        proteinRestrictionWindows,
        caregiverProfiles,
        consentGrants,
        symptomLogs,
        notificationPreferences
      ];
}

typedef $$PatientProfilesTableCreateCompanionBuilder = PatientProfilesCompanion
    Function({
  required String id,
  required String userId,
  Value<DateTime?> dateOfBirth,
  Value<int?> diagnosisYear,
  Value<bool> simplifiedModeEnabled,
  Value<String?> treatingPhysicianName,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$PatientProfilesTableUpdateCompanionBuilder = PatientProfilesCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<DateTime?> dateOfBirth,
  Value<int?> diagnosisYear,
  Value<bool> simplifiedModeEnabled,
  Value<String?> treatingPhysicianName,
  Value<String?> notes,
  Value<int> rowid,
});

class $$PatientProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diagnosisYear => $composableBuilder(
      column: $table.diagnosisYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get simplifiedModeEnabled => $composableBuilder(
      column: $table.simplifiedModeEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get treatingPhysicianName => $composableBuilder(
      column: $table.treatingPhysicianName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$PatientProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diagnosisYear => $composableBuilder(
      column: $table.diagnosisYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get simplifiedModeEnabled => $composableBuilder(
      column: $table.simplifiedModeEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get treatingPhysicianName => $composableBuilder(
      column: $table.treatingPhysicianName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$PatientProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<int> get diagnosisYear => $composableBuilder(
      column: $table.diagnosisYear, builder: (column) => column);

  GeneratedColumn<bool> get simplifiedModeEnabled => $composableBuilder(
      column: $table.simplifiedModeEnabled, builder: (column) => column);

  GeneratedColumn<String> get treatingPhysicianName => $composableBuilder(
      column: $table.treatingPhysicianName, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$PatientProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PatientProfilesTable,
    PatientProfile,
    $$PatientProfilesTableFilterComposer,
    $$PatientProfilesTableOrderingComposer,
    $$PatientProfilesTableAnnotationComposer,
    $$PatientProfilesTableCreateCompanionBuilder,
    $$PatientProfilesTableUpdateCompanionBuilder,
    (
      PatientProfile,
      BaseReferences<_$AppDatabase, $PatientProfilesTable, PatientProfile>
    ),
    PatientProfile,
    PrefetchHooks Function()> {
  $$PatientProfilesTableTableManager(
      _$AppDatabase db, $PatientProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<int?> diagnosisYear = const Value.absent(),
            Value<bool> simplifiedModeEnabled = const Value.absent(),
            Value<String?> treatingPhysicianName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PatientProfilesCompanion(
            id: id,
            userId: userId,
            dateOfBirth: dateOfBirth,
            diagnosisYear: diagnosisYear,
            simplifiedModeEnabled: simplifiedModeEnabled,
            treatingPhysicianName: treatingPhysicianName,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<int?> diagnosisYear = const Value.absent(),
            Value<bool> simplifiedModeEnabled = const Value.absent(),
            Value<String?> treatingPhysicianName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PatientProfilesCompanion.insert(
            id: id,
            userId: userId,
            dateOfBirth: dateOfBirth,
            diagnosisYear: diagnosisYear,
            simplifiedModeEnabled: simplifiedModeEnabled,
            treatingPhysicianName: treatingPhysicianName,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PatientProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PatientProfilesTable,
    PatientProfile,
    $$PatientProfilesTableFilterComposer,
    $$PatientProfilesTableOrderingComposer,
    $$PatientProfilesTableAnnotationComposer,
    $$PatientProfilesTableCreateCompanionBuilder,
    $$PatientProfilesTableUpdateCompanionBuilder,
    (
      PatientProfile,
      BaseReferences<_$AppDatabase, $PatientProfilesTable, PatientProfile>
    ),
    PatientProfile,
    PrefetchHooks Function()>;
typedef $$MedicationsTableCreateCompanionBuilder = MedicationsCompanion
    Function({
  required String id,
  required String patientId,
  required String name,
  Value<String?> activeIngredient,
  required String dosage,
  required String form,
  Value<bool> isParkinsonMedication,
  Value<bool> proteinRuleEnabled,
  Value<bool> isRescueDose,
  Value<String?> note,
  Value<bool> isActive,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$MedicationsTableUpdateCompanionBuilder = MedicationsCompanion
    Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> name,
  Value<String?> activeIngredient,
  Value<String> dosage,
  Value<String> form,
  Value<bool> isParkinsonMedication,
  Value<bool> proteinRuleEnabled,
  Value<bool> isRescueDose,
  Value<String?> note,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$MedicationsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activeIngredient => $composableBuilder(
      column: $table.activeIngredient,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get form => $composableBuilder(
      column: $table.form, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isParkinsonMedication => $composableBuilder(
      column: $table.isParkinsonMedication,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get proteinRuleEnabled => $composableBuilder(
      column: $table.proteinRuleEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRescueDose => $composableBuilder(
      column: $table.isRescueDose, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$MedicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activeIngredient => $composableBuilder(
      column: $table.activeIngredient,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get form => $composableBuilder(
      column: $table.form, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isParkinsonMedication => $composableBuilder(
      column: $table.isParkinsonMedication,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get proteinRuleEnabled => $composableBuilder(
      column: $table.proteinRuleEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRescueDose => $composableBuilder(
      column: $table.isRescueDose,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$MedicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get activeIngredient => $composableBuilder(
      column: $table.activeIngredient, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  GeneratedColumn<bool> get isParkinsonMedication => $composableBuilder(
      column: $table.isParkinsonMedication, builder: (column) => column);

  GeneratedColumn<bool> get proteinRuleEnabled => $composableBuilder(
      column: $table.proteinRuleEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isRescueDose => $composableBuilder(
      column: $table.isRescueDose, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MedicationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationsTable,
    Medication,
    $$MedicationsTableFilterComposer,
    $$MedicationsTableOrderingComposer,
    $$MedicationsTableAnnotationComposer,
    $$MedicationsTableCreateCompanionBuilder,
    $$MedicationsTableUpdateCompanionBuilder,
    (Medication, BaseReferences<_$AppDatabase, $MedicationsTable, Medication>),
    Medication,
    PrefetchHooks Function()> {
  $$MedicationsTableTableManager(_$AppDatabase db, $MedicationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> activeIngredient = const Value.absent(),
            Value<String> dosage = const Value.absent(),
            Value<String> form = const Value.absent(),
            Value<bool> isParkinsonMedication = const Value.absent(),
            Value<bool> proteinRuleEnabled = const Value.absent(),
            Value<bool> isRescueDose = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationsCompanion(
            id: id,
            patientId: patientId,
            name: name,
            activeIngredient: activeIngredient,
            dosage: dosage,
            form: form,
            isParkinsonMedication: isParkinsonMedication,
            proteinRuleEnabled: proteinRuleEnabled,
            isRescueDose: isRescueDose,
            note: note,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            required String name,
            Value<String?> activeIngredient = const Value.absent(),
            required String dosage,
            required String form,
            Value<bool> isParkinsonMedication = const Value.absent(),
            Value<bool> proteinRuleEnabled = const Value.absent(),
            Value<bool> isRescueDose = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationsCompanion.insert(
            id: id,
            patientId: patientId,
            name: name,
            activeIngredient: activeIngredient,
            dosage: dosage,
            form: form,
            isParkinsonMedication: isParkinsonMedication,
            proteinRuleEnabled: proteinRuleEnabled,
            isRescueDose: isRescueDose,
            note: note,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicationsTable,
    Medication,
    $$MedicationsTableFilterComposer,
    $$MedicationsTableOrderingComposer,
    $$MedicationsTableAnnotationComposer,
    $$MedicationsTableCreateCompanionBuilder,
    $$MedicationsTableUpdateCompanionBuilder,
    (Medication, BaseReferences<_$AppDatabase, $MedicationsTable, Medication>),
    Medication,
    PrefetchHooks Function()>;
typedef $$MedicationSchedulesTableCreateCompanionBuilder
    = MedicationSchedulesCompanion Function({
  required String id,
  required String medicationId,
  required String scheduleType,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<double?> intervalHours,
  required int firstDoseHour,
  required int firstDoseMinute,
  Value<int> rowid,
});
typedef $$MedicationSchedulesTableUpdateCompanionBuilder
    = MedicationSchedulesCompanion Function({
  Value<String> id,
  Value<String> medicationId,
  Value<String> scheduleType,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<double?> intervalHours,
  Value<int> firstDoseHour,
  Value<int> firstDoseMinute,
  Value<int> rowid,
});

class $$MedicationSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationSchedulesTable> {
  $$MedicationSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scheduleType => $composableBuilder(
      column: $table.scheduleType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get intervalHours => $composableBuilder(
      column: $table.intervalHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get firstDoseHour => $composableBuilder(
      column: $table.firstDoseHour, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get firstDoseMinute => $composableBuilder(
      column: $table.firstDoseMinute,
      builder: (column) => ColumnFilters(column));
}

class $$MedicationSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationSchedulesTable> {
  $$MedicationSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicationId => $composableBuilder(
      column: $table.medicationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduleType => $composableBuilder(
      column: $table.scheduleType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get intervalHours => $composableBuilder(
      column: $table.intervalHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get firstDoseHour => $composableBuilder(
      column: $table.firstDoseHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get firstDoseMinute => $composableBuilder(
      column: $table.firstDoseMinute,
      builder: (column) => ColumnOrderings(column));
}

class $$MedicationSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationSchedulesTable> {
  $$MedicationSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => column);

  GeneratedColumn<String> get scheduleType => $composableBuilder(
      column: $table.scheduleType, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<double> get intervalHours => $composableBuilder(
      column: $table.intervalHours, builder: (column) => column);

  GeneratedColumn<int> get firstDoseHour => $composableBuilder(
      column: $table.firstDoseHour, builder: (column) => column);

  GeneratedColumn<int> get firstDoseMinute => $composableBuilder(
      column: $table.firstDoseMinute, builder: (column) => column);
}

class $$MedicationSchedulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationSchedulesTable,
    MedicationSchedule,
    $$MedicationSchedulesTableFilterComposer,
    $$MedicationSchedulesTableOrderingComposer,
    $$MedicationSchedulesTableAnnotationComposer,
    $$MedicationSchedulesTableCreateCompanionBuilder,
    $$MedicationSchedulesTableUpdateCompanionBuilder,
    (
      MedicationSchedule,
      BaseReferences<_$AppDatabase, $MedicationSchedulesTable,
          MedicationSchedule>
    ),
    MedicationSchedule,
    PrefetchHooks Function()> {
  $$MedicationSchedulesTableTableManager(
      _$AppDatabase db, $MedicationSchedulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationSchedulesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationSchedulesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> medicationId = const Value.absent(),
            Value<String> scheduleType = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<double?> intervalHours = const Value.absent(),
            Value<int> firstDoseHour = const Value.absent(),
            Value<int> firstDoseMinute = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationSchedulesCompanion(
            id: id,
            medicationId: medicationId,
            scheduleType: scheduleType,
            startDate: startDate,
            endDate: endDate,
            intervalHours: intervalHours,
            firstDoseHour: firstDoseHour,
            firstDoseMinute: firstDoseMinute,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String medicationId,
            required String scheduleType,
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<double?> intervalHours = const Value.absent(),
            required int firstDoseHour,
            required int firstDoseMinute,
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationSchedulesCompanion.insert(
            id: id,
            medicationId: medicationId,
            scheduleType: scheduleType,
            startDate: startDate,
            endDate: endDate,
            intervalHours: intervalHours,
            firstDoseHour: firstDoseHour,
            firstDoseMinute: firstDoseMinute,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicationSchedulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicationSchedulesTable,
    MedicationSchedule,
    $$MedicationSchedulesTableFilterComposer,
    $$MedicationSchedulesTableOrderingComposer,
    $$MedicationSchedulesTableAnnotationComposer,
    $$MedicationSchedulesTableCreateCompanionBuilder,
    $$MedicationSchedulesTableUpdateCompanionBuilder,
    (
      MedicationSchedule,
      BaseReferences<_$AppDatabase, $MedicationSchedulesTable,
          MedicationSchedule>
    ),
    MedicationSchedule,
    PrefetchHooks Function()>;
typedef $$MedicationScheduleTimesTableCreateCompanionBuilder
    = MedicationScheduleTimesCompanion Function({
  Value<int> id,
  required String scheduleId,
  required int hour,
  required int minute,
});
typedef $$MedicationScheduleTimesTableUpdateCompanionBuilder
    = MedicationScheduleTimesCompanion Function({
  Value<int> id,
  Value<String> scheduleId,
  Value<int> hour,
  Value<int> minute,
});

class $$MedicationScheduleTimesTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationScheduleTimesTable> {
  $$MedicationScheduleTimesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hour => $composableBuilder(
      column: $table.hour, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minute => $composableBuilder(
      column: $table.minute, builder: (column) => ColumnFilters(column));
}

class $$MedicationScheduleTimesTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationScheduleTimesTable> {
  $$MedicationScheduleTimesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hour => $composableBuilder(
      column: $table.hour, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minute => $composableBuilder(
      column: $table.minute, builder: (column) => ColumnOrderings(column));
}

class $$MedicationScheduleTimesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationScheduleTimesTable> {
  $$MedicationScheduleTimesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);
}

class $$MedicationScheduleTimesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationScheduleTimesTable,
    MedicationScheduleTime,
    $$MedicationScheduleTimesTableFilterComposer,
    $$MedicationScheduleTimesTableOrderingComposer,
    $$MedicationScheduleTimesTableAnnotationComposer,
    $$MedicationScheduleTimesTableCreateCompanionBuilder,
    $$MedicationScheduleTimesTableUpdateCompanionBuilder,
    (
      MedicationScheduleTime,
      BaseReferences<_$AppDatabase, $MedicationScheduleTimesTable,
          MedicationScheduleTime>
    ),
    MedicationScheduleTime,
    PrefetchHooks Function()> {
  $$MedicationScheduleTimesTableTableManager(
      _$AppDatabase db, $MedicationScheduleTimesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationScheduleTimesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationScheduleTimesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationScheduleTimesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> scheduleId = const Value.absent(),
            Value<int> hour = const Value.absent(),
            Value<int> minute = const Value.absent(),
          }) =>
              MedicationScheduleTimesCompanion(
            id: id,
            scheduleId: scheduleId,
            hour: hour,
            minute: minute,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String scheduleId,
            required int hour,
            required int minute,
          }) =>
              MedicationScheduleTimesCompanion.insert(
            id: id,
            scheduleId: scheduleId,
            hour: hour,
            minute: minute,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicationScheduleTimesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $MedicationScheduleTimesTable,
        MedicationScheduleTime,
        $$MedicationScheduleTimesTableFilterComposer,
        $$MedicationScheduleTimesTableOrderingComposer,
        $$MedicationScheduleTimesTableAnnotationComposer,
        $$MedicationScheduleTimesTableCreateCompanionBuilder,
        $$MedicationScheduleTimesTableUpdateCompanionBuilder,
        (
          MedicationScheduleTime,
          BaseReferences<_$AppDatabase, $MedicationScheduleTimesTable,
              MedicationScheduleTime>
        ),
        MedicationScheduleTime,
        PrefetchHooks Function()>;
typedef $$MedicationIntakeLogsTableCreateCompanionBuilder
    = MedicationIntakeLogsCompanion Function({
  required String id,
  required String scheduleId,
  required String medicationId,
  required DateTime scheduledTime,
  required String status,
  Value<DateTime?> confirmedAt,
  Value<String?> confirmedByUserId,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$MedicationIntakeLogsTableUpdateCompanionBuilder
    = MedicationIntakeLogsCompanion Function({
  Value<String> id,
  Value<String> scheduleId,
  Value<String> medicationId,
  Value<DateTime> scheduledTime,
  Value<String> status,
  Value<DateTime?> confirmedAt,
  Value<String?> confirmedByUserId,
  Value<String?> note,
  Value<int> rowid,
});

class $$MedicationIntakeLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationIntakeLogsTable> {
  $$MedicationIntakeLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledTime => $composableBuilder(
      column: $table.scheduledTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get confirmedAt => $composableBuilder(
      column: $table.confirmedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get confirmedByUserId => $composableBuilder(
      column: $table.confirmedByUserId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));
}

class $$MedicationIntakeLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationIntakeLogsTable> {
  $$MedicationIntakeLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicationId => $composableBuilder(
      column: $table.medicationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledTime => $composableBuilder(
      column: $table.scheduledTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get confirmedAt => $composableBuilder(
      column: $table.confirmedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get confirmedByUserId => $composableBuilder(
      column: $table.confirmedByUserId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$MedicationIntakeLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationIntakeLogsTable> {
  $$MedicationIntakeLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => column);

  GeneratedColumn<String> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledTime => $composableBuilder(
      column: $table.scheduledTime, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get confirmedAt => $composableBuilder(
      column: $table.confirmedAt, builder: (column) => column);

  GeneratedColumn<String> get confirmedByUserId => $composableBuilder(
      column: $table.confirmedByUserId, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$MedicationIntakeLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationIntakeLogsTable,
    MedicationIntakeLog,
    $$MedicationIntakeLogsTableFilterComposer,
    $$MedicationIntakeLogsTableOrderingComposer,
    $$MedicationIntakeLogsTableAnnotationComposer,
    $$MedicationIntakeLogsTableCreateCompanionBuilder,
    $$MedicationIntakeLogsTableUpdateCompanionBuilder,
    (
      MedicationIntakeLog,
      BaseReferences<_$AppDatabase, $MedicationIntakeLogsTable,
          MedicationIntakeLog>
    ),
    MedicationIntakeLog,
    PrefetchHooks Function()> {
  $$MedicationIntakeLogsTableTableManager(
      _$AppDatabase db, $MedicationIntakeLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationIntakeLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationIntakeLogsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationIntakeLogsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> scheduleId = const Value.absent(),
            Value<String> medicationId = const Value.absent(),
            Value<DateTime> scheduledTime = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> confirmedAt = const Value.absent(),
            Value<String?> confirmedByUserId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationIntakeLogsCompanion(
            id: id,
            scheduleId: scheduleId,
            medicationId: medicationId,
            scheduledTime: scheduledTime,
            status: status,
            confirmedAt: confirmedAt,
            confirmedByUserId: confirmedByUserId,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String scheduleId,
            required String medicationId,
            required DateTime scheduledTime,
            required String status,
            Value<DateTime?> confirmedAt = const Value.absent(),
            Value<String?> confirmedByUserId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicationIntakeLogsCompanion.insert(
            id: id,
            scheduleId: scheduleId,
            medicationId: medicationId,
            scheduledTime: scheduledTime,
            status: status,
            confirmedAt: confirmedAt,
            confirmedByUserId: confirmedByUserId,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicationIntakeLogsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $MedicationIntakeLogsTable,
        MedicationIntakeLog,
        $$MedicationIntakeLogsTableFilterComposer,
        $$MedicationIntakeLogsTableOrderingComposer,
        $$MedicationIntakeLogsTableAnnotationComposer,
        $$MedicationIntakeLogsTableCreateCompanionBuilder,
        $$MedicationIntakeLogsTableUpdateCompanionBuilder,
        (
          MedicationIntakeLog,
          BaseReferences<_$AppDatabase, $MedicationIntakeLogsTable,
              MedicationIntakeLog>
        ),
        MedicationIntakeLog,
        PrefetchHooks Function()>;
typedef $$ProteinRestrictionWindowsTableCreateCompanionBuilder
    = ProteinRestrictionWindowsCompanion Function({
  required String id,
  required String medicationId,
  Value<double> hoursBeforeDose,
  Value<double> hoursAfterDose,
  Value<bool> prescribedByPhysician,
  Value<bool> active,
  Value<int> rowid,
});
typedef $$ProteinRestrictionWindowsTableUpdateCompanionBuilder
    = ProteinRestrictionWindowsCompanion Function({
  Value<String> id,
  Value<String> medicationId,
  Value<double> hoursBeforeDose,
  Value<double> hoursAfterDose,
  Value<bool> prescribedByPhysician,
  Value<bool> active,
  Value<int> rowid,
});

class $$ProteinRestrictionWindowsTableFilterComposer
    extends Composer<_$AppDatabase, $ProteinRestrictionWindowsTable> {
  $$ProteinRestrictionWindowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hoursBeforeDose => $composableBuilder(
      column: $table.hoursBeforeDose,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hoursAfterDose => $composableBuilder(
      column: $table.hoursAfterDose,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get prescribedByPhysician => $composableBuilder(
      column: $table.prescribedByPhysician,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));
}

class $$ProteinRestrictionWindowsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProteinRestrictionWindowsTable> {
  $$ProteinRestrictionWindowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicationId => $composableBuilder(
      column: $table.medicationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hoursBeforeDose => $composableBuilder(
      column: $table.hoursBeforeDose,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hoursAfterDose => $composableBuilder(
      column: $table.hoursAfterDose,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get prescribedByPhysician => $composableBuilder(
      column: $table.prescribedByPhysician,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));
}

class $$ProteinRestrictionWindowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProteinRestrictionWindowsTable> {
  $$ProteinRestrictionWindowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => column);

  GeneratedColumn<double> get hoursBeforeDose => $composableBuilder(
      column: $table.hoursBeforeDose, builder: (column) => column);

  GeneratedColumn<double> get hoursAfterDose => $composableBuilder(
      column: $table.hoursAfterDose, builder: (column) => column);

  GeneratedColumn<bool> get prescribedByPhysician => $composableBuilder(
      column: $table.prescribedByPhysician, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$ProteinRestrictionWindowsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProteinRestrictionWindowsTable,
    ProteinRestrictionWindow,
    $$ProteinRestrictionWindowsTableFilterComposer,
    $$ProteinRestrictionWindowsTableOrderingComposer,
    $$ProteinRestrictionWindowsTableAnnotationComposer,
    $$ProteinRestrictionWindowsTableCreateCompanionBuilder,
    $$ProteinRestrictionWindowsTableUpdateCompanionBuilder,
    (
      ProteinRestrictionWindow,
      BaseReferences<_$AppDatabase, $ProteinRestrictionWindowsTable,
          ProteinRestrictionWindow>
    ),
    ProteinRestrictionWindow,
    PrefetchHooks Function()> {
  $$ProteinRestrictionWindowsTableTableManager(
      _$AppDatabase db, $ProteinRestrictionWindowsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProteinRestrictionWindowsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ProteinRestrictionWindowsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProteinRestrictionWindowsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> medicationId = const Value.absent(),
            Value<double> hoursBeforeDose = const Value.absent(),
            Value<double> hoursAfterDose = const Value.absent(),
            Value<bool> prescribedByPhysician = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProteinRestrictionWindowsCompanion(
            id: id,
            medicationId: medicationId,
            hoursBeforeDose: hoursBeforeDose,
            hoursAfterDose: hoursAfterDose,
            prescribedByPhysician: prescribedByPhysician,
            active: active,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String medicationId,
            Value<double> hoursBeforeDose = const Value.absent(),
            Value<double> hoursAfterDose = const Value.absent(),
            Value<bool> prescribedByPhysician = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProteinRestrictionWindowsCompanion.insert(
            id: id,
            medicationId: medicationId,
            hoursBeforeDose: hoursBeforeDose,
            hoursAfterDose: hoursAfterDose,
            prescribedByPhysician: prescribedByPhysician,
            active: active,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProteinRestrictionWindowsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ProteinRestrictionWindowsTable,
        ProteinRestrictionWindow,
        $$ProteinRestrictionWindowsTableFilterComposer,
        $$ProteinRestrictionWindowsTableOrderingComposer,
        $$ProteinRestrictionWindowsTableAnnotationComposer,
        $$ProteinRestrictionWindowsTableCreateCompanionBuilder,
        $$ProteinRestrictionWindowsTableUpdateCompanionBuilder,
        (
          ProteinRestrictionWindow,
          BaseReferences<_$AppDatabase, $ProteinRestrictionWindowsTable,
              ProteinRestrictionWindow>
        ),
        ProteinRestrictionWindow,
        PrefetchHooks Function()>;
typedef $$CaregiverProfilesTableCreateCompanionBuilder
    = CaregiverProfilesCompanion Function({
  required String id,
  required String userId,
  required String relationshipToPatient,
  Value<int> rowid,
});
typedef $$CaregiverProfilesTableUpdateCompanionBuilder
    = CaregiverProfilesCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> relationshipToPatient,
  Value<int> rowid,
});

class $$CaregiverProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $CaregiverProfilesTable> {
  $$CaregiverProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relationshipToPatient => $composableBuilder(
      column: $table.relationshipToPatient,
      builder: (column) => ColumnFilters(column));
}

class $$CaregiverProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $CaregiverProfilesTable> {
  $$CaregiverProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relationshipToPatient => $composableBuilder(
      column: $table.relationshipToPatient,
      builder: (column) => ColumnOrderings(column));
}

class $$CaregiverProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CaregiverProfilesTable> {
  $$CaregiverProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get relationshipToPatient => $composableBuilder(
      column: $table.relationshipToPatient, builder: (column) => column);
}

class $$CaregiverProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CaregiverProfilesTable,
    CaregiverProfile,
    $$CaregiverProfilesTableFilterComposer,
    $$CaregiverProfilesTableOrderingComposer,
    $$CaregiverProfilesTableAnnotationComposer,
    $$CaregiverProfilesTableCreateCompanionBuilder,
    $$CaregiverProfilesTableUpdateCompanionBuilder,
    (
      CaregiverProfile,
      BaseReferences<_$AppDatabase, $CaregiverProfilesTable, CaregiverProfile>
    ),
    CaregiverProfile,
    PrefetchHooks Function()> {
  $$CaregiverProfilesTableTableManager(
      _$AppDatabase db, $CaregiverProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CaregiverProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CaregiverProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CaregiverProfilesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> relationshipToPatient = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CaregiverProfilesCompanion(
            id: id,
            userId: userId,
            relationshipToPatient: relationshipToPatient,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String relationshipToPatient,
            Value<int> rowid = const Value.absent(),
          }) =>
              CaregiverProfilesCompanion.insert(
            id: id,
            userId: userId,
            relationshipToPatient: relationshipToPatient,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CaregiverProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CaregiverProfilesTable,
    CaregiverProfile,
    $$CaregiverProfilesTableFilterComposer,
    $$CaregiverProfilesTableOrderingComposer,
    $$CaregiverProfilesTableAnnotationComposer,
    $$CaregiverProfilesTableCreateCompanionBuilder,
    $$CaregiverProfilesTableUpdateCompanionBuilder,
    (
      CaregiverProfile,
      BaseReferences<_$AppDatabase, $CaregiverProfilesTable, CaregiverProfile>
    ),
    CaregiverProfile,
    PrefetchHooks Function()>;
typedef $$ConsentGrantsTableCreateCompanionBuilder = ConsentGrantsCompanion
    Function({
  required String id,
  required String patientId,
  required String caregiverId,
  required String scopes,
  required DateTime grantedAt,
  Value<DateTime?> revokedAt,
  Value<int> rowid,
});
typedef $$ConsentGrantsTableUpdateCompanionBuilder = ConsentGrantsCompanion
    Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> caregiverId,
  Value<String> scopes,
  Value<DateTime> grantedAt,
  Value<DateTime?> revokedAt,
  Value<int> rowid,
});

class $$ConsentGrantsTableFilterComposer
    extends Composer<_$AppDatabase, $ConsentGrantsTable> {
  $$ConsentGrantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caregiverId => $composableBuilder(
      column: $table.caregiverId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scopes => $composableBuilder(
      column: $table.scopes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get grantedAt => $composableBuilder(
      column: $table.grantedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get revokedAt => $composableBuilder(
      column: $table.revokedAt, builder: (column) => ColumnFilters(column));
}

class $$ConsentGrantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsentGrantsTable> {
  $$ConsentGrantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caregiverId => $composableBuilder(
      column: $table.caregiverId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scopes => $composableBuilder(
      column: $table.scopes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get grantedAt => $composableBuilder(
      column: $table.grantedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get revokedAt => $composableBuilder(
      column: $table.revokedAt, builder: (column) => ColumnOrderings(column));
}

class $$ConsentGrantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsentGrantsTable> {
  $$ConsentGrantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get caregiverId => $composableBuilder(
      column: $table.caregiverId, builder: (column) => column);

  GeneratedColumn<String> get scopes =>
      $composableBuilder(column: $table.scopes, builder: (column) => column);

  GeneratedColumn<DateTime> get grantedAt =>
      $composableBuilder(column: $table.grantedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get revokedAt =>
      $composableBuilder(column: $table.revokedAt, builder: (column) => column);
}

class $$ConsentGrantsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConsentGrantsTable,
    ConsentGrant,
    $$ConsentGrantsTableFilterComposer,
    $$ConsentGrantsTableOrderingComposer,
    $$ConsentGrantsTableAnnotationComposer,
    $$ConsentGrantsTableCreateCompanionBuilder,
    $$ConsentGrantsTableUpdateCompanionBuilder,
    (
      ConsentGrant,
      BaseReferences<_$AppDatabase, $ConsentGrantsTable, ConsentGrant>
    ),
    ConsentGrant,
    PrefetchHooks Function()> {
  $$ConsentGrantsTableTableManager(_$AppDatabase db, $ConsentGrantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsentGrantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsentGrantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsentGrantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> caregiverId = const Value.absent(),
            Value<String> scopes = const Value.absent(),
            Value<DateTime> grantedAt = const Value.absent(),
            Value<DateTime?> revokedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConsentGrantsCompanion(
            id: id,
            patientId: patientId,
            caregiverId: caregiverId,
            scopes: scopes,
            grantedAt: grantedAt,
            revokedAt: revokedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            required String caregiverId,
            required String scopes,
            required DateTime grantedAt,
            Value<DateTime?> revokedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConsentGrantsCompanion.insert(
            id: id,
            patientId: patientId,
            caregiverId: caregiverId,
            scopes: scopes,
            grantedAt: grantedAt,
            revokedAt: revokedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConsentGrantsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConsentGrantsTable,
    ConsentGrant,
    $$ConsentGrantsTableFilterComposer,
    $$ConsentGrantsTableOrderingComposer,
    $$ConsentGrantsTableAnnotationComposer,
    $$ConsentGrantsTableCreateCompanionBuilder,
    $$ConsentGrantsTableUpdateCompanionBuilder,
    (
      ConsentGrant,
      BaseReferences<_$AppDatabase, $ConsentGrantsTable, ConsentGrant>
    ),
    ConsentGrant,
    PrefetchHooks Function()>;
typedef $$SymptomLogsTableCreateCompanionBuilder = SymptomLogsCompanion
    Function({
  required String id,
  required String patientId,
  required DateTime timestamp,
  Value<int?> tremorSeverity,
  Value<int?> bradykinesia,
  Value<int?> rigidity,
  Value<bool> balanceIssue,
  Value<bool> fallOccurred,
  Value<String?> motorState,
  Value<bool> wearingOffObserved,
  Value<bool> dyskinesiaObserved,
  Value<bool> freezingOfGaitObserved,
  Value<int?> sleepQuality,
  Value<int?> mood,
  Value<String?> overallDayRating,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$SymptomLogsTableUpdateCompanionBuilder = SymptomLogsCompanion
    Function({
  Value<String> id,
  Value<String> patientId,
  Value<DateTime> timestamp,
  Value<int?> tremorSeverity,
  Value<int?> bradykinesia,
  Value<int?> rigidity,
  Value<bool> balanceIssue,
  Value<bool> fallOccurred,
  Value<String?> motorState,
  Value<bool> wearingOffObserved,
  Value<bool> dyskinesiaObserved,
  Value<bool> freezingOfGaitObserved,
  Value<int?> sleepQuality,
  Value<int?> mood,
  Value<String?> overallDayRating,
  Value<String?> note,
  Value<int> rowid,
});

class $$SymptomLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tremorSeverity => $composableBuilder(
      column: $table.tremorSeverity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bradykinesia => $composableBuilder(
      column: $table.bradykinesia, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rigidity => $composableBuilder(
      column: $table.rigidity, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get balanceIssue => $composableBuilder(
      column: $table.balanceIssue, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get fallOccurred => $composableBuilder(
      column: $table.fallOccurred, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get motorState => $composableBuilder(
      column: $table.motorState, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get wearingOffObserved => $composableBuilder(
      column: $table.wearingOffObserved,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get dyskinesiaObserved => $composableBuilder(
      column: $table.dyskinesiaObserved,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get freezingOfGaitObserved => $composableBuilder(
      column: $table.freezingOfGaitObserved,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get overallDayRating => $composableBuilder(
      column: $table.overallDayRating,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));
}

class $$SymptomLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tremorSeverity => $composableBuilder(
      column: $table.tremorSeverity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bradykinesia => $composableBuilder(
      column: $table.bradykinesia,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rigidity => $composableBuilder(
      column: $table.rigidity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get balanceIssue => $composableBuilder(
      column: $table.balanceIssue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get fallOccurred => $composableBuilder(
      column: $table.fallOccurred,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get motorState => $composableBuilder(
      column: $table.motorState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get wearingOffObserved => $composableBuilder(
      column: $table.wearingOffObserved,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get dyskinesiaObserved => $composableBuilder(
      column: $table.dyskinesiaObserved,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get freezingOfGaitObserved => $composableBuilder(
      column: $table.freezingOfGaitObserved,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get overallDayRating => $composableBuilder(
      column: $table.overallDayRating,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$SymptomLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomLogsTable> {
  $$SymptomLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get tremorSeverity => $composableBuilder(
      column: $table.tremorSeverity, builder: (column) => column);

  GeneratedColumn<int> get bradykinesia => $composableBuilder(
      column: $table.bradykinesia, builder: (column) => column);

  GeneratedColumn<int> get rigidity =>
      $composableBuilder(column: $table.rigidity, builder: (column) => column);

  GeneratedColumn<bool> get balanceIssue => $composableBuilder(
      column: $table.balanceIssue, builder: (column) => column);

  GeneratedColumn<bool> get fallOccurred => $composableBuilder(
      column: $table.fallOccurred, builder: (column) => column);

  GeneratedColumn<String> get motorState => $composableBuilder(
      column: $table.motorState, builder: (column) => column);

  GeneratedColumn<bool> get wearingOffObserved => $composableBuilder(
      column: $table.wearingOffObserved, builder: (column) => column);

  GeneratedColumn<bool> get dyskinesiaObserved => $composableBuilder(
      column: $table.dyskinesiaObserved, builder: (column) => column);

  GeneratedColumn<bool> get freezingOfGaitObserved => $composableBuilder(
      column: $table.freezingOfGaitObserved, builder: (column) => column);

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get overallDayRating => $composableBuilder(
      column: $table.overallDayRating, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$SymptomLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomLogsTable,
    SymptomLog,
    $$SymptomLogsTableFilterComposer,
    $$SymptomLogsTableOrderingComposer,
    $$SymptomLogsTableAnnotationComposer,
    $$SymptomLogsTableCreateCompanionBuilder,
    $$SymptomLogsTableUpdateCompanionBuilder,
    (SymptomLog, BaseReferences<_$AppDatabase, $SymptomLogsTable, SymptomLog>),
    SymptomLog,
    PrefetchHooks Function()> {
  $$SymptomLogsTableTableManager(_$AppDatabase db, $SymptomLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int?> tremorSeverity = const Value.absent(),
            Value<int?> bradykinesia = const Value.absent(),
            Value<int?> rigidity = const Value.absent(),
            Value<bool> balanceIssue = const Value.absent(),
            Value<bool> fallOccurred = const Value.absent(),
            Value<String?> motorState = const Value.absent(),
            Value<bool> wearingOffObserved = const Value.absent(),
            Value<bool> dyskinesiaObserved = const Value.absent(),
            Value<bool> freezingOfGaitObserved = const Value.absent(),
            Value<int?> sleepQuality = const Value.absent(),
            Value<int?> mood = const Value.absent(),
            Value<String?> overallDayRating = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomLogsCompanion(
            id: id,
            patientId: patientId,
            timestamp: timestamp,
            tremorSeverity: tremorSeverity,
            bradykinesia: bradykinesia,
            rigidity: rigidity,
            balanceIssue: balanceIssue,
            fallOccurred: fallOccurred,
            motorState: motorState,
            wearingOffObserved: wearingOffObserved,
            dyskinesiaObserved: dyskinesiaObserved,
            freezingOfGaitObserved: freezingOfGaitObserved,
            sleepQuality: sleepQuality,
            mood: mood,
            overallDayRating: overallDayRating,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            required DateTime timestamp,
            Value<int?> tremorSeverity = const Value.absent(),
            Value<int?> bradykinesia = const Value.absent(),
            Value<int?> rigidity = const Value.absent(),
            Value<bool> balanceIssue = const Value.absent(),
            Value<bool> fallOccurred = const Value.absent(),
            Value<String?> motorState = const Value.absent(),
            Value<bool> wearingOffObserved = const Value.absent(),
            Value<bool> dyskinesiaObserved = const Value.absent(),
            Value<bool> freezingOfGaitObserved = const Value.absent(),
            Value<int?> sleepQuality = const Value.absent(),
            Value<int?> mood = const Value.absent(),
            Value<String?> overallDayRating = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomLogsCompanion.insert(
            id: id,
            patientId: patientId,
            timestamp: timestamp,
            tremorSeverity: tremorSeverity,
            bradykinesia: bradykinesia,
            rigidity: rigidity,
            balanceIssue: balanceIssue,
            fallOccurred: fallOccurred,
            motorState: motorState,
            wearingOffObserved: wearingOffObserved,
            dyskinesiaObserved: dyskinesiaObserved,
            freezingOfGaitObserved: freezingOfGaitObserved,
            sleepQuality: sleepQuality,
            mood: mood,
            overallDayRating: overallDayRating,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SymptomLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomLogsTable,
    SymptomLog,
    $$SymptomLogsTableFilterComposer,
    $$SymptomLogsTableOrderingComposer,
    $$SymptomLogsTableAnnotationComposer,
    $$SymptomLogsTableCreateCompanionBuilder,
    $$SymptomLogsTableUpdateCompanionBuilder,
    (SymptomLog, BaseReferences<_$AppDatabase, $SymptomLogsTable, SymptomLog>),
    SymptomLog,
    PrefetchHooks Function()>;
typedef $$NotificationPreferencesTableCreateCompanionBuilder
    = NotificationPreferencesCompanion Function({
  required String id,
  required String patientId,
  Value<int> repeatIntervalMinutes,
  Value<int> maxDelayMinutes,
  Value<int> caregiverEscalationThresholdMinutes,
  Value<int?> quietHoursStartHour,
  Value<int?> quietHoursStartMinute,
  Value<int?> quietHoursEndHour,
  Value<int?> quietHoursEndMinute,
  Value<bool> criticalAlertsGranted,
  Value<bool> exactAlarmGranted,
  Value<bool> batteryOptimizationExempt,
  Value<int> rowid,
});
typedef $$NotificationPreferencesTableUpdateCompanionBuilder
    = NotificationPreferencesCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<int> repeatIntervalMinutes,
  Value<int> maxDelayMinutes,
  Value<int> caregiverEscalationThresholdMinutes,
  Value<int?> quietHoursStartHour,
  Value<int?> quietHoursStartMinute,
  Value<int?> quietHoursEndHour,
  Value<int?> quietHoursEndMinute,
  Value<bool> criticalAlertsGranted,
  Value<bool> exactAlarmGranted,
  Value<bool> batteryOptimizationExempt,
  Value<int> rowid,
});

class $$NotificationPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repeatIntervalMinutes => $composableBuilder(
      column: $table.repeatIntervalMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxDelayMinutes => $composableBuilder(
      column: $table.maxDelayMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get caregiverEscalationThresholdMinutes =>
      $composableBuilder(
          column: $table.caregiverEscalationThresholdMinutes,
          builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quietHoursStartHour => $composableBuilder(
      column: $table.quietHoursStartHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quietHoursStartMinute => $composableBuilder(
      column: $table.quietHoursStartMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quietHoursEndHour => $composableBuilder(
      column: $table.quietHoursEndHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quietHoursEndMinute => $composableBuilder(
      column: $table.quietHoursEndMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get criticalAlertsGranted => $composableBuilder(
      column: $table.criticalAlertsGranted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get exactAlarmGranted => $composableBuilder(
      column: $table.exactAlarmGranted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get batteryOptimizationExempt => $composableBuilder(
      column: $table.batteryOptimizationExempt,
      builder: (column) => ColumnFilters(column));
}

class $$NotificationPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repeatIntervalMinutes => $composableBuilder(
      column: $table.repeatIntervalMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxDelayMinutes => $composableBuilder(
      column: $table.maxDelayMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get caregiverEscalationThresholdMinutes =>
      $composableBuilder(
          column: $table.caregiverEscalationThresholdMinutes,
          builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quietHoursStartHour => $composableBuilder(
      column: $table.quietHoursStartHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quietHoursStartMinute => $composableBuilder(
      column: $table.quietHoursStartMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quietHoursEndHour => $composableBuilder(
      column: $table.quietHoursEndHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quietHoursEndMinute => $composableBuilder(
      column: $table.quietHoursEndMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get criticalAlertsGranted => $composableBuilder(
      column: $table.criticalAlertsGranted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get exactAlarmGranted => $composableBuilder(
      column: $table.exactAlarmGranted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get batteryOptimizationExempt => $composableBuilder(
      column: $table.batteryOptimizationExempt,
      builder: (column) => ColumnOrderings(column));
}

class $$NotificationPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<int> get repeatIntervalMinutes => $composableBuilder(
      column: $table.repeatIntervalMinutes, builder: (column) => column);

  GeneratedColumn<int> get maxDelayMinutes => $composableBuilder(
      column: $table.maxDelayMinutes, builder: (column) => column);

  GeneratedColumn<int> get caregiverEscalationThresholdMinutes =>
      $composableBuilder(
          column: $table.caregiverEscalationThresholdMinutes,
          builder: (column) => column);

  GeneratedColumn<int> get quietHoursStartHour => $composableBuilder(
      column: $table.quietHoursStartHour, builder: (column) => column);

  GeneratedColumn<int> get quietHoursStartMinute => $composableBuilder(
      column: $table.quietHoursStartMinute, builder: (column) => column);

  GeneratedColumn<int> get quietHoursEndHour => $composableBuilder(
      column: $table.quietHoursEndHour, builder: (column) => column);

  GeneratedColumn<int> get quietHoursEndMinute => $composableBuilder(
      column: $table.quietHoursEndMinute, builder: (column) => column);

  GeneratedColumn<bool> get criticalAlertsGranted => $composableBuilder(
      column: $table.criticalAlertsGranted, builder: (column) => column);

  GeneratedColumn<bool> get exactAlarmGranted => $composableBuilder(
      column: $table.exactAlarmGranted, builder: (column) => column);

  GeneratedColumn<bool> get batteryOptimizationExempt => $composableBuilder(
      column: $table.batteryOptimizationExempt, builder: (column) => column);
}

class $$NotificationPreferencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationPreferencesTable,
    NotificationPreference,
    $$NotificationPreferencesTableFilterComposer,
    $$NotificationPreferencesTableOrderingComposer,
    $$NotificationPreferencesTableAnnotationComposer,
    $$NotificationPreferencesTableCreateCompanionBuilder,
    $$NotificationPreferencesTableUpdateCompanionBuilder,
    (
      NotificationPreference,
      BaseReferences<_$AppDatabase, $NotificationPreferencesTable,
          NotificationPreference>
    ),
    NotificationPreference,
    PrefetchHooks Function()> {
  $$NotificationPreferencesTableTableManager(
      _$AppDatabase db, $NotificationPreferencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPreferencesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationPreferencesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationPreferencesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<int> repeatIntervalMinutes = const Value.absent(),
            Value<int> maxDelayMinutes = const Value.absent(),
            Value<int> caregiverEscalationThresholdMinutes =
                const Value.absent(),
            Value<int?> quietHoursStartHour = const Value.absent(),
            Value<int?> quietHoursStartMinute = const Value.absent(),
            Value<int?> quietHoursEndHour = const Value.absent(),
            Value<int?> quietHoursEndMinute = const Value.absent(),
            Value<bool> criticalAlertsGranted = const Value.absent(),
            Value<bool> exactAlarmGranted = const Value.absent(),
            Value<bool> batteryOptimizationExempt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationPreferencesCompanion(
            id: id,
            patientId: patientId,
            repeatIntervalMinutes: repeatIntervalMinutes,
            maxDelayMinutes: maxDelayMinutes,
            caregiverEscalationThresholdMinutes:
                caregiverEscalationThresholdMinutes,
            quietHoursStartHour: quietHoursStartHour,
            quietHoursStartMinute: quietHoursStartMinute,
            quietHoursEndHour: quietHoursEndHour,
            quietHoursEndMinute: quietHoursEndMinute,
            criticalAlertsGranted: criticalAlertsGranted,
            exactAlarmGranted: exactAlarmGranted,
            batteryOptimizationExempt: batteryOptimizationExempt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            Value<int> repeatIntervalMinutes = const Value.absent(),
            Value<int> maxDelayMinutes = const Value.absent(),
            Value<int> caregiverEscalationThresholdMinutes =
                const Value.absent(),
            Value<int?> quietHoursStartHour = const Value.absent(),
            Value<int?> quietHoursStartMinute = const Value.absent(),
            Value<int?> quietHoursEndHour = const Value.absent(),
            Value<int?> quietHoursEndMinute = const Value.absent(),
            Value<bool> criticalAlertsGranted = const Value.absent(),
            Value<bool> exactAlarmGranted = const Value.absent(),
            Value<bool> batteryOptimizationExempt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationPreferencesCompanion.insert(
            id: id,
            patientId: patientId,
            repeatIntervalMinutes: repeatIntervalMinutes,
            maxDelayMinutes: maxDelayMinutes,
            caregiverEscalationThresholdMinutes:
                caregiverEscalationThresholdMinutes,
            quietHoursStartHour: quietHoursStartHour,
            quietHoursStartMinute: quietHoursStartMinute,
            quietHoursEndHour: quietHoursEndHour,
            quietHoursEndMinute: quietHoursEndMinute,
            criticalAlertsGranted: criticalAlertsGranted,
            exactAlarmGranted: exactAlarmGranted,
            batteryOptimizationExempt: batteryOptimizationExempt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationPreferencesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $NotificationPreferencesTable,
        NotificationPreference,
        $$NotificationPreferencesTableFilterComposer,
        $$NotificationPreferencesTableOrderingComposer,
        $$NotificationPreferencesTableAnnotationComposer,
        $$NotificationPreferencesTableCreateCompanionBuilder,
        $$NotificationPreferencesTableUpdateCompanionBuilder,
        (
          NotificationPreference,
          BaseReferences<_$AppDatabase, $NotificationPreferencesTable,
              NotificationPreference>
        ),
        NotificationPreference,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientProfilesTableTableManager get patientProfiles =>
      $$PatientProfilesTableTableManager(_db, _db.patientProfiles);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db, _db.medications);
  $$MedicationSchedulesTableTableManager get medicationSchedules =>
      $$MedicationSchedulesTableTableManager(_db, _db.medicationSchedules);
  $$MedicationScheduleTimesTableTableManager get medicationScheduleTimes =>
      $$MedicationScheduleTimesTableTableManager(
          _db, _db.medicationScheduleTimes);
  $$MedicationIntakeLogsTableTableManager get medicationIntakeLogs =>
      $$MedicationIntakeLogsTableTableManager(_db, _db.medicationIntakeLogs);
  $$ProteinRestrictionWindowsTableTableManager get proteinRestrictionWindows =>
      $$ProteinRestrictionWindowsTableTableManager(
          _db, _db.proteinRestrictionWindows);
  $$CaregiverProfilesTableTableManager get caregiverProfiles =>
      $$CaregiverProfilesTableTableManager(_db, _db.caregiverProfiles);
  $$ConsentGrantsTableTableManager get consentGrants =>
      $$ConsentGrantsTableTableManager(_db, _db.consentGrants);
  $$SymptomLogsTableTableManager get symptomLogs =>
      $$SymptomLogsTableTableManager(_db, _db.symptomLogs);
  $$NotificationPreferencesTableTableManager get notificationPreferences =>
      $$NotificationPreferencesTableTableManager(
          _db, _db.notificationPreferences);
}
