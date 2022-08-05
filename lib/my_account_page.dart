import 'package:auxilium/edit_user.dart';
import 'package:auxilium/login.dart';
import 'package:auxilium/navbar.dart';
import 'package:auxilium/post%20viewers/comm_post_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_button.dart';
import 'post viewers/acc_post_viewer.dart';

class MyAccountPage extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const MyAccountPage(this.user, this.googleSignIn, {Key key})
      : super(key: key);

  @override
  MyAccountPageState createState() => MyAccountPageState();
}

class MyAccountPageState extends State<MyAccountPage> {
  bool isRequesting = true;
  bool isDonating = false;
  // bool isBookmarks = false;

  @override
  Widget build(BuildContext context) {
    String getInitials(String name) {
      return name.isNotEmpty
          ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
          : '';
    }

    return Scaffold(
        backgroundColor: Colors.white,
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
          actions: [signOutButton(context, widget.googleSignIn, widget.user)],
        ),
        body: Column(children: [
          Material(
            color: const Color.fromARGB(255, 245, 253, 198),
            elevation: 0.5,
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
                        'Software Engineer | Mother of 5 | Life, Laugh, Love',
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
                              isRequesting = true;
                              isDonating = false;
                              // isBookmarks = false;
                            });
                          },
                          child: Text(
                            'Requests',
                            style: isRequesting
                                ? const TextStyle(
                                    color: Color.fromARGB(255, 65, 82, 31),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)
                                : const TextStyle(
                                    color: Color.fromARGB(255, 245, 195, 150),
                                    fontSize: 16),
                          )),

                      //Donating
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            isRequesting = false;
                            isDonating = true;
                            // isBookmarks = false;
                          });
                        },
                        child: Text('Donations',
                            style: isDonating
                                ? const TextStyle(
                                    color: Color.fromARGB(255, 65, 82, 31),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )
                                : const TextStyle(
                                    color: Color.fromARGB(255, 245, 195, 150),
                                    fontSize: 16)),
                      ),

                      /*BOOKMARKS
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            isRequests = false;
                            isDonating = false;
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
                      ),*/
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              )
            ]),
          ),
          const SizedBox(
            height: 3,
          ),
          // ASSUMING DP AND USERNAME ARE GOOGLE ACCOUNT
          Expanded(
              child: isDonating
                  ? accDonatingPostViewer(widget.user, widget.googleSignIn,
                      widget.user.photoUrl, widget.user.displayName)
                  : accRequestingPostViewer(widget.user, widget.googleSignIn,
                      widget.user.photoUrl, widget.user.displayName)),
        ]));
  }
}

Widget signOutButton(
    BuildContext context, GoogleSignIn googleSignIn, GoogleSignInAccount user) {
  return IconButton(
      icon: const Icon(
        Icons.logout,
        size: 28,
      ),
      color: const Color.fromARGB(255, 65, 82, 31),
      onPressed: () {
        signOutAlert(context, googleSignIn, user);
      });
}

signOutAlert(
    BuildContext context, GoogleSignIn googleSignIn, GoogleSignInAccount user) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Sign Out of ${user.displayName}?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginPage()));
            googleSignIn.disconnect();
          },
          child: const Text('Sign Out'),
        )
      ],
    ),
  );
}
