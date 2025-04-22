import '../entity/add_product_entity.dart';

// Repository interface for add product operations
abstract class AddProductRepository {
  Future<void> addProduct(AddProductEntity product);
  Future<void> editProduct(String categoryId, String productId, AddProductEntity product);
  Future<void> deleteProduct(String categoryId, String productId);
}