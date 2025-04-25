import '../repositories/show_product_repository.dart';

class DeleteProductUseCase {
  final ShowProductRepository _repository;

  DeleteProductUseCase(this._repository);

  Future<void> call(String productId, String categoryId) async {
    await _repository.deleteProduct(productId, categoryId);
  }
}
