import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';

abstract class InventoryRepository {
  Stream<List<InventoryEntity>> getProducts(String categoryId);
  Future<void> updateProduct(InventoryEntity product);
}