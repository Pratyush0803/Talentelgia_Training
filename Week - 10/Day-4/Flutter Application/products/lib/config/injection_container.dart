import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:products/features/auth/data/repository/auth_repository_impl.dart';
import 'package:products/features/auth/domain/repository/auth_repository.dart';
import 'package:products/features/auth/domain/usecases/login_usecase.dart';
import 'package:products/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:products/features/admin_page/data/datasource/firebase_datasource.dart';
import 'package:products/features/admin_page/data/repository/category_repository_impl.dart';
import 'package:products/features/admin_page/domain/usecases/category_usecases/add_category_usecase.dart';
import 'package:products/features/admin_page/domain/usecases/category_usecases/delete_category_usecase.dart';
import 'package:products/features/admin_page/domain/usecases/category_usecases/get_categories_usecase.dart';
import 'package:products/features/admin_page/domain/usecases/category_usecases/update_category_usecase.dart';
import 'package:products/features/admin_page/domain/usecases/product_usecases/add_product_usecase.dart';
import 'package:products/features/admin_page/domain/usecases/product_usecases/delete_product_usecase.dart';
import 'package:products/features/admin_page/domain/usecases/product_usecases/get_products_usecase.dart';
import 'package:products/features/admin_page/domain/usecases/product_usecases/update_product_usecase.dart';
import 'package:products/features/admin_page/presentation/bloc/category_bloc.dart';

import '../features/admin_page/domain/repository/category_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase Auth Setup
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Auth Repository and UseCases
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));

  // Registering AuthBloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));

  // Firebase DataSource
  sl.registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSource());

  // Category Repository
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(sl()));

  // Category UseCases
  sl.registerLazySingleton<GetCategories>(() => GetCategories(sl()));
  sl.registerLazySingleton<AddCategory>(() => AddCategory(sl()));
  sl.registerLazySingleton<UpdateCategory>(() => UpdateCategory(sl()));
  sl.registerLazySingleton<DeleteCategory>(() => DeleteCategory(sl()));

  // Product UseCases
  sl.registerLazySingleton<AddProduct>(() => AddProduct(sl()));
  sl.registerLazySingleton<UpdateProduct>(() => UpdateProduct(sl()));
  sl.registerLazySingleton<DeleteProduct>(() => DeleteProduct(sl()));
  sl.registerLazySingleton<GetProducts>(() => GetProducts(sl()));

  // Registering CategoryBloc
  sl.registerFactory<CategoryBloc>(() => CategoryBloc(
    getCategories: sl(),
    addCategory: sl(),
    updateCategory: sl(),
    deleteCategory: sl(),
    addProduct: sl(),
    updateProduct: sl(),
    deleteProduct: sl(),
    getProducts: sl(),
    firebaseDataSource: sl(),
  ));
}