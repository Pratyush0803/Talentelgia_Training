
import '../entity/add_product_entity.dart';
import '../repositories/add_product_repository.dart';

// Use case to edit an existing product
class EditProductUseCase {
  final AddProductRepository _repository;

  EditProductUseCase(this._repository);

  Future<void> call(String categoryId, String productId, AddProductEntity product) async {
    await _repository.editProduct(categoryId, productId, product);
  }
}