import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth auth;

  AuthRepositoryImpl(this.auth);

  @override
  Future<Either<String, void>> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> forgotPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
