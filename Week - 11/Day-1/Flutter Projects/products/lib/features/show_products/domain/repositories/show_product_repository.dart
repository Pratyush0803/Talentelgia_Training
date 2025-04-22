import '../entity/show_product_entity.dart';

abstract class ShowProductRepository {
  Future<List<ShowProductEntity>> getProductsByCategory(String categoryId);
  Future<void> deleteProduct(String productId, String categoryId);
  Future<void> updateProduct(ShowProductEntity product);
}
