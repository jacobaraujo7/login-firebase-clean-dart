import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/adapters/logged_user_adapter.dart';
import 'package:guard_class/app/core/usecase/logged_user_info.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

@Injectable()
class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final FirebaseAuth auth;
  _AuthStoreBase(this.auth);

  @observable
  LoggedUserInfo user;

  @computed
  bool get isLogged => user != null;

  @action
  void setUser(LoggedUserInfo value) => user = value;

  Future<bool> checkLogin() async {
    var u = await auth.currentUser();
    if (u == null) return false;
    setUser(LoggedUserAdapter.execute(u));
    return true;
  }

  Future logout() async {
    setUser(null);
    await auth.signOut();
  }
}
