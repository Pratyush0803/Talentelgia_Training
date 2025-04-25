import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<String, void>> login(String email, String password);
  Future<Either<String, void>> signup(String email, String password);
  Future<Either<String, void>> forgotPassword(String email);
}
