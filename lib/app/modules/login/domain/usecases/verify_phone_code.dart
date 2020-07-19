import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credential.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/infra/errors/errors.dart';

part 'verify_phone_code.g.dart';

abstract class VerifyPhoneCode {
  Future<Either<Failure, User>> call(LoginCredential c);
}

@Injectable(singleton: false)
class VerifyPhoneCodeImpl implements VerifyPhoneCode {
  final LoginRepository repository;

  VerifyPhoneCodeImpl(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginCredential c) async {
    if (!c.isValidCode) {
      return Left(ErrorLoginPhone(message: "Invalid Code"));
    } else if (!c.isValidVerificationId) {
      return Left(InternalError(message: "Internal Error: VERIFICATION_ID"));
    }
    return await repository.verifyPhoneCode(
      verificationId: c.verificationId,
      code: c.code,
    );
  }
}
