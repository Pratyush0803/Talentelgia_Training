import 'package:dartz/dartz.dart';

abstract class AuthRepository{
Future<Either<String, void>>login(String email, String password);
}