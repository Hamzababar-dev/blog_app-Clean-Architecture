import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogOut implements usecase<void, NoParams>{
  final AuthRepository authRepository;

  UserLogOut(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async{
    return await authRepository.Logout();

  }

}