import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  AuthBloc(
      this.loginUseCase,
      this.signupUseCase,
      this.forgotPasswordUseCase) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final res = await loginUseCase(event.email, event.password);
      res.fold((l) => emit(AuthFailure(l)), (r) => emit(AuthSuccess()));
    });

    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      final res = await signupUseCase(event.email, event.password);
      res.fold((l) => emit(AuthFailure(l)), (r) => emit(AuthSuccess()));
    });

    on<ForgotPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      final res = await forgotPasswordUseCase(event.email);
      res.fold((l) => emit(AuthFailure(l)), (r) => emit(AuthSuccess()));
    });
  }
}
