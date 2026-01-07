import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/common/user/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> SignupWithEmailPassword({
    required String name,
    required String email,
    required String password,
});
  Future<Either<Failure, User>> LoginWithEmailPassword({
    required String email,
    required String password,
});

  Future<Either<Failure, User>> CurrentUser();

  Future<Either<Failure, void>> Logout();

}