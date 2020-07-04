import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/data/models/login_credencials.dart';

main() {
  test('should make object copy', () {
    var credential = LoginCredentials();
    var credentialCopy = credential.copyWith();
    expect(credential != credentialCopy, true);
  });

  group("should check if field is valid or not", () {
    var credential = LoginCredentials();
    test('email', () {
      expect(credential.isValidEmail, false);
      expect(credential.copyWith(email: "").isValidEmail, false);
      expect(credential.copyWith(email: "jacob").isValidEmail, false);
      expect(
          credential.copyWith(email: "jacob@flutterrando.com.br").isValidEmail,
          true);
    });

    test('password', () {
      expect(credential.isValidPassword, false);
      expect(credential.copyWith(password: "").isValidPassword, false);
      expect(credential.copyWith(password: "123").isValidPassword, false);
      expect(credential.copyWith(password: "123456").isValidPassword, true);
    });
    test('phone', () {
      expect(credential.isValidPhone, false);
      expect(credential.copyWith(phone: "").isValidPhone, false);
      expect(credential.copyWith(phone: "1234567890").isValidPhone, false);
      expect(credential.copyWith(phone: "12345678901234").isValidPhone, true);
    });
    test('code', () {
      expect(credential.isValidCode, false);
      expect(credential.copyWith(code: "").isValidCode, false);
      expect(credential.copyWith(code: "123456").isValidCode, true);
    });
    test('verificationId', () {
      expect(credential.isValidVerificationId, false);
      expect(
          credential.copyWith(verificationId: "").isValidVerificationId, false);
      expect(
          credential.copyWith(verificationId: "123456").isValidVerificationId,
          true);
    });
  });
}
