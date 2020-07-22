import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/domain/services/connectivity_service.dart';
import 'package:guard_class/app/modules/login/infra/drivers/connectivity_driver.dart';
import '../../domain/errors/errors.dart';

part 'connectivity_service_impl.g.dart';

@Injectable(singleton: false)
class ConnectivityServiceImpl implements ConnectivityService {
  final ConnectivityDriver driver;

  ConnectivityServiceImpl(this.driver);

  @override
  Future<Either<Failure, Unit>> isOnline() async {
    try {
      var check = await driver.isOnline;
      if (check) {
        return Right(unit);
      }
      throw ConnectionError(message: "Você está offline");
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ConnectionError(
        message: "Erro ao recuperar informação de conexão",
      ));
    }
  }
}
