import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
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

  @override
  Future<Either<Failure, LoggedUserInfo>> loggedUser() async {
    try {
      var user = await dataSource.currentUser();
      return Right(user);
    } catch (e) {
      return Left(ErrorGetLoggedUser(
          message: "Error ao tentar recuperar usuario atual logado"));
    }
  }

  @override
  Future<Either<Failure, int>> logout() async {
    try {
      await dataSource.logout();
      return Right(0);
    } catch (e) {
      return Left(ErrorLogout(message: "Error ao tentar fazer logout"));
    }
  }
}
