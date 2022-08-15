import 'package:auxilium/causes_page.dart';
import 'package:auxilium/community_page.dart';
import 'package:auxilium/create%20post/money_create_post.dart';
import 'package:auxilium/create%20post/resource_create_post.dart';
import 'package:auxilium/my_account_page.dart';
import 'package:auxilium/notifications_page.dart';
import 'package:auxilium/alerts.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Widget buildNavBar(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  return BottomNavigationBar(
    backgroundColor: const Color.fromARGB(255, 245, 253, 198),
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.home_outlined),
            color: const Color.fromARGB(255, 65, 82, 31),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommunityPage(user, googleSignIn)));
            }),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.volunteer_activism_outlined),
            color: const Color.fromARGB(255, 65, 82, 31),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CausesPage(user, googleSignIn)));
            }),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: const Color.fromARGB(255, 65, 82, 31),
            onPressed: () =>
                resourceTypePostAlert(context, user, googleSignIn)),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            color: const Color.fromARGB(255, 65, 82, 31),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationsPage(user, googleSignIn)));
            }),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            color: const Color.fromARGB(255, 65, 82, 31),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyAccountPage(user, googleSignIn)));
            }),
        label: '',
      )
    ],
  );
}
