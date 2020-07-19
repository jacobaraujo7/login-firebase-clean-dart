import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as validator;

class LoginCredential {
  final String email;
  final String password;
  final String phone;
  final String code;
  final String verificationId;

  LoginCredential._(
      {this.phone, this.verificationId, this.email, this.password, this.code});

  bool get isValidEmail => validator.isEmail(email ?? "");
  bool get isValidPassword =>
      password != null && password.isNotEmpty && password.length > 3;

  bool get isValidPhone =>
      phone != null && phone.isNotEmpty && phone.length > 13;
  bool get isValidCode => code != null && code.isNotEmpty;
  bool get isValidVerificationId =>
      verificationId != null && verificationId.isNotEmpty;

  factory LoginCredential.withEmailAndPassword(
      {@required String email, @required String password}) {
    return LoginCredential._(
      email: email,
      password: password,
    );
  }

  factory LoginCredential.withPhone({@required String phoneNumber}) {
    return LoginCredential._(
      phone: phoneNumber,
    );
  }

  factory LoginCredential.withVerificationCode(
      {@required String code, @required String verificationId}) {
    return LoginCredential._(
      code: code,
      verificationId: verificationId,
    );
  }
}
