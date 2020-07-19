import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:guard_class/app/modules/login/infra/errors/errors.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';

part 'firebase_datasource.g.dart';

@Injectable(singleton: false)
class FirebaseDataSourceImpl implements LoginDataSource {
  final FirebaseAuth auth;

  FirebaseDataSourceImpl(this.auth);

  @override
  Future<UserModel> loginEmail({String email, String password}) async {
    var result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    var user = result.user;
    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<UserModel> loginPhone({String phone}) async {
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
    var user = (await auth.signInWithCredential(credential)).user;
    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<UserModel> validateCode({String verificationId, String code}) async {
    var _credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    var user = (await auth.signInWithCredential(_credential)).user;
    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<UserModel> currentUser() async {
    var user = (await auth.currentUser());

    if (user == null) throw ErrorGetLoggedUser();

    return UserModel(
      name: user.displayName,
      phoneNumber: user.phoneNumber,
      email: user.email,
    );
  }

  @override
  Future<void> logout() async {
    return await auth.signOut();
  }
}
