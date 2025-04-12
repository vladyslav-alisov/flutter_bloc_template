import 'package:flutter_bloc_template/core/error/failure.dart';
import 'package:flutter_bloc_template/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

enum AuthAppState {
  signedIn,
  signedOut,
}

abstract interface class AuthRepository {
  Future<Either<Failure, AuthAppUser>> signIn({required String email, required String password});
  Future<Either<Failure, AuthAppUser>> signUp({required String email, required String password});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AuthAppUser>> signInAnonymously();
  Future<Either<Failure, AuthAppUser?>> getCurrentUser();
}
