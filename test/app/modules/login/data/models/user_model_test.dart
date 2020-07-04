import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guard_class/app/modules/login/data/models/user_model.dart';
import 'package:guard_class/app/modules/login/domain/entities/user.dart';
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
    User user = UserModel.fromFirebaseUser(firebaseUser);
    expect(user, isA<User>());
    expect(user.name, tName);
    expect(user.email, tEmail);
    expect(user.phoneNumber, tPhone);
  });
}
