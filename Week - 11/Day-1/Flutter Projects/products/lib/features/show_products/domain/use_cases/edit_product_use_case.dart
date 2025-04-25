import '../entity/show_product_entity.dart';
import '../repositories/show_product_repository.dart';

class EditProductUseCase {
  final ShowProductRepository _repository;

  EditProductUseCase(this._repository);

  Future<void> call(ShowProductEntity product) async {
    await _repository.updateProduct(product);
  }
}