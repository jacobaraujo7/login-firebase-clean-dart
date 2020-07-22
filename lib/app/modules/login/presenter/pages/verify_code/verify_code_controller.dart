import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/stores/auth_store.dart';
import '../../../domain/entities/login_credential.dart';
import '../../../domain/usecases/verify_phone_code.dart';
import '../../utils/loading_dialog.dart';

part 'verify_code_controller.g.dart';

@Injectable()
class VerifyCodeController = _VerifyCodeControllerBase
    with _$VerifyCodeController;

abstract class _VerifyCodeControllerBase with Store {
  final VerifyPhoneCode verifyPhoneCode;
  final String verificationId;
  final LoadingDialog loading;
  final AuthStore authStore;
  _VerifyCodeControllerBase(this.verifyPhoneCode, this.loading, this.authStore,
      {@Param this.verificationId});

  @observable
  String code = "";

  @action
  setCode(String value) => code = value;

  @computed
  LoginCredential get credential => LoginCredential.withVerificationCode(
      code: code, verificationId: verificationId);

  @computed
  bool get isValid => credential.isValidCode;

  enterCode() async {
    loading.show();
    await Future.delayed(Duration(seconds: 1));
    var result = await verifyPhoneCode(credential);
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
