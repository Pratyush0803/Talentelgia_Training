import '../../domain/repositories/manage_category_repository.dart';
import '../../domain/entity/manage_category_entity.dart';

class EditCategoryUseCase {
  final ManageCategoryRepository _repository;

  EditCategoryUseCase(this._repository);

  Future<void> call(String categoryId, ManageCategoryEntity category) async {
    print('EditCategoryUseCase called for categoryId: $categoryId');
    await _repository.editCategory(categoryId, category);
  }
}