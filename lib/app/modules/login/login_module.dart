import 'presenter/pages/verify_code/verify_code_controller.dart';
import 'presenter/pages/verify_code/verify_code_page.dart';
import 'presenter/utils/loading_dialog.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'data/datasources/firebase_datasource.dart';
import 'data/repositories/firebase_login_repository_impl.dart';
import 'domain/usecases/login_with_email.dart';
import 'domain/usecases/login_with_phone.dart';
import 'domain/usecases/verify_phone_code.dart';
import 'presenter/pages/login/login_page.dart';
import 'presenter/pages/phone_login/phone_login_controller.dart';
import 'presenter/pages/phone_login/phone_login_page.dart';
import 'presenter/pages/login/login_controller.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        verifyCodeController,
        loginController,
        phoneLoginController,
        loginWithEmail,
        verifyPhoneCode,
        loginWithPhone,
        firebaseLoginRepositoryImpl,
        firebaseDataSourceImpl,
        loadingDialogImpl
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (context, args) => LoginPage()),
        Router("/phone", child: (context, args) => PhoneLoginPage()),
        Router("/verify/:verificationId",
            child: (context, args) => VerifyCodePage()),
      ];
}
