
import '../../domain/entity/add_product_entity.dart';

// Model for a product (optional, can be extended later)
class AddProductModel extends AddProductEntity {
  AddProductModel({
    required super.category,
    required super.description,
    super.subDescription,
    required super.imageUrl,
  });
}