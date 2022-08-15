import 'package:auxilium/post%20viewers/singular_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../post_comments.dart';

class Post extends StatelessWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  final String userId;
  final String postId;
  final String dp;
  final String username;
  final String timeAgo;
  final String title;
  final String content;
  final String comments;
  final String reqOrDonTag;
  final String condition;
  final String collMethod;
  final String causeTag;

  const Post({
    Key key,
    @required this.user,
    @required this.googleSignIn,
    @required this.userId,
    @required this.postId,
    this.dp,
    @required this.username,
    @required this.timeAgo,
    @required this.title,
    @required this.content,
    @required this.comments,
    this.reqOrDonTag,
    this.condition,
    this.collMethod,
    this.causeTag,
  }) : super(key: key);

  factory Post.fromDoc(GoogleSignInAccount user, GoogleSignIn googleSignIn,
      DocumentSnapshot doc) {
    return Post(
        user: user,
        googleSignIn: googleSignIn,
        userId: doc['userId'],
        dp: doc['userDp'],
        username: doc['name'],
        timeAgo: timeago.format(doc['dateAndTime'].toDate()),
        title: doc['title'],
        content: doc['content'],
        comments: doc['comments'],
        reqOrDonTag: doc['reqOrDonTag'],
        condition: doc['condition'],
        collMethod: doc['postage'],
        causeTag: doc['causeTag']);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: InkWell(
            onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SingularPost(user, googleSignIn, this)))),
            child: Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  postDp(),
                  postBody(context, postId),
                ],
              ),
            )));
  }

  Widget postDp() {
    return Column(children: [
      Stack(alignment: const FractionalOffset(0.5, 1.4), children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(dp),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: reqOrDonTag == 'don'
                  ? Color.fromARGB(255, 166, 159, 111)
                  : Color.fromARGB(255, 237, 197, 156),
              border: Border.all(
                width: 2,
                color: Color.fromARGB(255, 68, 82, 38),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(
            reqOrDonTag == 'don' ? "donation" : "request",
            style: reqOrDonTag == 'req'
                ? TextStyle(color: Color.fromARGB(255, 68, 82, 38))
                : TextStyle(color: Colors.white),
          ),
        ),
      ]),
      SizedBox(
        height: 24,
      ),
      Container(
        padding: EdgeInsets.all(5),
        child: Icon(
          getIcon(causeTag),
          color: Colors.black,
        ),
      )
    ]);
  }

  IconData getIcon(String causeName) {
    switch (causeName) {
      case 'Food':
        return Icons.fastfood;
        break;
      case 'Healthcare':
        return Icons.local_hospital;
        break;
      case 'Space':
        return Icons.house;
        break;
      case 'Utilities':
        return Icons.handyman;
        break;
      case 'Clothes':
        return Icons.checkroom;
        break;
      case 'Education':
        return Icons.school;
        break;
      case 'Others':
        return Icons.more_horiz;
        break;
    }
  }

  Widget postBody(BuildContext context, String postId) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postUser(),
          SizedBox(
            height: 10,
          ),
          postTitle(),
          postText(),
          commentButton(user, googleSignIn, context, postId)
        ],
      ),
    ));
  }

  Widget postUser() {
    return Row(
      children: [
        Container(
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
      content,
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
        child: Text(
          comments,
          style: const TextStyle(
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
