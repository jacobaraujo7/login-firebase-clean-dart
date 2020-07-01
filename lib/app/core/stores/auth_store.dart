import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final FirebaseAuth auth;
  _AuthStoreBase(this.auth);

  @observable
  FirebaseUser user;

  @computed
  bool get isLogged => user != null;

  @action
  void setUser(FirebaseUser value) => user = value;

  Future<bool> checkLogin() async {
    var u = await auth.currentUser();
    if (u == null) return false;
    setUser(u);
    return true;
  }

  Future logout() async {
    setUser(null);
    await auth.signOut();
  }
}
