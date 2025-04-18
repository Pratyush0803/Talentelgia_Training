class Product {
  final String id;
  final String description;
  final String? subDescription;
  final String imageUrl;
  final DateTime timestamp;

  Product({
    required this.id,
    required this.description,
    this.subDescription,
    required this.imageUrl,
    required this.timestamp,
  });
}