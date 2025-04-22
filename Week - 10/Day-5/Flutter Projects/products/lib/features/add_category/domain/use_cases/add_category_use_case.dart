import '../repositories/add_category_repository.dart';
import '../entity/add_category_entity.dart';

class AddCategoryUseCase {
  final AddCategoryRepository _repository;

  AddCategoryUseCase(this._repository);

  Future<String> call(AddCategoryEntity category) async {
    return await _repository.addCategory(category);
  }
}