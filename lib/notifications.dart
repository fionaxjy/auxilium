import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'home_button.dart';
import 'navbar.dart';

final notificationsRef = FirebaseFirestore.instance.collection('Notifications');

class NotificationsPage extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const NotificationsPage(this.user, this.googleSignIn, {Key key})
      : super(key: key);

  @override
  NotificationsPageState createState() => NotificationsPageState(
        user: user,
        googleSignIn: googleSignIn,
      );
}

class NotificationsPageState extends State<NotificationsPage> {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  NotificationsPageState({
    this.user,
    this.googleSignIn,
  });

  getNotifications() async {
    QuerySnapshot snapshot = await notificationsRef
        .doc(user.id)
        .collection('Notifications')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .get();
    List<NotificationsItem> notificationsItems = [];
    snapshot.docs.forEach((doc) {
      notificationsItems.add(NotificationsItem.fromDoc(doc));
    });
    return notificationsItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 168, 159, 104),
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('notifications',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198),
          leading: homeButton(context, user, googleSignIn)),
      body: Container(
          child: FutureBuilder(
        future: getNotifications(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data,
          );
        },
      )),
      bottomNavigationBar: buildNavBar(context, user, googleSignIn),
    );
  }
}

Widget mediaPreview;
String notificationItemText;

class NotificationsItem extends StatelessWidget {
  final String userId;
  final String userDp;
  final String postId;
  final String commentData;
  final Timestamp timestamp;
  final String type;

  NotificationsItem({
    this.userId,
    this.userDp,
    this.postId,
    this.commentData,
    this.timestamp,
    this.type,
  });

  factory NotificationsItem.fromDoc(DocumentSnapshot doc) {
    return NotificationsItem(
      userId: doc['userId'],
      //userDp: doc['userDp'],
      postId: doc['postId'],
      commentData: doc['content'],
      timestamp: doc['timestamp'],
      type: doc['type'],
    );
  }

  configureMediaPreview() {
    notificationItemText = 'You received a comment on your post: $commentData';
  }

  @override
  Widget build(BuildContext context) {
    configureMediaPreview();

    return Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Container(
          color: Colors.white54,
          child: ListTile(
            title: GestureDetector(
              onTap: () => print('show profile'), // post viewer
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(style: const TextStyle(fontSize: 14), children: [
                  TextSpan(
                    text: ' $notificationItemText',
                  ),
                ]),
              ),
            ),
            //leading: CircleAvatar(backgroundImage: NetworkImage(userDp)),
            subtitle: Text(
              timeago.format(timestamp.toDate()),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: mediaPreview,
          ),
        ));
  }
}
