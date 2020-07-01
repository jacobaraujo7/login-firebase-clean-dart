import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/modules/login/data/datasources/firebase_datasource.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';

class FirebaseLoginRepositoryImpl implements LoginRepository {
  final FirebaseDataSource firebase;

  FirebaseLoginRepositoryImpl(this.firebase);

  @override
  Future<Either<Failure, FirebaseUser>> loginEmail(
      {String email, String password}) async {
    try {
      var user = await firebase.loginEmail(email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginEmail(message: "Error login with Email"));
    }
  }

  @override
  Future<Either<Failure, FirebaseUser>> loginPhone({String phone}) async {
    try {
      var user = await firebase.loginPhone(phone: phone);
      return Right(user);
    } on NotAutomaticRetrieved catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorLoginPhone(message: "Error login with Phone"));
    }
  }

  @override
  Future<Either<Failure, FirebaseUser>> verifyPhoneCode(
      {String verificationId, String code}) async {
    try {
      var user = await firebase.validateCode(
          verificationId: verificationId, code: code);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginPhone(message: "Error login with Phone"));
    }
  }
}
