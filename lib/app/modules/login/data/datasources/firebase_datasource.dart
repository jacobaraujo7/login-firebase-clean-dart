import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/data/exceptions/errors.dart';

part 'firebase_datasource.g.dart';

abstract class FirebaseDataSource {
  Future<FirebaseUser> loginPhone({String phone});
  Future<FirebaseUser> loginEmail({String email, String password});
  Future<FirebaseUser> validateCode({String verificationId, String code});
}

@Injectable(singleton: false)
class FirebaseDataSourceImpl implements FirebaseDataSource {
  final FirebaseAuth auth;

  FirebaseDataSourceImpl(this.auth);

  @override
  Future<FirebaseUser> loginEmail({String email, String password}) async {
    var result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  @override
  Future<FirebaseUser> loginPhone({String phone}) async {
    var completer = Completer<AuthCredential>();
    await auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 30),
        verificationCompleted: (auth) {
          completer.complete(auth);
        },
        verificationFailed: (e) {
          completer.completeError(e);
        },
        codeSent: (String c, [int i]) {
          completer.completeError(NotAutomaticRetrieved(c));
        },
        codeAutoRetrievalTimeout: (v) {});

    var credential = await completer.future;
    return (await auth.signInWithCredential(credential)).user;
  }

  @override
  Future<FirebaseUser> validateCode(
      {String verificationId, String code}) async {
    var _credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    return (await auth.signInWithCredential(_credential)).user;
  }
}
