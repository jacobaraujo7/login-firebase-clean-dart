import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/data/exceptions/errors.dart';
import 'package:guard_class/app/modules/login/data/models/login_credencials.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

main() {
  final repository = LoginRepositoryMock();
  final usecase = LoginWithEmail(repository);
  test('should verify if email is not valid', () async {
    var result = await usecase(LoginCredentials(email: "", password: ""));
    expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
  });
  test('should verify if password is not valid', () async {
    var result = await usecase(
        LoginCredentials(email: "flutterando@fluutterando.com", password: ""));
    expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
  });
  test('should consume repository loginEmail', () async {
    var user = User();
    when(repository.loginEmail(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => Right(user));
    var result = await usecase(
        LoginCredentials(email: "jacob@flutterando.com", password: "123456"));

    expect(result, Right(user));
  });
}
