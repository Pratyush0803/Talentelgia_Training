import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/injection.dart' as di;
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc(this.loginUsecase) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      print('LoginRequested: email=${event.email}');
      emit(AuthLoading());
      try {
        final res = await loginUsecase(event.email, event.password);
        await res.fold(
              (failure) async {
            print('Login failed: $failure');
            emit(AuthFailure(failure));
          },
              (success) async {
            final userId = di.getIt<FirebaseAuth>().currentUser?.uid;
            if (userId != null) {
              await di.getIt<SharedPreferences>().setString('userId', userId);
              print('Saved userId to SharedPreferences: $userId');
            } else {
              print('No user ID found after login');
              emit(AuthFailure('Failed to retrieve user ID'));
              return;
            }
            emit(AuthSuccess());
          },
        );
      } catch (e) {
        print('Login error: $e');
        emit(AuthFailure('Login failed: $e'));
      }
    });

    on<LogoutRequested>((event, emit) async {
      print('LogoutRequested triggered');
      emit(AuthLoading());
      try {
        final res = await di.getIt<AuthRepository>().signOut();
        await res.fold(
              (failure) async {
            print('Logout failed: $failure');
            emit(AuthFailure(failure));
          },
              (success) async {
            await di.getIt<SharedPreferences>().remove('userId');
            print('Cleared userId from SharedPreferences');
            emit(AuthInitial());
          },
        );
      } catch (e) {
        print('Logout error: $e');
        emit(AuthFailure('Logout failed: $e'));
      }
    });

    on<CheckLoginStatus>((event, emit) async {
      print('CheckLoginStatus triggered');
      try {
        final userId = di.getIt<SharedPreferences>().getString('userId');
        print('CheckLoginStatus: userId from SharedPreferences=$userId');
        final firebaseUser = di.getIt<FirebaseAuth>().currentUser;
        print('CheckLoginStatus: firebaseUser=${firebaseUser?.uid}');
        if (userId != null && firebaseUser != null && firebaseUser.uid == userId) {
          print('CheckLoginStatus: User is logged in: $userId');
          emit(AuthSuccess());
        } else {
          print('CheckLoginStatus: No logged-in user found (userId=$userId, firebaseUser=${firebaseUser?.uid})');
          await di.getIt<SharedPreferences>().remove('userId');
          emit(AuthInitial());
        }
      } catch (e) {
        print('CheckLoginStatus error: $e');
        await di.getIt<SharedPreferences>().remove('userId');
        emit(AuthInitial());
      }
    });
  }
}