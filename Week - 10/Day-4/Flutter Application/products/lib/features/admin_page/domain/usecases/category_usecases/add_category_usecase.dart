import '../../entities/category_entity.dart';
import '../../repository/category_repository.dart';

class AddCategory {
  final CategoryRepository repository;

  AddCategory(this.repository);

  Future<void> call(Category category) async {
    await repository.addCategory(category);
  }
}