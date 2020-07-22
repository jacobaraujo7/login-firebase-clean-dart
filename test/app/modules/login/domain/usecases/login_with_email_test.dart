import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credential.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/domain/services/connectivity_service.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class ConnectivityServiceMock extends Mock implements ConnectivityService {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

main() {
  final repository = LoginRepositoryMock();
  final service = ConnectivityServiceMock();
  final usecase = LoginWithEmailImpl(repository, service);

  setUpAll(() {
    when(service.isOnline()).thenAnswer((_) async => Right(unit));
  });
  test('should verify if email is not valid', () async {
    var result = await usecase(
        LoginCredential.withEmailAndPassword(email: "", password: ""));
    expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
  });
  test('should verify if password is not valid', () async {
    var result = await usecase(LoginCredential.withEmailAndPassword(
        email: "flutterando@fluutterando.com", password: ""));
    expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
  });
  test('should consume repository loginEmail', () async {
    var user = UserModel(name: "null");
    when(repository.loginEmail(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => Right(user));
    var result = await usecase(LoginCredential.withEmailAndPassword(
        email: "jacob@flutterando.com", password: "123456"));

    expect(result, Right(user));
  });

  test('should return error when offline', () async {
    when(service.isOnline()).thenAnswer((_) async => Left(ConnectionError()));

    var result = await usecase(LoginCredential.withEmailAndPassword(
        email: "jacob@flutterando.com", password: "123456"));
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
