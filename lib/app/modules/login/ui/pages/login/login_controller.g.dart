// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $LoginController = BindInject(
  (i) =>
      LoginController(i<LoginWithEmail>(), i<LoadingDialog>(), i<AuthStore>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_LoginControllerBase.isValid'))
      .value;

  final _$credentialsAtom = Atom(name: '_LoginControllerBase.credentials');

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

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  dynamic setLoginCredentials(LoginCredentials value) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.setLoginCredentials');
    try {
      return super.setLoginCredentials(value);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
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
