import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'community.dart';
import 'home_button.dart';
import 'navbar.dart';

class CreatePost extends StatelessWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const CreatePost(this.user, this.googleSignIn, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget postButton() {
      return TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CommunityPage(user, googleSignIn)));
          },
          child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                'share',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 65, 82, 31)),
              )));
    }

    GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');

    return Scaffold(
        key: navBarGlobalKey,
        backgroundColor: const Color.fromARGB(255, 168, 159, 104),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('new post',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198),
          leading: homeButton(context, user, googleSignIn),
          actions: [postButton()],
        ),
        bottomNavigationBar: buildNavBar(context, user, googleSignIn),
        body: Column(children: <Widget>[
          TextFormField(
            style: const TextStyle(fontSize: 20),
            maxLength: 1000,
            autofocus: true,
            onChanged: (content) {},
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.fromLTRB(25, 25, 25, 540),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 14, 20, 3)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: 'My Post',
                alignLabelWithHint: true,
                hintText: 'Hey community!',
                hintStyle: TextStyle(fontSize: 20)),
          ),
        ]));
  }

  deleteChangesAlert(BuildContext context) {
    // set up the buttons
    IconButton cancelButton = IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = IconButton(
      icon: const Icon(Icons.check),
      onPressed: () async {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommunityPage(user, googleSignIn)));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("If you exit will lose your post."),
      content: const Text("Discard draft?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
