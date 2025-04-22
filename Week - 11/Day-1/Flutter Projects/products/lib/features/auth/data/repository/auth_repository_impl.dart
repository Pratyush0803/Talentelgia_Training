import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:products/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;

  AuthRepositoryImpl(this._auth);

  @override
  Future<Either<String, void>> login(String email, String password) async {
    try {
      // Set persistence to LOCAL for web and mobile
      await _auth.setPersistence(Persistence.LOCAL);
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('AuthRepository: Login successful, userId=${_auth.currentUser?.uid}');
      return right(null);
    } catch (e) {
      print('AuthRepository: Login failed: $e');
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await _auth.signOut();
      print('AuthRepository: Sign out successful');
      return right(null);
    } catch (e) {
      print('AuthRepository: Sign out failed: $e');
      return left(e.toString());
    }
  }
}