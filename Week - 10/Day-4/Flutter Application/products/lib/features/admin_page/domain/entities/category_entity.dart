class Category {
  final String id;
  final String name;
  final String? imageUrl;
  final DateTime timestamp;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.timestamp,
  });
}