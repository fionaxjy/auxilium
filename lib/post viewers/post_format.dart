import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../post_comments.dart';

class Post extends StatelessWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  final String postId;
  final String dp;
  final String username;
  final String timeAgo;
  final String title;
  final String text;
  final String comments;

  const Post(
      {Key key,
      this.user,
      this.googleSignIn,
      this.postId,
      @required this.dp,
      @required this.username,
      @required this.timeAgo,
      @required this.title,
      @required this.text,
      @required this.comments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postDp(),
          postBody(context, postId),
        ],
      ),
    );
  }

  Widget postDp() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(dp),
      ),
    );
  }

  Widget postBody(BuildContext context, String postId) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postUser(), // Add GIVING/REQUEST TAG
          postTitle(),
          postText(),
          commentButton(user, googleSignIn, context, postId)
        ],
      ),
    );
  }

  Widget postUser() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            username,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        Text(timeAgo)
      ],
    );
  }

  Widget postText() {
    return Text(
      text,
      overflow: TextOverflow.clip,
    );
  }

  Widget postTitle() {
    return Text(
      '$title\n',
      overflow: TextOverflow.clip,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    );
  }

  Widget commentButton(GoogleSignInAccount user, GoogleSignIn googleSignIn,
      BuildContext context, String postId) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: Colors.white, elevation: 0),
      onPressed: () {
        showComments(user, googleSignIn, context, postId: postId);
      },
      icon: const Icon(
        FontAwesomeIcons.comment,
        size: 16.0,
        color: Colors.black45,
      ),
      label: Container(
        margin: const EdgeInsets.all(6.0),
        child: Text(
          comments,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}

showComments(user, googleSignIn, BuildContext context,
    {String postId, String userId, String userDp}) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CommentsPage(
            user: user,
            googleSignIn: googleSignIn,
            postId: postId,
            userId: userId,
            userDp: userDp,
          )));
}
