import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'verify_code_controller.dart';

class VerifyCodePage extends StatefulWidget {
  final String title;
  const VerifyCodePage({Key key, this.title = "VerifyCode"}) : super(key: key);

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState
    extends ModularState<VerifyCodePage, VerifyCodeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Code"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: controller.setCode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Verification Code",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return RaisedButton(
                  onPressed: controller.isValid ? controller.enterCode : null,
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
