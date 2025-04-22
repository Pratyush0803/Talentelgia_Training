import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc(this.loginUsecase) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final res = await loginUsecase(event.email, event.password);
      res.fold(
            (failure) => emit(AuthFailure(failure)),
            (_) => emit(AuthSuccess()),
      );
    });
  }
}