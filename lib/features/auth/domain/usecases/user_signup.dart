import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/core/common/user/user.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements usecase<User, UserSignupParams> {
  final AuthRepository authRepository;

  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.SignupWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String email;
  final String name;
  final String password;

  UserSignupParams({required this.email,required this.name, required this.password});
}
