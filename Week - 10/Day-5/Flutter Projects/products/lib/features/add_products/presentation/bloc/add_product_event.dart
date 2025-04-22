import 'package:equatable/equatable.dart';

// Abstract base class for add product events
abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object?> get props => [];
}

// Event to trigger adding a new product
class AddNewProductEvent extends AddProductEvent {
  final Map<String, dynamic>? product;

  const AddNewProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

// Event to trigger editing a product
class EditProductEvent extends AddProductEvent {
  final String categoryId;
  final String productId;
  final Map<String, dynamic>? product;

  const EditProductEvent(this.categoryId, this.productId, this.product);

  @override
  List<Object?> get props => [categoryId, productId, product];
}

// Event to trigger deleting a product
class DeleteProductEvent extends AddProductEvent {
  final String categoryId;
  final String productId;

  const DeleteProductEvent(this.categoryId, this.productId);

  @override
  List<Object?> get props => [categoryId, productId];
}