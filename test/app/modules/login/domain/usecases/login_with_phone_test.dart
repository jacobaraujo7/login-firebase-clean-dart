import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credential.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/domain/services/connectivity_service.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_phone.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class ConnectivityServiceMock extends Mock implements ConnectivityService {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

main() {
  final repository = LoginRepositoryMock();
  final service = ConnectivityServiceMock();

  final usecase = LoginWithPhoneImpl(repository, service);
  final user = UserModel(name: "null");
  setUpAll(() {
    when(service.isOnline()).thenAnswer((_) async => Right(unit));
  });
  test('should verify if phone is valid', () async {
    var result = await usecase(LoginCredential.withPhone(phoneNumber: ""));
    expect(result.leftMap((l) => l is ErrorLoginPhone), Left(true));
  });
  test('should consume repository loginPhone but not automatic retrieve',
      () async {
    var error = ErrorLoginPhone();
    when(repository.loginPhone(phone: anyNamed('phone')))
        .thenAnswer((_) async => Left(error));
    var result =
        await usecase(LoginCredential.withPhone(phoneNumber: "12345678901234"));

    expect(result, Left(error));
  });
  test('should consume repository loginPhone', () async {
    when(repository.loginPhone(phone: anyNamed('phone')))
        .thenAnswer((_) async => Right(user));
    var result =
        await usecase(LoginCredential.withPhone(phoneNumber: "12345678901234"));

    expect(result, Right(user));
  });

  test('should return error when offline', () async {
    when(service.isOnline()).thenAnswer((_) async => Left(ConnectionError()));

    var result = await usecase(
      LoginCredential.withPhone(phoneNumber: "12345678901234"),
    );
    expect(result.leftMap((l) => l is ConnectionError), Left(true));
  });
}
