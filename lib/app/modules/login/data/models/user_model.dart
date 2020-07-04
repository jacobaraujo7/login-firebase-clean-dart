import 'package:firebase_auth/firebase_auth.dart';
import 'package:guard_class/app/core/usecase/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';

class UserModel extends User implements LoggedUserInfo {
  UserModel._({String name, String email, String phoneNumber})
      : super(name: name, email: email, phoneNumber: phoneNumber);
  factory UserModel.fromFirebaseUser(FirebaseUser firebaseUser) {
    return UserModel._(
      name: firebaseUser.displayName,
      email: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }
}
