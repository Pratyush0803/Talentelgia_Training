import '../../entities/product_entity.dart';
import '../../repository/category_repository.dart';

class AddProduct {
  final CategoryRepository repository;

  AddProduct(this.repository);

  Future<void> call(Product product, String categoryId) async {
    await repository.addProduct(product, categoryId);
  }
}