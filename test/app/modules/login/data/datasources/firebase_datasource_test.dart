import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/modules/login/data/datasources/firebase_datasource.dart';
import 'package:mockito/mockito.dart';

class FirebaseDataSourceMock extends Mock implements FirebaseDataSource {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

class AuthResultMock extends Mock implements AuthResult {}

class AuthCredentialMock extends Mock implements AuthCredential {}

class AuthExceptionMock extends Mock implements AuthException {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {
  @override
  Future<void> verifyPhoneNumber(
      {String phoneNumber,
      Duration timeout,
      int forceResendingToken,
      verificationCompleted,
      verificationFailed,
      codeSent,
      codeAutoRetrievalTimeout}) async {
    Future.delayed(Duration(milliseconds: 800)).then((value) {
      if (phoneNumber == "0") {
        verificationCompleted(credential);
      } else if (phoneNumber == "1") {
        verificationFailed(authException);
      } else if (phoneNumber == "2") {
        codeSent("dwf32f", 1);
      } else if (phoneNumber == "3") {
        codeAutoRetrievalTimeout("dwf32f");
        codeSent("dwf32f", 1);
      }
    });
    return;
  }
}

final credential = AuthCredentialMock();
final authException = AuthExceptionMock();
main() {
  final auth = FirebaseAuthMock();
  final user = FirebaseUserMock();

  final authResult = AuthResultMock();
  final datasource = FirebaseDataSourceImpl(auth);

  setUpAll(() {
    when(authResult.user).thenReturn(user);

    when(auth.signInWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => authResult);

    when(auth.signInWithCredential(any)).thenAnswer((_) async => authResult);
  });

  test('should return FirebaseUser loginEmail', () async {
    var result = await datasource.loginEmail();
    expect(result, user);
  });
  test('should return FirebaseUser validateCode', () async {
    var result = await datasource.validateCode();
    expect(result, user);
  });

  test('should return FirebaseUser loginPhone', () async {
    var result = await datasource.loginPhone(phone: "0");
    expect(result, user);
  });
  test('should return FirebaseUser loginPhone Error', () async {
    expect(() async => await datasource.loginPhone(phone: "1"),
        throwsA(authException));
  });
  test('should return FirebaseUser loginPhone Not Automatic Retrieve',
      () async {
    expect(() async => await datasource.loginPhone(phone: "3"),
        throwsA(isA<NotAutomaticRetrieved>()));
  });
}
