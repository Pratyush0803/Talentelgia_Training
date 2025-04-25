import 'package:blibkit_warehouse/features/inventory/domain/use_cases/get_inventory_usecase.dart';
import 'package:blibkit_warehouse/features/inventory/domain/use_cases/update_inventory_usecase.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_event.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetInventoryUsecase _getInventoryUsecase;
  final UpdateInventoryUsecase _updateInventoryUsecase;

  InventoryBloc(this._updateInventoryUsecase, this._getInventoryUsecase): super (InventoryInitial()){
on<FetchInventoryEvent>(_onFetchInventory as EventHandler<FetchInventoryEvent, InventoryState>);
on<FetchInventoryEvent>(_onUpdateInventory as EventHandler<FetchInventoryEvent, InventoryState>);
  }

  Future<void> _onFetchInventory(
      UpdateInventoryEvent event,
      Emitter<InventoryState> emit,
      ) async {
    emit(InventoryLoading());
    try {
      final products = await _getInventoryUsecase(event.categoryId);
      emit(InventoryLoaded(products));
    } catch (e) {
      emit(InventoryError('Failed to load products: $e'));
    }
  }

  Future<void> _onUpdateInventory(
      UpdateInventoryEvent event,
      Emitter<InventoryState> emit,
      ) async {
    emit(InventoryLoading());
    try {
      await _updateInventoryUsecase(event.product);
      final products = await _getInventoryUsecase(event.categoryId);
      emit(InventoryLoaded(products));
    } catch (e) {
      emit(InventoryError('Failed to update product: $e'));
    }
  }
}
