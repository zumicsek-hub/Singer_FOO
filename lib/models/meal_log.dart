enum MealType { breakfast, lunch, dinner, snack }

class MealLog {
  final String id;
  final String patientId;
  final MealType mealType;
  final DateTime time;
  final bool highProtein;
  final String? note;

  const MealLog({
    required this.id,
    required this.patientId,
    required this.mealType,
    required this.time,
    this.highProtein = false,
    this.note,
  });
}
