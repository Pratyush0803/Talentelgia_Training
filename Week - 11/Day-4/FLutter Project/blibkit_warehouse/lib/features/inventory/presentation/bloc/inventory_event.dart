import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';
import 'package:equatable/equatable.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchInventoryEvent extends InventoryEvent {
  final String categoryId;

  const FetchInventoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class UpdateInventoryEvent extends InventoryEvent {
  final InventoryEntity product;
  final String categoryId;

  const UpdateInventoryEvent(this.product, this.categoryId);

  @override
  List<Object?> get props => [product, categoryId];
}
