import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasource/firebase_datasource.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/category_usecases/add_category_usecase.dart';
import '../../domain/usecases/category_usecases/delete_category_usecase.dart';
import '../../domain/usecases/category_usecases/get_categories_usecase.dart';
import '../../domain/usecases/category_usecases/update_category_usecase.dart';
import '../../domain/usecases/product_usecases/add_product_usecase.dart';
import '../../domain/usecases/product_usecases/delete_product_usecase.dart';
import '../../domain/usecases/product_usecases/get_products_usecase.dart';
import '../../domain/usecases/product_usecases/update_product_usecase.dart';
import 'category_event.dart';
import 'category_state.dart';

// CategoryBloc: Manages state and events for category and product operations
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;
  final AddCategory addCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;
  final AddProduct addProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;
  final GetProducts getProducts;
  final FirebaseDataSource firebaseDataSource;
  StreamSubscription? _productsSubscription;

  CategoryBloc({
    required this.getCategories,
    required this.addCategory,
    required this.updateCategory,
    required this.deleteCategory,
    required this.addProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.getProducts,
    required this.firebaseDataSource,
  }) : super(CategoryInitial()) {
    // Register event handlers
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<SignOutEvent>(_onSignOut);
    on<UpdateProductsEvent>(_onUpdateProducts);
    on<StartEditCategoryEvent>(_onStartEditCategory);
    on<StartEditProductEvent>(_onStartEditProduct);
    on<ViewCategoryEvent>(_onViewCategory);
    on<CancelEditEvent>(_onCancelEdit);

    // Listen for authentication state changes
    firebaseDataSource.authStateChanges.listen((user) {
      if (user == null) {
        add(SignOutEvent());
      }
    });
  }

  // Load Categories: Fetch all categories from Firestore
  Future<void> _onLoadCategories(LoadCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await getCategories();
      emit(CategoryLoaded(categories: categories, products: []));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  // Add Category: Create a new category
  Future<void> _onAddCategory(AddCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      final category = Category(
        id: '',
        name: event.name,
        imageUrl: event.imageUrl,
        timestamp: DateTime.now(),
      );
      await addCategory(category);
      final categories = await getCategories();
      emit(CategoryLoaded(categories: categories, products: []));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  // Update Category: Update an existing category
  Future<void> _onUpdateCategory(UpdateCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      final category = Category(
        id: event.id,
        name: event.name,
        imageUrl: event.imageUrl,
        timestamp: DateTime.now(),
      );
      await updateCategory(category);
      final categories = await getCategories();
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        emit(CategoryLoaded(
          categories: categories,
          selectedCategoryId: currentState.selectedCategoryId,
          products: currentState.products,
          editingCategoryId: null,
          editingProductId: null,
        ));
      } else {
        emit(CategoryLoaded(categories: categories, products: []));
      }
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  // Delete Category: Remove a category and its products
  Future<void> _onDeleteCategory(DeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      await deleteCategory(event.categoryId);
      final categories = await getCategories();
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        emit(CategoryLoaded(
          categories: categories,
          selectedCategoryId: currentState.selectedCategoryId == event.categoryId ? null : currentState.selectedCategoryId,
          products: currentState.selectedCategoryId == event.categoryId ? [] : currentState.products,
          editingCategoryId: null,
          editingProductId: null,
        ));
      } else {
        emit(CategoryLoaded(categories: categories, products: []));
      }
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  // Select Category: Load products for a selected category
  Future<void> _onSelectCategory(SelectCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      _productsSubscription?.cancel();
      _productsSubscription = getProducts(event.categoryId).listen((products) {
        add(UpdateProductsEvent(products, event.categoryId));
      });
      emit(CategoryLoaded(
        categories: currentState.categories,
        selectedCategoryId: event.categoryId,
        products: [],
        editingCategoryId: null,
        editingProductId: null,
      ));
    }
  }

  // View Category: Load products for a selected category and clear edit states
  Future<void> _onViewCategory(ViewCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      _productsSubscription?.cancel();
      _productsSubscription = getProducts(event.categoryId).listen((products) {
        add(UpdateProductsEvent(products, event.categoryId));
      });
      emit(CategoryLoaded(
        categories: currentState.categories,
        selectedCategoryId: event.categoryId,
        products: [],
        editingCategoryId: null,
        editingProductId: null,
      ));
    }
  }

  // Cancel Edit: Clear editing state
  Future<void> _onCancelEdit(CancelEditEvent event, Emitter<CategoryState> emit) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      emit(CategoryLoaded(
        categories: currentState.categories,
        selectedCategoryId: currentState.selectedCategoryId,
        products: currentState.products,
        editingCategoryId: null,
        editingProductId: null,
      ));
    }
  }

  // Add Product: Create a new product
  Future<void> _onAddProduct(AddProductEvent event, Emitter<CategoryState> emit) async {
    try {
      final product = Product(
        id: '',
        description: event.description,
        subDescription: event.subDescription,
        imageUrl: event.imageUrl,
        timestamp: DateTime.now(),
      );
      await addProduct(product, event.categoryId);
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        emit(CategoryLoaded(
          categories: currentState.categories,
          selectedCategoryId: currentState.selectedCategoryId,
          products: currentState.products,
          editingCategoryId: null,
          editingProductId: null,
        ));
      }
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  // Update Product: Update an existing product
  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<CategoryState> emit) async {
    try {
      final product = Product(
        id: event.id,
        description: event.description,
        subDescription: event.subDescription,
        imageUrl: event.imageUrl,
        timestamp: DateTime.now(),
      );
      await updateProduct(product, event.categoryId);
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        emit(CategoryLoaded(
          categories: currentState.categories,
          selectedCategoryId: currentState.selectedCategoryId,
          products: currentState.products,
          editingCategoryId: null,
          editingProductId: null,
        ));
      }
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  // Delete Product: Remove a product
  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<CategoryState> emit) async {
    try {
      await deleteProduct(event.categoryId, event.productId);
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        emit(CategoryLoaded(
          categories: currentState.categories,
          selectedCategoryId: currentState.selectedCategoryId,
          products: currentState.products,
          editingCategoryId: null,
          editingProductId: null,
        ));
      }
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  // Sign Out: Handle user logout
  Future<void> _onSignOut(SignOutEvent event, Emitter<CategoryState> emit) async {
    try {
      await firebaseDataSource.signOut();
      emit(SignedOut());
    } catch (e) {
      emit(CategoryError('Failed to sign out: $e'));
    }
  }

  // Update Products: Refresh product list for a category
  void _onUpdateProducts(UpdateProductsEvent event, Emitter<CategoryState> emit) {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      emit(CategoryLoaded(
        categories: currentState.categories,
        selectedCategoryId: event.categoryId,
        products: event.products,
        editingCategoryId: null,
        editingProductId: null,
      ));
    }
  }

  // Start Edit Category: Set state for editing a category
  Future<void> _onStartEditCategory(StartEditCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      emit(CategoryLoaded(
        categories: currentState.categories,
        selectedCategoryId: currentState.selectedCategoryId,
        products: currentState.products,
        editingCategoryId: event.categoryId,
        editingProductId: null,
      ));
    }
  }

  // Start Edit Product: Set state for editing a product
  Future<void> _onStartEditProduct(StartEditProductEvent event, Emitter<CategoryState> emit) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      emit(CategoryLoaded(
        categories: currentState.categories,
        selectedCategoryId: event.categoryId,
        products: currentState.products,
        editingCategoryId: null,
        editingProductId: event.productId,
      ));
    }
  }

  @override
  Future<void> close() {
    // Clean up product subscription
    _productsSubscription?.cancel();
    return super.close();
  }
}