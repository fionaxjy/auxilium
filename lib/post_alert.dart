import 'package:auxilium/create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

postAlert(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Will you be donating or requesting?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreatePost(user, googleSignIn, 'don')));
          },
          child: const Text('Donating'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreatePost(user, googleSignIn, 'req')));
          },
          child: const Text('Requesting'),
        )
      ],
    ),
  );
}
