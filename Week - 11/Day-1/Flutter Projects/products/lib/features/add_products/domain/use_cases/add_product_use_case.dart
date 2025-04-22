import '../entity/add_product_entity.dart';
import '../repositories/add_product_repository.dart';

// Use case to add a new product
class AddProductUseCase {
  final AddProductRepository _repository;

  AddProductUseCase(this._repository);

  Future<void> call(AddProductEntity product) async {
    await _repository.addProduct(product);
  }
}