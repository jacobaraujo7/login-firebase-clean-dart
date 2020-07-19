import 'package:meta/meta.dart';

import 'package:guard_class/app/modules/login/infra/models/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';

class UserModel extends User implements LoggedUserInfo {
  UserModel({@required String name, String email, String phoneNumber})
      : super(name: name, email: email, phoneNumber: phoneNumber);
}
