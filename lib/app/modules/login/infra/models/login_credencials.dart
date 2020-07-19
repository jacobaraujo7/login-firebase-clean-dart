import 'package:string_validator/string_validator.dart' as validator;

class LoginCredentials {
  final String email;
  final String password;
  final String phone;
  final String code;
  final String verificationId;

  LoginCredentials(
      {this.phone, this.verificationId, this.email, this.password, this.code});

  bool get isValidEmail => validator.isEmail(email ?? "");
  bool get isValidPassword =>
      password != null && password.isNotEmpty && password.length > 3;

  bool get isValidPhone =>
      phone != null && phone.isNotEmpty && phone.length > 13;
  bool get isValidCode => code != null && code.isNotEmpty;
  bool get isValidVerificationId =>
      verificationId != null && verificationId.isNotEmpty;

  LoginCredentials copyWith({
    String email,
    String password,
    String phone,
    String verificationId,
    String code,
  }) {
    return LoginCredentials(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      verificationId: verificationId ?? this.verificationId,
      code: code ?? this.code,
    );
  }
}
