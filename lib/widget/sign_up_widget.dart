import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../api/google_sign_in_api.dart';

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
              child: const Text('Auxilium',
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
          const Spacer(),
        ],
      );

  Widget GoogleButtonWidget() {
    return Container(
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(4),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 238, 238, 238),
            minimumSize: const Size(double.infinity, 50),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Color.fromARGB(255, 255, 106, 0),
          ),
          label: const Text(
            'Sign In With Google',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          onPressed: signIn,
        ));
  }

  Future signIn() async {
    await GoogleSignInApi.login();
  }
}
