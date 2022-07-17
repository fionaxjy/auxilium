import 'package:auxilium/edit_user.dart';
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
        body: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 253, 198),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Wrap(children: [
              Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  /*GoogleUserCircleAvatar(
              identity: user,
            ),*/

                  Stack(
                    alignment: const FractionalOffset(1.2, 1.22),
                    children: <Widget>[
                      InkWell(
                        onTap: () => {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(widget.user.photoUrl),
                            backgroundColor:
                                const Color.fromARGB(255, 65, 82, 31),
                            radius: 36,
                            child: Text(getInitials(widget.user.displayName),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 245, 195, 150),
                                  fontSize: 18,
                                )),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Color.fromARGB(255, 65, 82, 31),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditUser(
                                      widget.user, widget.googleSignIn)));
                            },
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  // name
                  Text(widget.user.displayName ?? '',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 65, 82, 31),
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    width: 300,
                    child: Text(
                        // PLACEHOLDER TEXT FOR BIO INPUT
                        'Software Engineer  | Mother of 5 | Life, Laugh, Love',
                        style: TextStyle(
                          color: Color.fromARGB(255, 65, 82, 31),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 26),

                  // menu buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // REQUESTS
                      TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            setState(() {
                              isRequests = true;
                              isGiving = false;
                              isBookmarks = false;
                            });
                          },
                          child: Text(
                            'requests',
                            style: isRequests
                                ? const TextStyle(
                                    color: Color.fromARGB(255, 65, 82, 31),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)
                                : const TextStyle(
                                    color: Color.fromARGB(255, 245, 195, 150),
                                    fontSize: 16),
                          )),

                      //GIVING
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            isRequests = false;
                            isGiving = true;
                            isBookmarks = false;
                          });
                        },
                        child: Text('giving',
                            style: isGiving
                                ? const TextStyle(
                                    color: Color.fromARGB(255, 65, 82, 31),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )
                                : const TextStyle(
                                    color: Color.fromARGB(255, 245, 195, 150),
                                    fontSize: 16)),
                      ),

                      //BOOKMARKS
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            isRequests = false;
                            isGiving = false;
                            isBookmarks = true;
                          });
                        },
                        child: Text('bookmarks',
                            style: isBookmarks
                                ? const TextStyle(
                                    color: Color.fromARGB(255, 65, 82, 31),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)
                                : const TextStyle(
                                    color: Color.fromARGB(255, 245, 195, 150),
                                    fontSize: 16)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              )
            ]),
          ),
          //postViewer()
        ]));
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoginPage()));
          googleSignIn.disconnect();
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
