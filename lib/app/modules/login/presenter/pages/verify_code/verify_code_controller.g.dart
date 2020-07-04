// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final verifyCodeController = BindInject(
  (i) => VerifyCodeController(
      i<VerifyPhoneCode>(), i<LoadingDialog>(), i<AuthStore>(),
      verificationId: i.args.params['verificationId']),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VerifyCodeController on _VerifyCodeControllerBase, Store {
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_VerifyCodeControllerBase.isValid'))
      .value;

  final _$credentialsAtom = Atom(name: '_VerifyCodeControllerBase.credentials');

  @override
  LoginCredentials get credentials {
    _$credentialsAtom.reportRead();
    return super.credentials;
  }

  @override
  set credentials(LoginCredentials value) {
    _$credentialsAtom.reportWrite(value, super.credentials, () {
      super.credentials = value;
    });
  }

  final _$_VerifyCodeControllerBaseActionController =
      ActionController(name: '_VerifyCodeControllerBase');

  @override
  dynamic setLoginCredentials(LoginCredentials value) {
    final _$actionInfo = _$_VerifyCodeControllerBaseActionController
        .startAction(name: '_VerifyCodeControllerBase.setLoginCredentials');
    try {
      return super.setLoginCredentials(value);
    } finally {
      _$_VerifyCodeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
credentials: ${credentials},
isValid: ${isValid}
    ''';
  }
}
