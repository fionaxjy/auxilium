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
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 168, 159, 104),
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text('new post',
                style: TextStyle(
                    color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
            backgroundColor: const Color.fromARGB(255, 245, 253, 198),
            leading: homeButton(context, user, googleSignIn)),
        bottomNavigationBar: buildNavBar(context, user, googleSignIn),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextFormField(
                    maxLength: 30,
                    onChanged: (content) {},
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 65, 82, 31)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 65, 82, 31)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'My Post',
                        hintText: 'Hey community!',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 65, 82, 31))),
                  ),
                ])));
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
