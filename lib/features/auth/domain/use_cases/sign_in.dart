import 'package:flutter_bloc_template/core/use_case/use_case.dart';
import 'package:flutter_bloc_template/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class SignInAnonymously implements UseCase<AuthAppUser, AuthParams> {
  final AuthRepository repository;

  SignInAnonymously(this.repository);

  @override
  Future<Either<Failure, AuthAppUser>> call(AuthParams params) {
    return repository.signIn(email: params.email, password: params.password);
  }
}

class AuthParams {
  final String email;
  final String password;

  AuthParams(this.email, this.password);
}
