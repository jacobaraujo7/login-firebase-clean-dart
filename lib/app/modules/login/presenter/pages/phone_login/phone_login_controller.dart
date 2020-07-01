import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/errors/failure.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credencials.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_phone.dart';
import 'package:guard_class/app/modules/login/presenter/utils/loading_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'phone_login_controller.g.dart';

class PhoneLoginController = _PhoneLoginControllerBase
    with _$PhoneLoginController;

abstract class _PhoneLoginControllerBase with Store {
  final LoginWithPhone loginWithPhoneUsecase;
  final LoadingDialog loading;
  final AuthStore authStore;
  _PhoneLoginControllerBase(
      this.loginWithPhoneUsecase, this.loading, this.authStore);

  @observable
  LoginCredentials credentials = LoginCredentials();

  @computed
  bool get isValid => credentials.isValidPhone;

  @action
  setLoginCredentials(LoginCredentials value) => credentials = value;

  enterPhone() async {
    loading.show();
    var result = await loginWithPhoneUsecase(credentials);
    await loading.hide();
    result.fold((failure) {
      if (failure is NotAutomaticRetrieved) {
        Modular.link.pushNamed(
          "/verify/${failure.verificationId}",
        );
      } else {
        asuka.showSnackBar(SnackBar(content: Text(failure.message)));
      }
    }, (user) {
      authStore.setUser(user);
      Modular.to.popUntil(ModalRoute.withName(Modular.link.modulePath));
      Modular.to.pop();
    });
  }
}
