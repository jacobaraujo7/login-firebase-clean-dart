import 'package:firebase_auth/firebase_auth.dart';
import 'package:guard_class/app/core/usecase/logged_user_info.dart';

class LoggedUserAdapter {
  static LoggedUserInfo execute(FirebaseUser firebaseUser) {
    return _FirebaseUserConverter.fromFirebaseUser(firebaseUser);
  }
}

class _FirebaseUserConverter implements LoggedUserInfo {
  final String email;
  final String name;
  final String phoneNumber;
  _FirebaseUserConverter._({this.name, this.email, this.phoneNumber});

  factory _FirebaseUserConverter.fromFirebaseUser(FirebaseUser firebaseUser) {
    return _FirebaseUserConverter._(
      name: firebaseUser.displayName,
      email: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }
}
