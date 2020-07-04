import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/data/datasources/firebase_datasource.dart';
import 'package:guard_class/app/modules/login/data/exceptions/errors.dart';
import 'package:guard_class/app/modules/login/data/repositories/firebase_login_repository_impl.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';
import 'package:mockito/mockito.dart';

class FirebaseDataSourceMock extends Mock implements FirebaseDataSource {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

main() {
  final datasource = FirebaseDataSourceMock();
  var firebaseUser = FirebaseUserMock();
  final repository = FirebaseLoginRepositoryImpl(datasource);

  final tName = "Jacob";
  final tEmail = "jacob@gmail.com";
  final tPhone = "32145576473";

  setUpAll(() {
    when(firebaseUser.displayName).thenReturn(tName);
    when(firebaseUser.email).thenReturn(tEmail);
    when(firebaseUser.phoneNumber).thenReturn(tPhone);
  });

  group("loginEmail", () {
    test('should get FirebaseUser', () async {
      when(datasource.loginEmail()).thenAnswer((_) async => firebaseUser);
      var result = await repository.loginEmail();
      expect(result, isA<Right<dynamic, User>>());
    });
    test('should call ErrorLoginEmail', () async {
      when(datasource.loginEmail()).thenThrow(ErrorLoginEmail());
      var result = await repository.loginEmail();
      expect(result.leftMap((l) => l is ErrorLoginEmail), Left(true));
    });
  });
  group("loginPhone", () {
    test('should get FirebaseUser', () async {
      when(datasource.loginPhone(phone: anyNamed('phone')))
          .thenAnswer((_) async => firebaseUser);
      var result = await repository.loginPhone();
      expect(result, isA<Right<dynamic, User>>());
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
          .thenAnswer((_) async => firebaseUser);
      var result = await repository.verifyPhoneCode();
      expect(result, isA<Right<dynamic, User>>());
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
