import '../../domain/entity/show_product_entity.dart';
import '../../domain/repositories/show_product_repository.dart';
import '../data_sources/show_product_firestore_data_source.dart';

class ShowProductRepositoryImpl implements ShowProductRepository {
  final ShowProductFirestoreDataSource _dataSource;

  ShowProductRepositoryImpl(this._dataSource);

  @override
  Future<List<ShowProductEntity>> getProductsByCategory(String categoryId) async {
    return await _dataSource.getProductsByCategory(categoryId);
  }

  @override
  Future<void> deleteProduct(String productId, String categoryId) async {
    await _dataSource.deleteProduct(productId, categoryId);
  }

  @override
  Future<void> updateProduct(ShowProductEntity product) async {
    await _dataSource.updateProduct(product);
  }
}
