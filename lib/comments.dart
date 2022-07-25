import 'package:auxilium/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'home_button.dart';
import 'notifications.dart';

final commentsRef = FirebaseFirestore.instance.collection('Comments');
final DateTime timestamp = DateTime.now();

class CommentsPage extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  final String postId;
  final String userId;
  final String userDp;

  CommentsPage({
    this.user,
    this.googleSignIn,
    this.postId,
    this.userId,
    this.userDp,
  });

  @override
  CommentsState createState() => CommentsState(
        user: user,
        googleSignIn: googleSignIn,
        postId: this.postId,
        userId: this.userId,
        userDp: this.userDp,
      );
}

class CommentsState extends State<CommentsPage> {
  TextEditingController commentController = TextEditingController();
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  final String postId;
  final String userId;
  final String userDp;

  CommentsState({
    this.user,
    this.googleSignIn,
    this.postId,
    this.userId,
    this.userDp,
  });

  buildComments() {
    return StreamBuilder(
        stream: commentsRef
            .doc(postId)
            .collection('Comments')
            .orderBy("dateAndTime", descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // circularProgress()
          }
          List<Comment> comments = [];
          snapshot.data.docs.forEach((doc) {
            comments.add(Comment.fromDoc(doc));
          });
          return ListView(
            children: comments,
          );
        });
  }

  addComment() {
    commentsRef.doc(postId).collection("Comments").add({
      "commentString": commentController.text,
      "dateAndTime": timestamp,
      "userId": user.id,
      "userDp": userDp,
    });
    //bool isNotPostOwner = userId != currentuser.id;
    notificationsRef.doc(userId).collection('Notifications').add({
      "type": "comment",
      "content": commentController.text,
      "userDp": userDp,
      "userId": userId,
      "postId": postId,
      "timestamp": timestamp,
    });
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 168, 159, 104),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('comments',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198),
          leading: homeButton(context, widget.user, widget.googleSignIn),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: buildComments()),
            Divider(),
            ListTile(
                title: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(labelText: "Write a comment..."),
                ),
                trailing: OutlinedButton(
                  onPressed: () => addComment(),
                  child: Text("Post"),
                ))
          ],
        ));
  }
}

// to display individual comments in the comments page
class Comment extends StatelessWidget {
  final String userId;
  final String commentString;
  final Timestamp timestamp;
  final String userDp;

  Comment({
    this.userId,
    this.commentString,
    this.timestamp,
    this.userDp,
  });

  factory Comment.fromDoc(DocumentSnapshot doc) {
    return Comment(
      userId: doc['userId'],
      commentString: doc['commentString'],
      timestamp: doc['dateAndTime'],
      userDp: doc['userDp'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(commentString),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(userDp),
          ),
          subtitle: Text(timeago.format(timestamp.toDate())),
        ),
        Divider(),
      ],
    );
  }
}
