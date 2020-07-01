import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credencials.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/core/usecase/usecase.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';

class VerifyPhoneCode implements UseCase<FirebaseUser, LoginCredentials> {
  final LoginRepository repository;

  VerifyPhoneCode(this.repository);

  @override
  Future<Either<Failure, FirebaseUser>> call([LoginCredentials c]) async {
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
