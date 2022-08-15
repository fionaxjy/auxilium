import 'package:auxilium/community_page.dart';
import 'package:auxilium/alerts.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home_button.dart';
import '../navbar.dart';
import 'post_format.dart';

class SingularPost extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  final Post post; // Retrieve from db

  const SingularPost(this.user, this.googleSignIn, this.post, {Key key})
      : super(key: key);

  @override
  SingularPostState createState() => SingularPostState();
}

class SingularPostState extends State<SingularPost> {
// RETRIEVE POST INFORMATION
  Post viewedPost; // Retrieve from postId

  Widget meetRequestButton() {
    return ElevatedButton(
        onPressed: () {
          // *** PAYMENT POPUP ***
        },
        child: const Text('Meet Request'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 168, 159, 104),
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text('community',
                style: TextStyle(
                    color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
            backgroundColor: const Color.fromARGB(255, 245, 253, 198),
            leading: backButton(context, widget.user, widget.googleSignIn)),
        bottomNavigationBar:
            buildNavBar(context, widget.user, widget.googleSignIn),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [viewedPost.postDp(), viewedPost.postUser()],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(viewedPost.title),
            ]),
            // post tags
            viewedPost.postBody(context, viewedPost.postId),
            meetRequestButton(),
            const Divider(),
            const Text(
                '\$123 out of \$456 received'), // Placeholder text, replace with retrieved data
            // progress bar
          ],
        ));
  }
}
