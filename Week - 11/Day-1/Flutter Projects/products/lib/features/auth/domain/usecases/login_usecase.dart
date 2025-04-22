import 'package:dartz/dartz.dart';
import 'package:products/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<String, void>> call(String email, String password) {
    return repository.login(email, password);
  }
}
