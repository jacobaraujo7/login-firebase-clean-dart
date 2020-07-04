import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/modules/login/data/datasources/firebase_datasource.dart';
import 'package:guard_class/app/modules/login/data/exceptions/errors.dart';
import 'package:guard_class/app/modules/login/data/models/user_model.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';

part 'firebase_login_repository_impl.g.dart';

@Injectable(singleton: false)
class FirebaseLoginRepositoryImpl implements LoginRepository {
  final FirebaseDataSource firebase;

  FirebaseLoginRepositoryImpl(this.firebase);

  @override
  Future<Either<Failure, User>> loginEmail(
      {String email, String password}) async {
    try {
      var firebaseUser =
          await firebase.loginEmail(email: email, password: password);
      var user = UserModel.fromFirebaseUser(firebaseUser);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginEmail(message: "Error login with Email"));
    }
  }

  @override
  Future<Either<Failure, User>> loginPhone({String phone}) async {
    try {
      var firebaseUser = await firebase.loginPhone(phone: phone);
      var user = UserModel.fromFirebaseUser(firebaseUser);
      return Right(user);
    } on NotAutomaticRetrieved catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorLoginPhone(message: "Error login with Phone"));
    }
  }

  @override
  Future<Either<Failure, User>> verifyPhoneCode(
      {String verificationId, String code}) async {
    try {
      var firebaseUser = await firebase.validateCode(
          verificationId: verificationId, code: code);
      var user = UserModel.fromFirebaseUser(firebaseUser);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginPhone(message: "Error login with Phone"));
    }
  }
}
