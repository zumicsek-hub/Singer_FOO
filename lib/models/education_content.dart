class EducationContent {
  final String id;
  final String title;
  final String category;
  final String summary;
  final String? videoUrl;
  final List<String> sourceReferences;

  const EducationContent({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    this.videoUrl,
    this.sourceReferences = const [],
  });
}
