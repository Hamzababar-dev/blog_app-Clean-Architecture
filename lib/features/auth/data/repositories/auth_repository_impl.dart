import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/core/common/user/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl(this.authDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> CurrentUser() async {
    try{
      if(!await(connectionChecker.isConnected)){
        final session = authDataSource.currentUserSession;
        if(session == null){
          return left(Failure('User not logged in!'));
        }
        return right(UserModel(id: session.user.id, email: session.user.email ?? '', name: '',));
      }
     final user = await authDataSource.getCurrentUserData();
     if(user == null){
       return left(Failure('User not logged in!'));
     }
     return right(user);
    }on ServerExceptions catch (e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> LoginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getuser(
      () async => await authDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> SignupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getuser(
      () async => await authDataSource.signupWithEmailPassword(
        email: email,
        name: name,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getuser(
      Future<User> Function() fn) async {
    try {
      if(!await (connectionChecker.isConnected)){
        return left(Failure('No Internet Access'));
      }
      final user = await fn();
      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> Logout() async{
    try{
      await authDataSource.Logout();
      return right(unit);
    }on ServerExceptions catch(e){
      return left(Failure(e.message));
    }
  }


}
