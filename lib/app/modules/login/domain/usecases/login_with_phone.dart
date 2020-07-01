import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/core/usecase/usecase.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credencials.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';

class LoginWithPhone implements UseCase<FirebaseUser, LoginCredentials> {
  final LoginRepository repository;

  LoginWithPhone(this.repository);

  @override
  Future<Either<Failure, FirebaseUser>> call([LoginCredentials c]) async {
    if (!c.isValidPhone) {
      return Left(ErrorLoginPhone(message: "Invalid Phone number"));
    }
    return await repository.loginPhone(phone: c.phone);
  }
}
