import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/core/usecase/usecase.dart';
import 'package:guard_class/app/modules/login/data/exceptions/errors.dart';
import 'package:guard_class/app/modules/login/data/models/login_credencials.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
part 'login_with_phone.g.dart';

@Injectable(singleton: false)
class LoginWithPhone implements UseCase<User, LoginCredentials> {
  final LoginRepository repository;

  LoginWithPhone(this.repository);

  @override
  Future<Either<Failure, User>> call([LoginCredentials c]) async {
    if (!c.isValidPhone) {
      return Left(ErrorLoginPhone(message: "Invalid Phone number"));
    }
    return await repository.loginPhone(phone: c.phone);
  }
}
