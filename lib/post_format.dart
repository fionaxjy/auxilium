import 'package:auxilium/posts_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Post extends StatelessWidget {
  final String dp;
  final String username;
  final String timeAgo;
  final String title;
  final String text;
  final String comments;

  const Post(
      {Key key,
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
          postBody(),
        ],
      ),
    );
  }

  Widget postDp() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(this.dp),
      ),
    );
  }

  Widget postBody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [postHeader(), postTitle(), postText(), commentButton()],
      ),
    );
  }

  Widget postHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            this.username,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.angleDown,
            size: 14.0,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
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
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    );
  }

  Widget commentButton() {
    return Container(
        margin: const EdgeInsets.only(top: 10.0, right: 15.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(primary: Colors.white, elevation: 0),
          onPressed: () async {
            await postsRef.doc(widget.user.id).collection('Posts').add({
              "causeTag": selectedTag,
              "postage": selectedCol,
              "condition": selectedCond,
              "title": tempTitle,
              "content": tempContent,
              "reqOrDonTag": widget.reqOrDonTag,
              "dateAndTime": timestamp,
            }).then((value) => showComments(
                  widget.user,
                  widget.googleSignIn,
                  context,
                  postId: value.id,
                  userId: widget.user.id,
                  userDp: widget.user.photoUrl,
                ));
          },
          icon: Icon(
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
        ));
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