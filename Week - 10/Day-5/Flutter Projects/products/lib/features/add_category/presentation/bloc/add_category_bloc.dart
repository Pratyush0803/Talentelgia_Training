import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/add_category_entity.dart';
import '../../domain/use_cases/add_category_use_case.dart';
import '../../domain/use_cases/edit_category_use_case.dart' as addEdit;
import 'add_category_event.dart';
import 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final AddCategoryUseCase _addCategoryUseCase;
  final addEdit.EditCategoryUseCase _editCategoryUseCase;

  AddCategoryBloc({
    required AddCategoryUseCase addCategoryUseCase,
    required addEdit.EditCategoryUseCase editCategoryUseCase,
  })  : _addCategoryUseCase = addCategoryUseCase,
        _editCategoryUseCase = editCategoryUseCase,
        super(AddCategoryInitial()) {
    on<AddNewCategoryEvent>(_onAddNewCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
  }

  Future<void> _onAddNewCategory(
      AddNewCategoryEvent event,
      Emitter<AddCategoryState> emit,
      ) async {
    emit(AddCategoryLoading());
    try {
      final categoryId = await _addCategoryUseCase(event.category);
      emit(AddCategorySuccess(categoryId));
    } catch (e) {
      emit(AddCategoryFailure('Failed to add category: $e'));
    }
  }

  Future<void> _onUpdateCategory(
      UpdateCategoryEvent event,
      Emitter<AddCategoryState> emit,
      ) async {
    emit(AddCategoryLoading());
    try {
      await _editCategoryUseCase(event.categoryId, event.category);
      emit(AddCategorySuccess(event.categoryId));
    } catch (e) {
      emit(AddCategoryFailure('Failed to update category: $e'));
    }
  }
}