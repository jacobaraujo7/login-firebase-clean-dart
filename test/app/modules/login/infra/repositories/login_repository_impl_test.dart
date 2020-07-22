import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';
import 'package:guard_class/app/modules/login/infra/repositories/login_repository_impl.dart';
import 'package:mockito/mockito.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

main() {
  final datasource = LoginDataSourceMock();
  final userReturn = UserModel(
    name: "Jacob",
    email: "jacob@gmail.com",
    phoneNumber: "1234567",
  );
  final repository = LoginRepositoryImpl(datasource);

  group("loginEmail", () {
    test('should get UserModel', () async {
      when(datasource.loginEmail()).thenAnswer((_) async => userReturn);
      var result = await repository.loginEmail();
      expect(result, isA<Right<dynamic, LoggedUserInfo>>());
    });
    test('should call ErrorLoginEmail', () async {
      when(datasource.loginEmail()).thenThrow(ErrorLoginEmail());
      var result = await repository.loginEmail();
      expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
    });
  });
  group("loginPhone", () {
    test('should get LoggedUser', () async {
      when(datasource.loginPhone(phone: anyNamed('phone')))
          .thenAnswer((_) async => userReturn);
      var result = await repository.loginPhone();
      expect(result, isA<Right<dynamic, LoggedUserInfo>>());
    });
    test('should call ErrorLoginPhone', () async {
      when(datasource.loginPhone(phone: anyNamed('phone')))
          .thenThrow(ErrorLoginPhone());
      var result = await repository.loginPhone();
      expect(result.leftMap((l) => l is ErrorLoginPhone), Left(true));
    });
    test('should call NotAutomaticRetrieved', () async {
      when(datasource.loginPhone(phone: anyNamed('phone')))
          .thenThrow(NotAutomaticRetrieved("1232"));
      var result = await repository.loginPhone();
      expect(result.leftMap((l) => l is NotAutomaticRetrieved), Left(true));
    });
  });
  group("verifyPhoneCode", () {
    test('should get UserModel', () async {
      when(datasource.validateCode(
              code: anyNamed('code'),
              verificationId: anyNamed('verificationId')))
          .thenAnswer((_) async => userReturn);
      var result = await repository.verifyPhoneCode();
      expect(result, isA<Right<dynamic, LoggedUserInfo>>());
    });
    test('should call ErrorLoginPhone', () async {
      when(datasource.validateCode(
              code: anyNamed('code'),
              verificationId: anyNamed('verificationId')))
          .thenThrow(ErrorLoginPhone());
      var result = await repository.verifyPhoneCode();
      expect(result.leftMap((l) => l is ErrorLoginPhone), Left(true));
    });
  });

  group("loggedUser", () {
    test('should get Current User Logged', () async {
      when(datasource.currentUser()).thenAnswer((_) async => userReturn);
      var result = await repository.loggedUser();
      expect(result, isA<Right<dynamic, LoggedUserInfo>>());
    });
    test('should Throw when user not logged', () async {
      when(datasource.currentUser()).thenThrow(ErrorGetLoggedUser());
      var result = await repository.loggedUser();
      expect(result.leftMap((l) => l is ErrorGetLoggedUser), Left(true));
    });
  });
  group("logout", () {
    test('should get logout', () async {
      when(datasource.logout()).thenAnswer((_) async {});
      var result = await repository.logout();
      expect(result, isA<Right<dynamic, Unit>>());
    });
    test('should Throw when user try logout', () async {
      when(datasource.logout()).thenThrow(ErrorGetLoggedUser());
      var result = await repository.logout();
      expect(result.leftMap((l) => l is ErrorLogout), Left(true));
    });
  });
}
