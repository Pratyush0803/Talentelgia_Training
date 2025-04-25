class InventoryEntity {
  final String id;
  final String? description;
  final String? subDescription;
  final String? imageUrl;
  final String categoryId;
  final String timestamp;

  InventoryEntity({
    required this.id,
    required this.description,
    required this.subDescription,
    required this.imageUrl,
    required this.categoryId,
    required this.timestamp,
  });
}
