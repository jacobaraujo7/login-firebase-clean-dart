import 'package:dartz/dartz.dart';
import 'package:guard_class/app/core/errors/failure.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call([P params]);
}
