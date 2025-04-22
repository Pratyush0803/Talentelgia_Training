import '../../domain/entity/manage_category_entity.dart';

abstract class ManageCategoryRepository {
  Stream<List<ManageCategoryEntity>> getCategories();
  Future<void> deleteCategory(String categoryId);
  Future<void> editCategory(String categoryId, ManageCategoryEntity category);
}