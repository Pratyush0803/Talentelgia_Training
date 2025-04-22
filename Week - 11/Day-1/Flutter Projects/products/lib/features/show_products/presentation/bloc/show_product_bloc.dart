import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/delete_product_use_case.dart';
import '../../domain/use_cases/edit_product_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';
import 'show_product_event.dart';
import 'show_product_state.dart';

class ShowProductBloc extends Bloc<ShowProductEvent, ShowProductState> {
  final GetProductsUseCase _getProductsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final EditProductUseCase _editProductUseCase;

  ShowProductBloc(
      this._getProductsUseCase,
      this._deleteProductUseCase,
      this._editProductUseCase,
      ) : super(ShowProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  Future<void> _onFetchProducts(
      FetchProductsEvent event,
      Emitter<ShowProductState> emit,
      ) async {
    emit(ShowProductLoading());
    try {
      print('Fetching products for categoryId: ${event.categoryId}');
      final products = await _getProductsUseCase(event.categoryId);
      print('Fetched products count: ${products.length}');
      emit(ShowProductLoaded(products));
    } catch (e) {
      print('Fetch error: $e');
      emit(ShowProductError('Failed to load products: $e'));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProductEvent event,
      Emitter<ShowProductState> emit,
      ) async {
    emit(ShowProductLoading());
    try {
      print('Deleting product with ID: ${event.productId} in category: ${event.categoryId}');
      await _deleteProductUseCase(event.productId, event.categoryId);
      final products = await _getProductsUseCase(event.categoryId);
      print('Refetched products count after delete: ${products.length}');
      emit(ShowProductLoaded(products));
    } catch (e) {
      print('Delete error: $e');
      emit(ShowProductError('Failed to delete product: $e'));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProductEvent event,
      Emitter<ShowProductState> emit,
      ) async {
    emit(ShowProductLoading());
    try {
      print('Updating product with ID: ${event.product.id}');
      await _editProductUseCase(event.product);
      final products = await _getProductsUseCase(event.categoryId);
      print('Refetched products count after update: ${products.length}');
      emit(ShowProductLoaded(products));
    } catch (e) {
      print('Update error: $e');
      emit(ShowProductError('Failed to update product: $e'));
    }
  }
}
