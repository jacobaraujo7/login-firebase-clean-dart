import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guard_class/app/core/errors/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, FirebaseUser>> loginEmail(
      {String email, String password});
  Future<Either<Failure, FirebaseUser>> loginPhone({String phone});
  Future<Either<Failure, FirebaseUser>> verifyPhoneCode(
      {String verificationId, String code});
}
