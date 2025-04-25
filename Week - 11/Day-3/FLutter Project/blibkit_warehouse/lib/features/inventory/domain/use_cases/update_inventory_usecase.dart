import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';
import 'package:blibkit_warehouse/features/inventory/domain/repository/inventory_repository.dart';

class UpdateInventoryUsecase {
  final InventoryRepository _repository;

  UpdateInventoryUsecase(this._repository);

  Future<void> call(InventoryEntity product) async {
    await _repository.updateProduct(product);
  }
}
