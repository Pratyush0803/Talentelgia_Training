import '../../repository/category_repository.dart';

class DeleteProduct {
  final CategoryRepository repository;

  DeleteProduct(this.repository);

  Future<void> call(String categoryId, String productId) async {
    await repository.deleteProduct(categoryId, productId);
  }
}