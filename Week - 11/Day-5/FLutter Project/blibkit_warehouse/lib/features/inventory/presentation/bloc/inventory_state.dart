import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';
import 'package:equatable/equatable.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object?> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<InventoryEntity> products;

  const InventoryLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class InventoryError extends InventoryState {
  final String message;

  const InventoryError(this.message);

  @override
  List<Object?> get props => [message];
}
