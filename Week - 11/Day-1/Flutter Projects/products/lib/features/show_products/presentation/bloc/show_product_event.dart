import 'package:equatable/equatable.dart';
import '../../domain/entity/show_product_entity.dart';

abstract class ShowProductEvent extends Equatable {
  const ShowProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ShowProductEvent {
  final String categoryId;

  const FetchProductsEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class DeleteProductEvent extends ShowProductEvent {
  final String productId;
  final String categoryId;

  const DeleteProductEvent(this.productId, this.categoryId);

  @override
  List<Object?> get props => [productId, categoryId];
}

class UpdateProductEvent extends ShowProductEvent {
  final ShowProductEntity product;
  final String categoryId; // Added categoryId

  const UpdateProductEvent(this.product, this.categoryId);

  @override
  List<Object?> get props => [product, categoryId];
}