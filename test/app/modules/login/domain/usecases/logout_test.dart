import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/domain/errors/errors.dart';
import 'package:guard_class/app/modules/login/domain/repositories/login_repository.dart';
import 'package:guard_class/app/modules/login/domain/usecases/logout.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

main() {
  final repository = LoginRepositoryMock();
  final usecase = LogoutImpl(repository);
  test('should verify if exist User Logged', () async {
    when(repository.logout()).thenAnswer((_) async => Right(unit));
    var result = (await usecase()).fold((l) => null, (r) => r);
    expect(result, unit);
  });
  test('should return null if user not logged', () async {
    when(repository.logout()).thenAnswer((_) async => Left(ErrorLogout()));

    var result = (await usecase()).fold(id, id);
    expect(result, isA<ErrorLogout>());
  });
}
