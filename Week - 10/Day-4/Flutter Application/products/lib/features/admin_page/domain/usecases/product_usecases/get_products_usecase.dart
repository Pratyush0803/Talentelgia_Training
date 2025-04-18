import '../../entities/product_entity.dart';
import '../../repository/category_repository.dart';

class GetProducts {
  final CategoryRepository repository;

  GetProducts(this.repository);

  Stream<List<Product>> call(String categoryId) {
    return repository.getProducts(categoryId);
  }
}