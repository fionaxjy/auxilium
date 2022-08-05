import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'community_page.dart';

Widget homeButton(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  return IconButton(
      icon: Image.asset('assets/logo.png'),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommunityPage(user, googleSignIn)));
      });
}

Widget backButton(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommunityPage(user, googleSignIn)));
      });
}
