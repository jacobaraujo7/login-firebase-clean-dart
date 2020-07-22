import 'package:meta/meta.dart';

import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user.dart';

class UserModel extends LoggedUser implements LoggedUserInfo {
  UserModel({@required String name, String email, String phoneNumber})
      : super(name: name, email: email, phoneNumber: phoneNumber);

  LoggedUser toLoggedUser() => this;
}
