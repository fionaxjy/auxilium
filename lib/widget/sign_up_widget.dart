import 'package:flutter/material.dart';

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

  Widget GoogleButtonWidget() {
    return Container(
        padding: const EdgeInsets.all(4),
        child: OutlinedButton.icon(
          label: const Text(
            'Sign In With Google',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          onPressed: () {},
          icon: const Icon(Icons.login),
        ));
  }
}
