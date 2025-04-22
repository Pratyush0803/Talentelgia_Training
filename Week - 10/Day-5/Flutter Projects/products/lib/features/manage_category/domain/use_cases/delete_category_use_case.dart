import '../../domain/repositories/manage_category_repository.dart';

class DeleteCategoryUseCase {
  final ManageCategoryRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<void> call(String categoryId) async {
    await _repository.deleteCategory(categoryId);
  }
}