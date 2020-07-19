import 'dart:async';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> loginPhone({String phone});
  Future<UserModel> loginEmail({String email, String password});
  Future<UserModel> validateCode({String verificationId, String code});
}
