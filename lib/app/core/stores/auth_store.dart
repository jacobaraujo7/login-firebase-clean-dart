import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/modules/login/domain/entities/logged_user_info.dart';
import 'package:guard_class/app/modules/login/domain/usecases/get_logged_user.dart';
import 'package:guard_class/app/modules/login/domain/usecases/logout.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'auth_store.g.dart';

@Injectable()
class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final GetLoggedUser getLoggedUser;
  final Logout logout;
  _AuthStoreBase(this.getLoggedUser, this.logout);

  @observable
  LoggedUserInfo user;

  @computed
  bool get isLogged => user != null;

  @action
  void setUser(LoggedUserInfo value) => user = value;

  Future<bool> checkLogin() async {
    var result = await getLoggedUser();
    return result.fold((l) => null, (user) {
      setUser(user);
      return true;
    });
  }

  Future signOut() async {
    var result = await logout();
    result.fold((l) {
      asuka.showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      setUser(null);
    });
  }
}
