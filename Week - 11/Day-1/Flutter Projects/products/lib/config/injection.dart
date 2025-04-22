import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/add_category/data/data_sources/add_category_firestore_data_source.dart';
import '../features/add_category/data/repositories/add_category_repository_impl.dart';
import '../features/add_category/domain/repositories/add_category_repository.dart';
import '../features/add_category/domain/use_cases/add_category_use_case.dart';
import '../features/add_category/domain/use_cases/edit_category_use_case.dart' as addEdit;
import '../features/add_category/presentation/bloc/add_category_bloc.dart';
import '../features/add_products/data/data_sources/add_product_firestore_data_source.dart';
import '../features/add_products/data/repositories/add_product_repository_impl.dart';
import '../features/add_products/domain/repositories/add_product_repository.dart';
import '../features/add_products/domain/use_cases/add_product_use_case.dart';
import '../features/add_products/domain/use_cases/delete_product_use_case.dart' as add_delete;
import '../features/add_products/domain/use_cases/edit_product_use_case.dart' as add_edit;
import '../features/add_products/presentation/bloc/add_product_bloc.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/dashboard/data/data_sources/dashboard_firestore_data_source.dart';
import '../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../features/dashboard/domain/use_cases/get_dashboard_data_use_case.dart';
import '../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../features/manage_category/data/data_sources/manage_category_firestore_data_source.dart';
import '../features/manage_category/data/repositories/manage_category_repository_impl.dart';
import '../features/manage_category/domain/repositories/manage_category_repository.dart';
import '../features/manage_category/domain/use_cases/get_categories_use_case.dart';
import '../features/manage_category/domain/use_cases/delete_category_use_case.dart';
import '../features/manage_category/domain/use_cases/edit_category_use_case.dart' as manageEdit;
import '../features/manage_category/presentation/bloc/manage_category_bloc.dart';
import '../features/show_products/data/data_sources/show_product_firestore_data_source.dart';
import '../features/show_products/data/repositories/show_product_repository_impl.dart';
import '../features/show_products/domain/repositories/show_product_repository.dart';
import '../features/show_products/domain/use_cases/delete_product_use_case.dart' as show_delete;
import '../features/show_products/domain/use_cases/edit_product_use_case.dart' as show_edit;
import '../features/show_products/domain/use_cases/get_products_use_case.dart';
import '../features/show_products/presentation/bloc/show_product_bloc.dart';
import '../config/router/app_router.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External dependencies
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());

  // Auth Feature
  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<LoginUsecase>(
        () => LoginUsecase(getIt<AuthRepository>()),
  );
  getIt.registerFactory<AuthBloc>(
        () => AuthBloc(getIt<LoginUsecase>()),
  );

  // Dashboard Feature
  getIt.registerLazySingleton<DashboardFirestoreDataSource>(
        () => DashboardFirestoreDataSource(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<DashboardRepository>(
        () => DashboardRepositoryImpl(getIt<DashboardFirestoreDataSource>()),
  );
  getIt.registerLazySingleton<GetDashboardDataUseCase>(
        () => GetDashboardDataUseCase(getIt<DashboardRepository>()),
  );
  getIt.registerFactory<DashboardBloc>(
        () => DashboardBloc(getIt<GetDashboardDataUseCase>()),
  );

  // Add Product Feature
  getIt.registerLazySingleton<AddProductFirestoreDataSource>(
        () => AddProductFirestoreDataSource(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<AddProductRepository>(
        () => AddProductRepositoryImpl(getIt<AddProductFirestoreDataSource>()),
  );
  getIt.registerLazySingleton<AddProductUseCase>(
        () => AddProductUseCase(getIt<AddProductRepository>()),
  );
  getIt.registerLazySingleton<add_edit.EditProductUseCase>(
        () => add_edit.EditProductUseCase(getIt<AddProductRepository>()),
  );
  getIt.registerLazySingleton<add_delete.DeleteProductUseCase>(
        () => add_delete.DeleteProductUseCase(getIt<AddProductRepository>()),
  );
  getIt.registerLazySingleton<AddProductBloc>(
        () => AddProductBloc(
      getIt<AddProductUseCase>(),
      getIt<add_edit.EditProductUseCase>(),
      getIt<add_delete.DeleteProductUseCase>(),
    ),
  );

  // Add Category Feature
  getIt.registerLazySingleton<AddCategoryFirestoreDataSource>(
        () => AddCategoryFirestoreDataSource(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<AddCategoryRepository>(
        () => AddCategoryRepositoryImpl(getIt<AddCategoryFirestoreDataSource>()),
  );
  getIt.registerLazySingleton<AddCategoryUseCase>(
        () => AddCategoryUseCase(getIt<AddCategoryRepository>()),
  );
  getIt.registerLazySingleton<addEdit.EditCategoryUseCase>(
        () => addEdit.EditCategoryUseCase(getIt<AddCategoryRepository>()),
  );
  getIt.registerLazySingleton<AddCategoryBloc>(
        () => AddCategoryBloc(
      addCategoryUseCase: getIt<AddCategoryUseCase>(),
      editCategoryUseCase: getIt<addEdit.EditCategoryUseCase>(),
    ),
  );

  // Manage Category Feature
  getIt.registerLazySingleton<ManageCategoryFirestoreDataSource>(
        () => ManageCategoryFirestoreDataSource(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<ManageCategoryRepository>(
        () => ManageCategoryRepositoryImpl(getIt<ManageCategoryFirestoreDataSource>()),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
        () => GetCategoriesUseCase(getIt<ManageCategoryRepository>()),
  );
  getIt.registerLazySingleton<DeleteCategoryUseCase>(
        () => DeleteCategoryUseCase(getIt<ManageCategoryRepository>()),
  );
  getIt.registerLazySingleton<manageEdit.EditCategoryUseCase>(
        () => manageEdit.EditCategoryUseCase(getIt<ManageCategoryRepository>()),
  );
  getIt.registerLazySingleton<ManageCategoryBloc>(
        () => ManageCategoryBloc(
      getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
      deleteCategoryUseCase: getIt<DeleteCategoryUseCase>(),
      editCategoryUseCase: getIt<manageEdit.EditCategoryUseCase>(),
    ),
  );

  // Show Product Feature
  getIt.registerLazySingleton<ShowProductFirestoreDataSource>(
        () => ShowProductFirestoreDataSource(),
  );
  getIt.registerLazySingleton<ShowProductRepository>(
        () => ShowProductRepositoryImpl(getIt<ShowProductFirestoreDataSource>()),
  );
  getIt.registerLazySingleton<GetProductsUseCase>(
        () => GetProductsUseCase(getIt<ShowProductRepository>()),
  );
  getIt.registerLazySingleton<show_delete.DeleteProductUseCase>(
        () => show_delete.DeleteProductUseCase(getIt<ShowProductRepository>()),
  );
  getIt.registerLazySingleton<show_edit.EditProductUseCase>(
        () => show_edit.EditProductUseCase(getIt<ShowProductRepository>()),
  );
  getIt.registerLazySingleton<ShowProductBloc>( // Changed to registerLazySingleton
        () => ShowProductBloc(
      getIt<GetProductsUseCase>(),
      getIt<show_delete.DeleteProductUseCase>(),
      getIt<show_edit.EditProductUseCase>(),
    ),
  );

  // Router
  getIt.registerLazySingleton<GoRouter>(() => appRouter);

  // Wait for async dependencies to initialize
  await getIt.allReady();
}