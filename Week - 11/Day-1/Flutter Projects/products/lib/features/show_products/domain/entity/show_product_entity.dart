class ShowProductEntity {
  final String id;
  final String? description;
  final String? sub_description;
  final String? image_url;
  final String category_id;
  final String created_by;
  final DateTime timestamp;

  ShowProductEntity({
    required this.id,
    this.description,
    this.sub_description,
    this.image_url,
    required this.category_id,
    required this.created_by,
    required this.timestamp,
  });
}