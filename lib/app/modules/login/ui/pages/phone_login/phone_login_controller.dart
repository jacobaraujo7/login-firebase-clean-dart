import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guard_class/app/core/stores/auth_store.dart';
import 'package:guard_class/app/modules/login/domain/entities/login_credential.dart';
import 'package:guard_class/app/modules/login/domain/usecases/login_with_phone.dart';
import 'package:guard_class/app/modules/login/infra/errors/errors.dart';
import 'package:guard_class/app/modules/login/infra/models/user_model.dart';
import 'package:guard_class/app/modules/login/ui/utils/loading_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'phone_login_controller.g.dart';

@Injectable()
class PhoneLoginController = _PhoneLoginControllerBase
    with _$PhoneLoginController;

abstract class _PhoneLoginControllerBase with Store {
  final LoginWithPhone loginWithPhoneUsecase;
  final LoadingDialog loading;
  final AuthStore authStore;
  _PhoneLoginControllerBase(
      this.loginWithPhoneUsecase, this.loading, this.authStore);

  @observable
  String phone = "";

  @computed
  LoginCredential get credential =>
      LoginCredential.withPhone(phoneNumber: phone);

  @computed
  bool get isValid => credential.isValidPhone;

  @action
  setPhone(String value) => this.phone = value;

  enterPhone() async {
    loading.show();
    var result = await loginWithPhoneUsecase(credential);
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
      authStore.setUser(user as UserModel);
      Modular.to.popUntil(ModalRoute.withName(Modular.link.modulePath));
      Modular.to.pop();
    });
  }
}
