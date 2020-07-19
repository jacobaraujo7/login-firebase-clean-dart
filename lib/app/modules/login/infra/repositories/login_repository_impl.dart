import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:guard_class/app/modules/login/infra/errors/errors.dart';

part 'login_repository_impl.g.dart';

@Injectable(singleton: false)
class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, LoggedUser>> loginEmail(
      {String email, String password}) async {
    try {
      var user = await dataSource.loginEmail(email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginEmail(message: "Error login with Email"));
    }
  }

  @override
  Future<Either<Failure, LoggedUser>> loginPhone({String phone}) async {
    try {
      var user = await dataSource.loginPhone(phone: phone);
      return Right(user);
    } on NotAutomaticRetrieved catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorLoginPhone(message: "Error login with Phone"));
    }
  }

  @override
  Future<Either<Failure, LoggedUser>> verifyPhoneCode(
      {String verificationId, String code}) async {
    try {
      var user = await dataSource.validateCode(
          verificationId: verificationId, code: code);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginPhone(message: "Error login with Phone"));
    }
  }
}
