import '../../entities/product_entity.dart';
import '../../repository/category_repository.dart';

class UpdateProduct {
  final CategoryRepository repository;

  UpdateProduct(this.repository);

  Future<void> call(Product product, String categoryId) async {
    await repository.updateProduct(product, categoryId);
  }
}