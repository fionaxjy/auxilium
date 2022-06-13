import 'package:auxilium/widget/sign_up_widget.dart';
import 'package:flutter/material.dart';

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
