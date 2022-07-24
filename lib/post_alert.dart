import 'package:auxilium/create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

postAlert(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Donation Type'),
      content: const Text('What will you be donating/requesting?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreatePost(user, googleSignIn)));
          },
          child: const Text('Financial Aid'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreatePost(user, googleSignIn)));
          },
          child: const Text('Resource'),
        )
      ],
    ),
  );
}
