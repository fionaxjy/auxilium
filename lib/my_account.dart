import 'package:auxilium/login.dart';
import 'package:auxilium/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_button.dart';

class MyAccountPage extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const MyAccountPage(this.user, this.googleSignIn, {Key key})
      : super(key: key);

  @override
  MyAccountPageState createState() => MyAccountPageState();
}

class MyAccountPageState extends State<MyAccountPage> {
  bool isRequests = true;
  bool isGiving = false;
  bool isBookmarks = false;

  @override
  Widget build(BuildContext context) {
    String getInitials(String name) {
      return name.isNotEmpty
          ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
          : '';
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 167, 159, 111),
      bottomNavigationBar:
          buildNavBar(context, widget.user, widget.googleSignIn),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('my account',
            style: TextStyle(
                color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
        backgroundColor: const Color.fromARGB(255, 245, 253, 198),
        leading: homeButton(context, widget.user, widget.googleSignIn),
        actions: [signOutButton(context, widget.googleSignIn)],
      ),
    );
  }

  /*Widget postViewer() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 80, left: 20),
                ),
                Card(
                  child: ListTile(
                    leading: Text(widget.user.displayName ?? ''),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}*/

  Widget signOutButton(BuildContext context, GoogleSignIn googleSignIn) {
    return IconButton(
        icon: const Icon(
          Icons.logout,
          size: 28,
        ),
        color: const Color.fromARGB(255, 65, 82, 31),
        onPressed: () {
          signOutAlert(context, googleSignIn);
        });
  }

  signOutAlert(BuildContext context, GoogleSignIn googleSignIn) {
    Widget confirmButton = IconButton(
        icon: const Icon(Icons.check),
        onPressed: () async {
          googleSignIn.disconnect();
          const LoginPage();
          Navigator.of(context).pop();
        });
    Widget cancelButton = IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          Navigator.of(context).pop();
        });
    AlertDialog signOutAlert = AlertDialog(
      content: const Text('Confirm Sign Out?'),
      actions: [confirmButton, cancelButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return signOutAlert;
      },
    );
  }
}
