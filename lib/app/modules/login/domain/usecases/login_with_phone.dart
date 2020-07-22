import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credential.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/domain/services/connectivity_service.dart';
part 'login_with_phone.g.dart';

abstract class LoginWithPhone {
  Future<Either<Failure, LoggedUserInfo>> call(LoginCredential credencial);
}

@Injectable(singleton: false)
class LoginWithPhoneImpl implements LoginWithPhone {
  final LoginRepository repository;
  final ConnectivityService service;

  LoginWithPhoneImpl(this.repository, this.service);

  @override
  Future<Either<Failure, LoggedUserInfo>> call(
      LoginCredential credencial) async {
    if (!credencial.isValidPhone) {
      return Left(ErrorLoginPhone(message: "Invalid Phone number"));
    }
    var result = await service.isOnline();

    if (result.isLeft()) {
      return result.map((r) => null);
    }
    return await repository.loginPhone(phone: credencial.phone);
  }
}
