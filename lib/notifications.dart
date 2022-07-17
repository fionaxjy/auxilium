import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_button.dart';
import 'navbar.dart';

class NotificationsPage extends StatelessWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const NotificationsPage(this.user, this.googleSignIn, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Notif> notifList = [
      Notif(NetworkImage(user.photoUrl), user.displayName, DateTime.now(),
          "User commented on your post"),
      Notif(NetworkImage(user.photoUrl), user.displayName, DateTime.now(),
          "User donated to your request"),
    ];
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
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        itemCount: notifList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {},
              leading: CircleAvatar(foregroundImage: notifList[index].pic),
              title: Text(
                notifList[index].name,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "${notifList[index].time.toString()} \n \n ${notifList[index].content}",
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      bottomNavigationBar: buildNavBar(context, user, googleSignIn),
    );
  }
}

class Notif {
  final NetworkImage pic;
  final String name;
  final DateTime time;
  final String content;

  const Notif(this.pic, this.name, this.time, this.content);

  @override
  String toString() {
    return "Poster $name at ${time.toString()}";
  }
}
