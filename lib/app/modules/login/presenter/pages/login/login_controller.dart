import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credential.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:guard_class/app/modules/login/presenter/utils/loading_dialog.dart';
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
  String email = "";

  @action
  setEmail(String value) => this.email = value;

  @observable
  String password = "";

  @action
  setPassword(String value) => this.password = value;

  @computed
  LoginCredential get credential =>
      LoginCredential.withEmailAndPassword(email: email, password: password);

  @computed
  bool get isValid => credential.isValidEmail && credential.isValidPassword;

  enterEmail() async {
    loading.show();
    await Future.delayed(Duration(seconds: 1));
    var result = await loginWithEmailUsecase(credential);
    await loading.hide();
    result.fold((failure) {
      asuka.showSnackBar(SnackBar(content: Text(failure.message)));
    }, (user) {
      authStore.setUser(user);
      Modular.to.popUntil(ModalRoute.withName(Modular.link.modulePath));
      Modular.to.pop();
    });
  }
}
