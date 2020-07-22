// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $VerifyCodeController = BindInject(
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
  Computed<LoginCredential> _$credentialComputed;

  @override
  LoginCredential get credential => (_$credentialComputed ??=
          Computed<LoginCredential>(() => super.credential,
              name: '_VerifyCodeControllerBase.credential'))
      .value;
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_VerifyCodeControllerBase.isValid'))
      .value;

  final _$codeAtom = Atom(name: '_VerifyCodeControllerBase.code');

  @override
  String get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  final _$_VerifyCodeControllerBaseActionController =
      ActionController(name: '_VerifyCodeControllerBase');

  @override
  dynamic setCode(String value) {
    final _$actionInfo = _$_VerifyCodeControllerBaseActionController
        .startAction(name: '_VerifyCodeControllerBase.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$_VerifyCodeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
code: ${code},
credential: ${credential},
isValid: ${isValid}
    ''';
  }
}
