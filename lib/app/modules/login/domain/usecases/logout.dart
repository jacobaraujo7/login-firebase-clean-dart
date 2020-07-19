import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/infra/errors/errors.dart';

part 'logout.g.dart';

abstract class Logout {
  Future<Either<Failure, int>> call();
}

@Injectable(singleton: false)
class LogoutImpl implements Logout {
  final LoginRepository repository;

  LogoutImpl(this.repository);

  @override
  Future<Either<Failure, int>> call() async {
    return await repository.logout();
  }
}
