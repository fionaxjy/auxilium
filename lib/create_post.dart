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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: const TextStyle(fontSize: 20),
              maxLength: 1000,
              onChanged: (content) {
                // HELLO FIONA CAN U DO THIS SHIT ALDJGKLSJGLSKJSLKJL
              },
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.discount)),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'My Post',
                  alignLabelWithHint: true,
                  hintText: 'Hey community!',
                  hintStyle: const TextStyle(fontSize: 20)),
              scrollPadding: const EdgeInsets.all(20.0),
              keyboardType: TextInputType.multiline,
              maxLines: 99999,
              autofocus: true,
            )
          ],
        ),
      ),
    );
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
