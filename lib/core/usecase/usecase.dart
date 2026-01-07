import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class usecase<SuccessType, Params>{
  Future<Either<Failure, SuccessType >> call(Params params);
}

class NoParams{

}