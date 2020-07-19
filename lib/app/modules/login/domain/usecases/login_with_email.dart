import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/core/usecase/usecase.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/infra/exceptions/errors.dart';
import 'package:guard_class/app/modules/login/infra/models/login_credencials.dart';

part 'login_with_email.g.dart';

@Injectable(singleton: false)
class LoginWithEmail implements UseCase<User, LoginCredentials> {
  final LoginRepository repository;

  LoginWithEmail(this.repository);

  @override
  Future<Either<Failure, User>> call([LoginCredentials c]) async {
    if (!c.isValidEmail) {
      return Left(ErrorLoginEmail(message: "Invalid Email"));
    } else if (!c.isValidPassword) {
      return Left(ErrorLoginEmail(message: "Invalid Password"));
    }

    return await repository.loginEmail(email: c.email, password: c.password);
  }
}
