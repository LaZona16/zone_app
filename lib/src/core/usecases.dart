import 'package:dartz/dartz.dart';
import 'package:zone_app/src/core/failures.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams {}
