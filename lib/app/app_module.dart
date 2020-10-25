import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:guard_class/app/app_widget.dart';
import 'package:guard_class/app/modules/login/login_module.dart';

import 'core/pages/spash_screen_page.dart';
import 'core/stores/auth_store.dart';
import 'modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        ...LoginModule.export,
        $AuthStore,
        Bind((i) => FirebaseAuth.instance),
        Bind((i) => Connectivity()),
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (_, __) => SplashScreenPage()),
        Router("/login", module: LoginModule()),
        Router("/home", module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
