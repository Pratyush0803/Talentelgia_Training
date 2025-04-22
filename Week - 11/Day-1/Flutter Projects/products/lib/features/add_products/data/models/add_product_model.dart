import '../../domain/entity/add_product_entity.dart';

// Model for a product (optional, can be extended later)
class AddProductModel extends AddProductEntity {
  const AddProductModel({
    required super.category_id,
    required super.description,
    super.sub_description,
    required super.image_url,
    required super.created_by,
    required super.timestamp,
  });
}