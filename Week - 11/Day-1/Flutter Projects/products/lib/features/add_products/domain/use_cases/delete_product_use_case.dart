import '../repositories/add_product_repository.dart';

// Use case to delete an existing product
class DeleteProductUseCase {
  final AddProductRepository _repository;

  DeleteProductUseCase(this._repository);

  Future<void> call(String categoryId, String productId) async {
    await _repository.deleteProduct(categoryId, productId);
  }
}