import 'package:blibkit_warehouse/features/inventory/data/data_sources/inventory_data_source.dart';
import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';
import 'package:blibkit_warehouse/features/inventory/domain/repository/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryDataSource _dataSource;

  InventoryRepositoryImpl(this._dataSource);

  @override
  Stream<List<InventoryEntity>> getProducts(String categoryId) {
    return _dataSource.getProducts(categoryId);
  }

  @override
  Future<void> updateProduct(InventoryEntity product) async {
    await _dataSource.updateProduct(product);
  }
}