import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credential.dart';

main() {
  group("should check if field is valid or not", () {
    test('email and password', () {
      expect(
        LoginCredential.withEmailAndPassword(email: "", password: "")
            .isValidEmail,
        false,
      );
      expect(
        LoginCredential.withEmailAndPassword(email: "jacob", password: "")
            .isValidEmail,
        false,
      );
      expect(
        LoginCredential.withEmailAndPassword(
                email: "jacob@flutterrando.com.br", password: "")
            .isValidEmail,
        true,
      );
    });

    test('phone', () {
      expect(LoginCredential.withPhone(phoneNumber: "").isValidPhone, false);
      expect(
        LoginCredential.withPhone(phoneNumber: "1234567890").isValidPhone,
        false,
      );
      expect(
        LoginCredential.withPhone(phoneNumber: "12345678901234").isValidPhone,
        true,
      );
    });
    test('code and vefificationId', () {
      expect(
        LoginCredential.withVerificationCode(code: "", verificationId: "")
            .isValidCode,
        false,
      );
      expect(
        LoginCredential.withVerificationCode(code: "123456", verificationId: "")
            .isValidCode,
        true,
      );
      expect(
        LoginCredential.withVerificationCode(verificationId: "", code: "")
            .isValidVerificationId,
        false,
      );
      expect(
        LoginCredential.withVerificationCode(verificationId: "123456", code: "")
            .isValidVerificationId,
        true,
      );
    });
  });
}
