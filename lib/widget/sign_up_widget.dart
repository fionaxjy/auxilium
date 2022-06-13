import 'package:flutter/material.dart';
import 'package:flutter_application_2/widget/google_sign_in_button_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildSignUp();

  Widget buildSignUp() => Column(
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 175,
              child: const Text('Login Page',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          const Spacer(),
          GoogleButtonWidget(),
          const SizedBox(height: 12),
          const Text(
            'Login to continue',
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
        ],
      );
}
