import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final String? selectedCategoryId;
  final List<Product> products;
  final String? editingCategoryId;
  final String? editingProductId;

  CategoryLoaded({
    required this.categories,
    this.selectedCategoryId,
    required this.products,
    this.editingCategoryId,
    this.editingProductId,
  });
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}

class SignedOut extends CategoryState {}