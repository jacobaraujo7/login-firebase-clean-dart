import 'package:dartz/dartz.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user.dart';
import 'package:guard_class/app/modules/login/infra/errors/errors.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoggedUser>> loginEmail(
      {String email, String password});
  Future<Either<Failure, LoggedUser>> loginPhone({String phone});
  Future<Either<Failure, LoggedUser>> verifyPhoneCode(
      {String verificationId, String code});
}
