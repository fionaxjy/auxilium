import 'package:auxilium/my_account.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'create_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('Users');
final DateTime timestamp = DateTime.now();

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
    _currentUser =
        await _googleSignIn.signIn().then((account) => _signIn(account));
  }

  _signIn(GoogleSignInAccount account) {
    _currentUser = account;
    if (_currentUser != null) {
      print('createUserInFirestore');
      createUserInFirestore();
    }
  }

// SAME AS LINES 72-81, CREATES MULTIPLE PAGES. PROBLEM
  createUserInFirestore() async {
    final DocumentSnapshot doc = await usersRef.doc(_currentUser.id).get();
    if (!doc.exists) {
      print('check doc exists');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreateUser(_currentUser, _googleSignIn)));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyAccountPage(_currentUser, _googleSignIn)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: buildSignUp(),
    ));
  }

  Widget buildSignUp() {
    GoogleSignInAccount user = _currentUser;

    if (user != null) {
      createUserInFirestore();
    } else {
      return signInPage();
    }
  }

  Widget signInPage() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 253, 198),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Image.asset(
            'assets/img_vines.png',
            width: 250,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/logo.png',
            width: 88,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          child: const Text('auxilium.',
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'AltonaSans',
                  color: Color.fromARGB(255, 65, 82, 31))),
        ),
        const SizedBox(height: 18),
        Container(
          alignment: Alignment.center,
          child: const Text(
              'a mutual-aid facilitating platform\nensuring community needs are met',
              style: TextStyle(
                  height: 1.2,
                  fontSize: 16,
                  fontFamily: 'AltonaSans',
                  color: Color.fromARGB(255, 65, 82, 31))),
        ),
        const SizedBox(height: 28),
        googleButtonWidget(),
      ]),
    );
  }

  Widget googleButtonWidget() {
    return Container(
        width: 220,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(4),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 238, 238, 238),
            minimumSize: const Size(double.infinity, 50),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Color.fromARGB(255, 167, 159, 111),
          ),
          label: const Text(
            '  Sign In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(255, 32, 41, 15),
            ),
          ),
          // SIGN IN
          onPressed: _handleSignIn,
        ));
  }
}
