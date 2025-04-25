import 'package:dartz/dartz.dart';

import '../repository/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<String, void>> call(String email) {
    return repository.forgotPassword(email);
  }
}
