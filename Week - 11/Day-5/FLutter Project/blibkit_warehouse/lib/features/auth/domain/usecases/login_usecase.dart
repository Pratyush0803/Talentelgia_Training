import 'package:dartz/dartz.dart';

import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, void>> call(String email, String password) {
    return repository.login(email, password);
  }
}
