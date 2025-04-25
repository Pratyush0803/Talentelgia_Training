import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/add_product_use_case.dart';
import '../../domain/use_cases/delete_product_use_case.dart';
import '../../domain/use_cases/edit_product_use_case.dart';
import '../bloc/add_product_event.dart';
import '../bloc/add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductUseCase _addProductUseCase;
  final EditProductUseCase _editProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  AddProductBloc(
      this._addProductUseCase,
      this._editProductUseCase,
      this._deleteProductUseCase,
      ) : super(AddProductInitial()) {
    on<AddNewProductEvent>(_onAddNewProduct);
    on<EditProductEvent>(_onEditProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onAddNewProduct(AddNewProductEvent event, Emitter<AddProductState> emit) async {
    emit(AddProductLoading());
    try {
      await _addProductUseCase.call(event.product);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure('Failed to add product: $e'));
    }
  }

  Future<void> _onEditProduct(EditProductEvent event, Emitter<AddProductState> emit) async {
    emit(AddProductLoading());
    try {
      await _editProductUseCase.call(event.categoryId, event.productId, event.product);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure('Failed to edit product: $e'));
    }
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<AddProductState> emit) async {
    emit(AddProductLoading());
    try {
      await _deleteProductUseCase.call(event.categoryId, event.productId);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure('Failed to delete product: $e'));
    }
  }
}