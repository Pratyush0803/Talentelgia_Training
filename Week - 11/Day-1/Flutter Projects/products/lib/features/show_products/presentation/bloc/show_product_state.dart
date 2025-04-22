import 'package:equatable/equatable.dart';
import '../../domain/entity/show_product_entity.dart';

abstract class ShowProductState extends Equatable {
  const ShowProductState();

  @override
  List<Object?> get props => [];
}

class ShowProductInitial extends ShowProductState {}

class ShowProductLoading extends ShowProductState {}

class ShowProductLoaded extends ShowProductState {
  final List<ShowProductEntity> products;

  const ShowProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ShowProductError extends ShowProductState {
  final String message;

  const ShowProductError(this.message);

  @override
  List<Object?> get props => [message];
}