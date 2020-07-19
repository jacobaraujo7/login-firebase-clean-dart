import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user.dart';
import 'package:guard_class/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:guard_class/app/modules/login/infra/errors/errors.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';
import 'package:guard_class/app/modules/login/infra/repositories/login_repository_impl.dart';
import 'package:mockito/mockito.dart';

class FirebaseDataSourceMock extends Mock implements LoginDataSource {}

main() {
  final datasource = FirebaseDataSourceMock();
  final userReturn = UserModel(
      name: "Jacob", email: "jacob@gmail.com", phoneNumber: "1234567");
  final repository = LoginRepositoryImpl(datasource);

  group("loginEmail", () {
    test('should get FirebaseUser', () async {
      when(datasource.loginEmail()).thenAnswer((_) async => userReturn);
      var result = await repository.loginEmail();
      expect(result, isA<Right<dynamic, LoggedUser>>());
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
      expect(result, isA<Right<dynamic, LoggedUser>>());
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
    test('should get FirebaseUser', () async {
      when(datasource.validateCode(
              code: anyNamed('code'),
              verificationId: anyNamed('verificationId')))
          .thenAnswer((_) async => userReturn);
      var result = await repository.verifyPhoneCode();
      expect(result, isA<Right<dynamic, LoggedUser>>());
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
}
