import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/infra/drivers/connectivity_driver.dart';
import 'package:guard_class/app/modules/login/infra/services/connectivity_service_impl.dart';
import 'package:mockito/mockito.dart';

class ConnectivityDriverMock extends Mock implements ConnectivityDriver {}

main() {
  final driver = ConnectivityDriverMock();
  final service = ConnectivityServiceImpl(driver);

  group("ConnectivityServiceImpl", () {
    test('should return bool', () async {
      when(driver.isOnline).thenAnswer((_) async => true);
      var result = await service.isOnline();
      expect(result, isA<Right<dynamic, bool>>());
    });
    test('should call ErrorLoginEmail', () async {
      when(service.isOnline()).thenThrow(ConnectionError());
      var result = await service.isOnline();
      expect(result.leftMap((l) => l is ConnectionError), Left(true));
    });
  });
}
