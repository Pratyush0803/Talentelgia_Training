import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products/features/add_category/data/models/add_category_model.dart';
import '../data_sources/add_category_firestore_data_source.dart';
import '../../domain/repositories/add_category_repository.dart';
import '../../domain/entity/add_category_entity.dart';

class AddCategoryRepositoryImpl implements AddCategoryRepository {
  final AddCategoryFirestoreDataSource _dataSource;

  AddCategoryRepositoryImpl(this._dataSource);

  @override
  Future<String> addCategory(AddCategoryEntity category) async {
    final model = AddCategoryModel(
      id: '',
      name: category.name,
      image_url: category.image_url,
      timestamp: category.timestamp,
    );
    return await _dataSource.addCategory(model);
  }

  @override
  Future<void> editCategory(String categoryId, AddCategoryEntity category) async {
    final model = AddCategoryModel(
      id: categoryId,
      name: category.name,
      image_url: category.image_url,
      timestamp: category.timestamp,
    );
    await _dataSource.editCategory(categoryId, model);
  }
}
