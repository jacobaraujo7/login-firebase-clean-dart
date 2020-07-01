import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credencials.dart';
import 'package:guard_class/app/modules/login/domain/usecases/verify_phone_code.dart';
import 'package:guard_class/app/modules/login/presenter/utils/loading_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'verify_code_controller.g.dart';

class VerifyCodeController = _VerifyCodeControllerBase
    with _$VerifyCodeController;

abstract class _VerifyCodeControllerBase with Store {
  final VerifyPhoneCode verifyPhoneCode;
  final LoadingDialog loading;
  final AuthStore authStore;
  _VerifyCodeControllerBase(this.verifyPhoneCode, this.loading, this.authStore,
      {String verificationId}) {
    credentials = credentials.copyWith(verificationId: verificationId);
  }

  @observable
  LoginCredentials credentials = LoginCredentials();

  @computed
  bool get isValid => credentials.isValidCode;

  @action
  setLoginCredentials(LoginCredentials value) => credentials = value;

  enterCode() async {
    loading.show();
    await Future.delayed(Duration(seconds: 1));
    var result = await verifyPhoneCode(credentials);
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
