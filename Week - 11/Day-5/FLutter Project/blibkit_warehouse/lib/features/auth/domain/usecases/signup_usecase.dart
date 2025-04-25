import 'package:dartz/dartz.dart';
import '../repository/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<Either<String, void>> call(String email, String password) {
    return repository.signup(email, password);
  }
}
