import '../entity/show_product_entity.dart';
import '../repositories/show_product_repository.dart';

class GetProductsUseCase {
  final ShowProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<List<ShowProductEntity>> call(String categoryId) async {
    return await _repository.getProductsByCategory(categoryId);
  }
}