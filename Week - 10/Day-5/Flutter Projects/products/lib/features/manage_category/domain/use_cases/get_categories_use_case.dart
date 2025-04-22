import 'package:products/features/manage_category/domain/entity/manage_category_entity.dart';
import 'package:products/features/manage_category/domain/repositories/manage_category_repository.dart';

class GetCategoriesUseCase {
  final ManageCategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Stream<List<ManageCategoryEntity>> call() {
    return _repository.getCategories();
  }
}