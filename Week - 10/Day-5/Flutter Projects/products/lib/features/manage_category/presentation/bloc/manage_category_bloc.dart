import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/entity/manage_category_entity.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/delete_category_use_case.dart';
import '../../domain/use_cases/edit_category_use_case.dart' as manageEdit;
import 'manage_category_event.dart';
import 'manage_category_state.dart';

class ManageCategoryBloc extends Bloc<ManageCategoryEvent, ManageCategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  final manageEdit.EditCategoryUseCase _editCategoryUseCase;

  ManageCategoryBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required DeleteCategoryUseCase deleteCategoryUseCase,
    required manageEdit.EditCategoryUseCase editCategoryUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _deleteCategoryUseCase = deleteCategoryUseCase,
        _editCategoryUseCase = editCategoryUseCase,
        super(ManageCategoryInitial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<DeleteCategoryEvent>(_onDeleteCategory);
    on<EditCategoryEvent>(_onEditCategory);
  }

  Future<void> _onFetchCategories(
      FetchCategoriesEvent event,
      Emitter<ManageCategoryState> emit,
      ) async {
    print('Fetching categories...');
    emit(ManageCategoryLoading());
    try {
      final categories = await _getCategoriesUseCase().take(1).toList().then((list) => list.first);
      print('Categories received: $categories');
      emit(ManageCategoryLoaded(categories.cast<ManageCategoryEntity>()));
    } catch (e) {
      print('Error fetching categories: $e');
      emit(ManageCategoryError('Failed to load categories: $e'));
    }
  }

  Future<void> _onDeleteCategory(
      DeleteCategoryEvent event,
      Emitter<ManageCategoryState> emit,
      ) async {
    emit(ManageCategoryLoading());
    try {
      await _deleteCategoryUseCase(event.categoryId);
      add(FetchCategoriesEvent()); // Refresh after delete
    } catch (e) {
      emit(ManageCategoryError('Failed to delete category: $e'));
    }
  }

  Future<void> _onEditCategory(
      EditCategoryEvent event,
      Emitter<ManageCategoryState> emit,
      ) async {
    print('Editing category with ID: ${event.categoryId}, newName: ${event.newName}, newImageUrl: ${event.newImageUrl}');
    emit(ManageCategoryLoading());
    try {
      await _editCategoryUseCase(event.categoryId, ManageCategoryEntity(
        id: event.categoryId,
        name: event.newName,
        image_url: event.newImageUrl,
        timestamp: DateTime.now(),
      ));
      add(FetchCategoriesEvent()); // Refresh after edit
    } catch (e) {
      print('Edit error: $e');
      emit(ManageCategoryError('Failed to edit category: $e'));
    }
  }
}