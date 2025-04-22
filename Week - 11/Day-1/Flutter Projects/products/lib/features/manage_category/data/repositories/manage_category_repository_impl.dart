import '../data_sources/manage_category_firestore_data_source.dart';
import '../models/manage_category_model.dart'; // Correct import
import '../../domain/repositories/manage_category_repository.dart';
import '../../domain/entity/manage_category_entity.dart';

class ManageCategoryRepositoryImpl implements ManageCategoryRepository {
  final ManageCategoryFirestoreDataSource _dataSource;

  ManageCategoryRepositoryImpl(this._dataSource);

  @override
  Stream<List<ManageCategoryEntity>> getCategories() {
    return _dataSource.getCategories().map(
          (models) => models
          .map((model) => ManageCategoryEntity(
        id: model.id,
        name: model.name,
        image_url: model.image_url,
        timestamp: model.timestamp,
      ))
          .toList(),
    );
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await _dataSource.deleteCategory(categoryId);
  }

  @override
  Future<void> editCategory(String categoryId, ManageCategoryEntity category) async {
    final model = ManageCategoryModel(
      id: categoryId,
      name: category.name,
      image_url: category.image_url,
      timestamp: category.timestamp ?? DateTime.now(), // Default to now if null
    );
    await _dataSource.editCategory(categoryId, model);
  }
}