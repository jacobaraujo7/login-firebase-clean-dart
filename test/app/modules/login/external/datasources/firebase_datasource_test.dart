import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/external/datasources/firebase_datasource.dart';
import 'package:mockito/mockito.dart';

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
  final firebaseUser = FirebaseUserMock();
  final user = const LoggedUser(
    name: "Jacob",
    phoneNumber: "123456",
    email: "jacob@flutterando.com",
  );

  final authResult = AuthResultMock();
  final datasource = FirebaseDataSourceImpl(auth);

  setUpAll(() {
    when(firebaseUser.displayName).thenReturn("Jacob");
    when(firebaseUser.email).thenReturn("jacob@flutterando.com");
    when(firebaseUser.phoneNumber).thenReturn("123456");
    when(authResult.user).thenReturn(firebaseUser);

    when(auth.signInWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => authResult);

    when(auth.signInWithCredential(any)).thenAnswer((_) async => authResult);
  });

  test('should return Logged User  loginEmail', () async {
    var result = await datasource.loginEmail();
    expect(result.name, equals(user.name));
    expect(result.phoneNumber, equals(user.phoneNumber));
    expect(result.email, equals(user.email));
  });
  test('should return Logged User  validateCode', () async {
    var result = await datasource.validateCode();
    expect(result.name, equals(user.name));
    expect(result.phoneNumber, equals(user.phoneNumber));
    expect(result.email, equals(user.email));
  });

  test('should return Logged User loginPhone', () async {
    var result = await datasource.loginPhone(phone: "0");
    expect(result.name, equals(user.name));
    expect(result.phoneNumber, equals(user.phoneNumber));
    expect(result.email, equals(user.email));
  });
  test('should return FirebaseUser loginPhone Error', () async {
    expect(() async => await datasource.loginPhone(phone: "1"),
        throwsA(authException));
  });
  test('should return NotAutomaticRetrieved loginPhone Not Automatic Retrieve',
      () async {
    expect(() async => await datasource.loginPhone(phone: "3"),
        throwsA(isA<NotAutomaticRetrieved>()));
  });
  test('should return Logged User', () async {
    when(auth.currentUser()).thenAnswer((_) async => firebaseUser);
    var result = await datasource.currentUser();
    expect(result.name, equals(user.name));
    expect(result.phoneNumber, equals(user.phoneNumber));
    expect(result.email, equals(user.email));
  });

  test('should return ErrorGetLoggedUser if User is not logged', () async {
    when(auth.currentUser()).thenAnswer((_) async => null);

    expect(datasource.currentUser(), throwsA(isA<ErrorGetLoggedUser>()));
  });

  test('should complete logout', () async {
    when(auth.signOut()).thenAnswer((_) async {});
    expect(datasource.logout(), completes);
  });

  test('should return error', () async {
    when(auth.signOut()).thenThrow(Exception());
    expect(datasource.logout(), throwsA(isA<Exception>()));
  });
}
