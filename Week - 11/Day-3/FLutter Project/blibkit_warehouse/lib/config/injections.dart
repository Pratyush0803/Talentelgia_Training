import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/signup_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/home/domain/use_cases/get_location_usecase.dart';
import '../features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase Auth
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Auth Repository and UseCases
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));

  // Register GetLocationUsecase
  sl.registerLazySingleton(() => GetLocationUsecase());

  // Register HomeBloc
  sl.registerFactory(() => HomeBloc(getLocation: sl<GetLocationUsecase>()));

  // Register AuthBloc
  sl.registerFactory(() => AuthBloc(
    sl<LoginUseCase>(),
    sl<SignupUseCase>(),
    sl<ForgotPasswordUseCase>(),
  ));
}