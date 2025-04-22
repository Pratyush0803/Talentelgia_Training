import '../repositories/add_category_repository.dart';
import '../entity/add_category_entity.dart';

class EditCategoryUseCase {
  final AddCategoryRepository _repository;

  EditCategoryUseCase(this._repository);

  Future<void> call(String categoryId, AddCategoryEntity category) async {
    return await _repository.editCategory(categoryId, category);
  }
}