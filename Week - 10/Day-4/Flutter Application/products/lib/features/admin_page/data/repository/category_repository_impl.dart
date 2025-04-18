import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/category_repository.dart';
import '../datasource/firebase_datasource.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final FirebaseDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<Category>> getCategories() async {
    try {
      return await dataSource.getCategories();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addCategory(Category category) async {
    try {
      await dataSource.addCategory(CategoryModel(
        id: category.id,
        name: category.name,
        imageUrl: category.imageUrl,
        timestamp: category.timestamp,
      ));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateCategory(Category category) async {
    try {
      await dataSource.updateCategory(CategoryModel(
        id: category.id,
        name: category.name,
        imageUrl: category.imageUrl,
        timestamp: category.timestamp,
      ));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    try {
      await dataSource.deleteCategory(categoryId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addProduct(Product product, String categoryId) async {
    try {
      await dataSource.addProduct(
        ProductModel(
          id: product.id,
          description: product.description,
          subDescription: product.subDescription,
          imageUrl: product.imageUrl,
          timestamp: product.timestamp,
        ),
        categoryId,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateProduct(Product product, String categoryId) async {
    try {
      await dataSource.updateProduct(
        ProductModel(
          id: product.id,
          description: product.description,
          subDescription: product.subDescription,
          imageUrl: product.imageUrl,
          timestamp: product.timestamp,
        ),
        categoryId,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(String categoryId, String productId) async {
    try {
      await dataSource.deleteProduct(categoryId, productId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<Product>> getProducts(String categoryId) {
    try {
      return dataSource.getProducts(categoryId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}