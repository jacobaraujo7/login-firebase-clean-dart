import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/core/adapters/logged_user_adapter.dart';
import 'package:guard_class/app/modules/login/infra/models/logged_user_info.dart';
import 'package:mockito/mockito.dart';

class FirebaseUserMock extends Mock implements FirebaseUser {}

main() {
  final firebaseUser = FirebaseUserMock();
  final tName = "Jacob";
  final tEmail = "jacob@gmail.com";
  final tPhone = "32145576473";

  setUpAll(() {
    when(firebaseUser.displayName).thenReturn(tName);
    when(firebaseUser.email).thenReturn(tEmail);
    when(firebaseUser.phoneNumber).thenReturn(tPhone);
  });

  test('should return Use from fromFirebaseUser', () {
    LoggedUserInfo user = LoggedUserAdapter.execute(firebaseUser);
    expect(user, isA<LoggedUserInfo>());
    expect(user.name, tName);
    expect(user.email, tEmail);
    expect(user.phoneNumber, tPhone);
  });
}
