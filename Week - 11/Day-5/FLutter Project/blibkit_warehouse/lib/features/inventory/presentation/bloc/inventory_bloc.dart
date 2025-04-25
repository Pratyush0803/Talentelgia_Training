import 'package:blibkit_warehouse/features/inventory/domain/use_cases/get_inventory_usecase.dart';
import 'package:blibkit_warehouse/features/inventory/domain/use_cases/update_inventory_usecase.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_event.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetInventoryUsecase _getInventoryUsecase;
  final UpdateInventoryUsecase _updateInventoryUsecase;
  InventoryEvent? _lastEvent;

  InventoryBloc(this._getInventoryUsecase, this._updateInventoryUsecase)
      : super(InventoryInitial()) {
    on<FetchInventoryEvent>(_onFetchInventory);
    on<UpdateInventoryEvent>(_onUpdateInventory);
  }

  InventoryEvent? get lastEvent => _lastEvent;

  Future<void> _onFetchInventory(
      FetchInventoryEvent event,
      Emitter<InventoryState> emit,
      ) async {
    emit(InventoryLoading());
    try {
      _lastEvent = event;
      await for (final products in _getInventoryUsecase(event.categoryId)) {
        emit(InventoryLoaded(products));
      }
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
      _lastEvent = event;
      await _updateInventoryUsecase(event.product);
      await for (final products in _getInventoryUsecase(event.categoryId)) {
        if (_lastEvent is UpdateInventoryEvent) {
          emit(InventoryLoaded(products));
          _lastEvent = null;
        }
      }
    } catch (e) {
      emit(InventoryError('Failed to update product: $e'));
    }
  }
}