import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/add_product_entity.dart';
import '../../domain/use_cases/add_product_use_case.dart';
import '../../domain/use_cases/delete_product_use_case.dart';
import '../../domain/use_cases/edit_product_use_case.dart';
import 'add_product_event.dart';
import 'add_product_state.dart';

// BLoC for managing add product state and events
class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductUseCase _addProductUseCase;
  final EditProductUseCase _editProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  AddProductBloc({
    required AddProductUseCase addProductUseCase,
    required EditProductUseCase editProductUseCase,
    required DeleteProductUseCase deleteProductUseCase,
  })  : _addProductUseCase = addProductUseCase,
        _editProductUseCase = editProductUseCase,
        _deleteProductUseCase = deleteProductUseCase,
        super(AddProductInitial()) {
    on<AddNewProductEvent>(_onAddProduct);
    on<EditProductEvent>(_onEditProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onAddProduct(
      AddNewProductEvent event,
      Emitter<AddProductState> emit,
      ) async {
    emit(AddProductLoading());
    print('Starting _onAddProduct with product: ${event.product}');
    try {
      if (event.product == null) {
        print('Product data is missing');
        emit(AddProductFailure('Product data is missing'));
        return;
      }
      final entity = AddProductEntity(
        category: event.product!['category'] as String,
        description: event.product!['description'] as String,
        subDescription: event.product!['subDescription'] as String?,
        imageUrl: event.product!['imageUrl'] as String,
      );
      print('Calling _addProductUseCase with entity: $entity');
      await _addProductUseCase(entity);
      print('Product added successfully, emitting AddProductSuccess');
      emit(AddProductSuccess());
    } catch (e) {
      print('Error in _onAddProduct: $e');
      emit(AddProductFailure('Failed to add product: $e'));
    }
  }

  Future<void> _onEditProduct(
      EditProductEvent event,
      Emitter<AddProductState> emit,
      ) async {
    emit(AddProductLoading());
    try {
      if (event.product == null) {
        emit(AddProductFailure('Product data is missing'));
        return;
      }
      final entity = AddProductEntity(
        category: event.product!['category'] as String,
        description: event.product!['description'] as String,
        subDescription: event.product!['subDescription'] as String?,
        imageUrl: event.product!['imageUrl'] as String,
      );
      await _editProductUseCase(event.categoryId, event.productId, entity);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure('Failed to edit product: $e'));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProductEvent event,
      Emitter<AddProductState> emit,
      ) async {
    emit(AddProductLoading());
    try {
      await _deleteProductUseCase(event.categoryId, event.productId);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure('Failed to delete product: $e'));
    }
  }
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