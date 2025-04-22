import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<void> addCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String categoryId);
  Future<void> addProduct(Product product, String categoryId);
  Future<void> updateProduct(Product product, String categoryId);
  Future<void> deleteProduct(String categoryId, String productId);
  Stream<List<Product>> getProducts(String categoryId);
}