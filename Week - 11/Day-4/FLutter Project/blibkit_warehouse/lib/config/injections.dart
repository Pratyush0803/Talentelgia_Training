import 'package:blibkit_warehouse/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blibkit_warehouse/features/auth/domain/repository/auth_repository.dart';
import 'package:blibkit_warehouse/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:blibkit_warehouse/features/auth/domain/usecases/login_usecase.dart';
import 'package:blibkit_warehouse/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blibkit_warehouse/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blibkit_warehouse/features/home/domain/use_cases/get_location_usecase.dart';
import 'package:blibkit_warehouse/features/home/presentation/bloc/home_bloc.dart';
import 'package:blibkit_warehouse/features/inventory/data/data_sources/inventory_data_source.dart';
import 'package:blibkit_warehouse/features/inventory/data/repository/inventory_repository_impl.dart';
import 'package:blibkit_warehouse/features/inventory/domain/repository/inventory_repository.dart';
import 'package:blibkit_warehouse/features/inventory/domain/use_cases/get_inventory_usecase.dart';
import 'package:blibkit_warehouse/features/inventory/domain/use_cases/update_inventory_usecase.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:blibkit_warehouse/features/settings/data/data_source/settings_data_source.dart';
import 'package:blibkit_warehouse/features/settings/data/repository/settings_repository_impl.dart';
import 'package:blibkit_warehouse/features/settings/domain/repository/settings_repository.dart';
import 'package:blibkit_warehouse/features/settings/domain/usecases/get_user_settings_usecase.dart';
import 'package:blibkit_warehouse/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase Services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Auth Repository and Use Cases
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));

  // Home Use Case
  sl.registerLazySingleton(() => GetLocationUsecase());

  // Inventory Data Source and Repository
  sl.registerLazySingleton<InventoryDataSource>(() => InventoryDataSource());
  sl.registerLazySingleton<InventoryRepository>(
          () => InventoryRepositoryImpl(sl()));

  // Inventory Use Cases
  sl.registerLazySingleton(() => GetInventoryUsecase(sl()));
  sl.registerLazySingleton(() => UpdateInventoryUsecase(sl()));

  // Settings Data Source and Repository
  sl.registerLazySingleton<SettingsDataSource>(() => SettingsDataSource(sl()));
  sl.registerLazySingleton<SettingsRepository>(
          () => SettingsRepositoryImpl(sl()));

  // Settings Use Case
  sl.registerLazySingleton(() => GetUserSettings(sl()));

  // BLoCs
  sl.registerFactory(() => AuthBloc(
    sl<LoginUseCase>(),
    sl<SignupUseCase>(),
    sl<ForgotPasswordUseCase>(),
  ));

  sl.registerFactory(() => HomeBloc(getLocation: sl<GetLocationUsecase>()));

  sl.registerFactory(() => InventoryBloc(
    sl<GetInventoryUsecase>(),
    sl<UpdateInventoryUsecase>(),
  ));

  sl.registerFactory(() => SettingsBloc(sl<GetUserSettings>()));
}