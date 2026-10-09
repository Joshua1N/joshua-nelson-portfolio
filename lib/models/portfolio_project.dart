class PortfolioProject {
  const PortfolioProject({
    required this.id,
    required this.appName,
    required this.slogan,
    required this.description,
    required this.year,
    required this.skills,
    required this.previewHeadlines,
    this.isDesktop = false,
    this.screenshots = const [],
    this.githubUrl,
    this.liveUrl,
  });

  final String id;
  final String appName;
  final String slogan;
  final String description;
  final String year;
  final List<String> skills;
  final List<String> previewHeadlines;
  final bool isDesktop;
  final List<String> screenshots;
  final String? githubUrl;
  final String? liveUrl;
}
