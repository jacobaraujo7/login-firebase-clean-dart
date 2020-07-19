import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'phone_login_controller.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState
    extends ModularState<PhoneLoginPage, PhoneLoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: controller.setPhone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Phone",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return RaisedButton(
                  onPressed: controller.isValid ? controller.enterPhone : null,
                  child: Text("ENTER"),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
