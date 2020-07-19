import 'package:flutter_modular/flutter_modular.dart';
import 'data/datasources/firebase_datasource.dart';
import 'domain/usecases/login_with_email.dart';
import 'domain/usecases/login_with_phone.dart';
import 'domain/usecases/verify_phone_code.dart';
import 'infra/repositories/login_repository_impl.dart';
import 'ui/pages/login/login_controller.dart';
import 'ui/pages/login/login_page.dart';
import 'ui/pages/phone_login/phone_login_controller.dart';
import 'ui/pages/phone_login/phone_login_page.dart';
import 'ui/pages/verify_code/verify_code_controller.dart';
import 'ui/pages/verify_code/verify_code_page.dart';
import 'ui/utils/loading_dialog.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $VerifyCodeController,
        $LoginController,
        $PhoneLoginController,
        $LoginWithEmail,
        $VerifyPhoneCode,
        $LoginWithPhone,
        $LoginRepositoryImpl,
        $FirebaseDataSourceImpl,
        $LoadingDialogImpl
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (context, args) => LoginPage()),
        Router("/phone", child: (context, args) => PhoneLoginPage()),
        Router("/verify/:verificationId",
            child: (context, args) => VerifyCodePage()),
      ];
}
