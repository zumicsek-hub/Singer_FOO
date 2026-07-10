enum MedicationForm { tablet, capsule, drops, injection, patch, other }

class Medication {
  final String id;
  final String patientId;
  final String name;
  final String? activeIngredient;
  final String dosage;
  final MedicationForm form;
  final bool isParkinsonMedication;
  final bool proteinRuleEnabled;
  final bool isRescueDose;
  final String? note;
  final bool isActive;
  final DateTime createdAt;

  const Medication({
    required this.id,
    required this.patientId,
    required this.name,
    required this.dosage,
    required this.form,
    required this.createdAt,
    this.activeIngredient,
    this.isParkinsonMedication = false,
    this.proteinRuleEnabled = false,
    this.isRescueDose = false,
    this.note,
    this.isActive = true,
  });
}
