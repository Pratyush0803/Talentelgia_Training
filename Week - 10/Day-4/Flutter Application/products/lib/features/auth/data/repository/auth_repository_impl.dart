import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:products/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final FirebaseAuth _auth;

  AuthRepositoryImpl(this._auth);

  @override
  Future<Either<String, void>> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
