import 'package:auxilium/mysqlconnector.dart';
import 'package:auxilium/navbar.dart';
import 'package:auxilium/user_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'mysqlconnector.dart';
import 'user_input_screen.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  State createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  GoogleSignInAccount _currentUser;

  // check if logged in user is the same
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  // sign-in method
  Future<void> _handleSignIn() async {
    _currentUser = await _googleSignIn.signIn();
  }

  // sign-out method
  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildNavBar(context),
        appBar: AppBar(
          title: const Text('My Account'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: buildSignUp(),
        ));
  }

  Widget buildSignUp() {
    GoogleSignInAccount user = _currentUser;

    if (user != null) {
      UserInfo addUser = UserInfo(user.id, user.displayName, '', '', '');
      return myAccountPage(user, addUser);
    } else {
      return Column(
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
          googleButtonWidget(),
          const SizedBox(height: 12),
          const Spacer(),
        ],
      );
    }
  }

  Widget googleButtonWidget() {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(4),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 238, 238, 238),
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
          // SIGN IN
          onPressed: _handleSignIn,
        ));
  }

  Widget myAccountPage(GoogleSignInAccount user, UserInfo addUser) {
    testsql(addUser);
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(addUser.personName ?? ''),
            subtitle: Text(user.email),
          ),
          ElevatedButton(
            child: const Text('Edit Profile'),
            onPressed: () {
              // Navigate to second route when tapped.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserInput(addUser)),
              );
            },
          ),

          // SIGN OUT
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ]);
  }
}
