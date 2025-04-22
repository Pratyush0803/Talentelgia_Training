import '../entity/add_category_entity.dart';

abstract class AddCategoryRepository {
  Future<String> addCategory(AddCategoryEntity category);
  Future<void> editCategory(String categoryId, AddCategoryEntity category);
}