import '../../domain/entity/manage_category_entity.dart';

abstract class ManageCategoryState {}

class ManageCategoryInitial extends ManageCategoryState {}

class ManageCategoryLoading extends ManageCategoryState {}

class ManageCategoryLoaded extends ManageCategoryState {
  final List<ManageCategoryEntity> categories;

  ManageCategoryLoaded(this.categories);
}

class ManageCategoryError extends ManageCategoryState {
  final String message;

  ManageCategoryError(this.message);
}

class ManageCategoryActionSuccess extends ManageCategoryState {
  final String message;

  ManageCategoryActionSuccess(this.message);
}