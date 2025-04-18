import '../../domain/entities/product_entity.dart';

abstract class CategoryEvent {}

class LoadCategoriesEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final String name;
  final String? imageUrl;

  AddCategoryEvent({required this.name, this.imageUrl});
}

class UpdateCategoryEvent extends CategoryEvent {
  final String id;
  final String name;
  final String? imageUrl;

  UpdateCategoryEvent({required this.id, required this.name, this.imageUrl});
}

class DeleteCategoryEvent extends CategoryEvent {
  final String categoryId;

  DeleteCategoryEvent(this.categoryId);
}

class SelectCategoryEvent extends CategoryEvent {
  final String categoryId;

  SelectCategoryEvent(this.categoryId);
}

class AddProductEvent extends CategoryEvent {
  final String description;
  final String? subDescription;
  final String imageUrl;
  final String categoryId;

  AddProductEvent({
    required this.description,
    this.subDescription,
    required this.imageUrl,
    required this.categoryId,
  });
}

class UpdateProductEvent extends CategoryEvent {
  final String id;
  final String description;
  final String? subDescription;
  final String imageUrl;
  final String categoryId;

  UpdateProductEvent({
    required this.id,
    required this.description,
    this.subDescription,
    required this.imageUrl,
    required this.categoryId,
  });
}

class DeleteProductEvent extends CategoryEvent {
  final String categoryId;
  final String productId;

  DeleteProductEvent(this.categoryId, this.productId);
}

class SignOutEvent extends CategoryEvent {}

class UpdateProductsEvent extends CategoryEvent {
  final List<Product> products;
  final String categoryId;

  UpdateProductsEvent(this.products, this.categoryId);
}

class StartEditCategoryEvent extends CategoryEvent {
  final String categoryId;

  StartEditCategoryEvent(this.categoryId);
}

class StartEditProductEvent extends CategoryEvent {
  final String productId;
  final String categoryId;

  StartEditProductEvent(this.productId, this.categoryId);
}

class ViewCategoryEvent extends CategoryEvent {
  final String categoryId;

  ViewCategoryEvent(this.categoryId);
}

class CancelEditEvent extends CategoryEvent {}