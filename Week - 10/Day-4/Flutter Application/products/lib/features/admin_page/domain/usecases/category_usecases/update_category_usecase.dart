import '../../entities/category_entity.dart';
import '../../repository/category_repository.dart';

class UpdateCategory {
  final CategoryRepository repository;

  UpdateCategory(this.repository);

  Future<void> call(Category category) async {
    await repository.updateCategory(category);
  }
}