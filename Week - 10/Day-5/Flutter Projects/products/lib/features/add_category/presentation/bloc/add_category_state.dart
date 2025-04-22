abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryLoading extends AddCategoryState {}

class AddCategorySuccess extends AddCategoryState {
  final String categoryId;

  AddCategorySuccess(this.categoryId);
}

class AddCategoryFailure extends AddCategoryState {
  final String message;

  AddCategoryFailure(this.message);
}