import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/core/usecase/usecase.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credencials.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';

class LoginWithEmail implements UseCase<FirebaseUser, LoginCredentials> {
  final LoginRepository repository;

  LoginWithEmail(this.repository);

  @override
  Future<Either<Failure, FirebaseUser>> call([LoginCredentials c]) async {
    if (!c.isValidEmail) {
      return Left(ErrorLoginEmail(message: "Invalid Email"));
    } else if (!c.isValidPassword) {
      return Left(ErrorLoginEmail(message: "Invalid Password"));
    }

    return await repository.loginEmail(email: c.email, password: c.password);
  }
}
