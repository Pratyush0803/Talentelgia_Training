import '../../domain/entity/add_product_entity.dart';
import '../../domain/repositories/add_product_repository.dart';
import '../data_sources/add_product_firestore_data_source.dart';

// Implementation of the add product repositories
class AddProductRepositoryImpl implements AddProductRepository {
  final AddProductFirestoreDataSource _dataSource;

  AddProductRepositoryImpl(this._dataSource);

  @override
  Future<void> addProduct(AddProductEntity product) async {
    try {
      await _dataSource.addProduct(product);
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  @override
  Future<void> editProduct(String categoryId, String productId, AddProductEntity product) async {
    try {
      await _dataSource.editProduct(categoryId, productId, product);
    } catch (e) {
      throw Exception('Failed to edit product: $e');
    }
  }

  @override
  Future<void> deleteProduct(String categoryId, String productId) async {
    try {
      await _dataSource.deleteProduct(categoryId, productId);
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}