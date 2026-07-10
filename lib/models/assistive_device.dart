enum AssistiveDeviceCategory {
  gait,
  fallPrevention,
  eating,
  swallowing,
  dressing,
  bathing,
  sleep,
  speech,
  handTremor,
  fineMotor,
  homeSafety,
  caregiverSupport,
}

class AssistiveDevice {
  final String id;
  final String name;
  final AssistiveDeviceCategory category;
  final String description;
  final String whenUseful;
  final String recommendedFor;
  final String usageInstructions;
  final String? videoUrl;
  final List<String> sourceReferences;
  final String? purchaseLink;
  final bool isAffiliateLink;

  const AssistiveDevice({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.whenUseful,
    required this.recommendedFor,
    required this.usageInstructions,
    this.videoUrl,
    this.sourceReferences = const [],
    this.purchaseLink,
    this.isAffiliateLink = false,
  });
}
