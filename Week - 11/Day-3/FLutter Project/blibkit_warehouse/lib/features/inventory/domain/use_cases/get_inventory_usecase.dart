import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';
import 'package:blibkit_warehouse/features/inventory/domain/repository/inventory_repository.dart';

class GetInventoryUsecase {
  final InventoryRepository _repository;

  GetInventoryUsecase(this._repository);

  Future<List<InventoryEntity>> call(String categoryId) async {
    return await _repository.getProducts(categoryId);
  }
}
