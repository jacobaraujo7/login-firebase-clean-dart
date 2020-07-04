import 'package:dartz/dartz.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> loginEmail({String email, String password});
  Future<Either<Failure, User>> loginPhone({String phone});
  Future<Either<Failure, User>> verifyPhoneCode(
      {String verificationId, String code});
}
