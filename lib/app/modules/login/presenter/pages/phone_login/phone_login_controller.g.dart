// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_login_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $PhoneLoginController = BindInject(
  (i) => PhoneLoginController(
      i<LoginWithPhone>(), i<LoadingDialog>(), i<AuthStore>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PhoneLoginController on _PhoneLoginControllerBase, Store {
  Computed<LoginCredential> _$credentialComputed;

  @override
  LoginCredential get credential => (_$credentialComputed ??=
          Computed<LoginCredential>(() => super.credential,
              name: '_PhoneLoginControllerBase.credential'))
      .value;
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_PhoneLoginControllerBase.isValid'))
      .value;

  final _$phoneAtom = Atom(name: '_PhoneLoginControllerBase.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$_PhoneLoginControllerBaseActionController =
      ActionController(name: '_PhoneLoginControllerBase');

  @override
  dynamic setPhone(String value) {
    final _$actionInfo = _$_PhoneLoginControllerBaseActionController
        .startAction(name: '_PhoneLoginControllerBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_PhoneLoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
phone: ${phone},
credential: ${credential},
isValid: ${isValid}
    ''';
  }
}
