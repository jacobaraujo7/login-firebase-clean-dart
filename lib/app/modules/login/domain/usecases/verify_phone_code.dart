import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/data/exceptions/errors.dart';
import 'package:guard_class/app/modules/login/data/models/login_credencials.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/core/usecase/usecase.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';

part 'verify_phone_code.g.dart';

@Injectable(singleton: false)
class VerifyPhoneCode implements UseCase<User, LoginCredentials> {
  final LoginRepository repository;

  VerifyPhoneCode(this.repository);

  @override
  Future<Either<Failure, User>> call([LoginCredentials c]) async {
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
