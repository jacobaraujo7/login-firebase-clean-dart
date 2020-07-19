import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:guard_class/app/modules/login/infra/models/login_credencials.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';
import 'package:guard_class/app/modules/login/ui/utils/loading_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final LoginWithEmail loginWithEmailUsecase;
  final LoadingDialog loading;
  final AuthStore authStore;

  _LoginControllerBase(
      this.loginWithEmailUsecase, this.loading, this.authStore);

  @observable
  LoginCredentials credentials = LoginCredentials();

  @computed
  bool get isValid => credentials.isValidEmail && credentials.isValidPassword;

  @action
  setLoginCredentials(LoginCredentials value) => credentials = value;
  enterEmail() async {
    loading.show();
    await Future.delayed(Duration(seconds: 1));
    var result = await loginWithEmailUsecase(credentials);
    await loading.hide();
    result.fold((failure) {
      asuka.showSnackBar(SnackBar(content: Text(failure.message)));
    }, (user) {
      authStore.setUser(user as UserModel);
      Modular.to.popUntil(ModalRoute.withName(Modular.link.modulePath));
      Modular.to.pop();
    });
  }
}
