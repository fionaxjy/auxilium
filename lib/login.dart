import 'package:flutter/material.dart';
import 'package:flutter_application_2/widget/sign_up_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SignUpWidget(),
    ));
  }
}
