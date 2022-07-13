import 'package:auxilium/causes.dart';
import 'package:auxilium/my_account.dart';
import 'package:auxilium/notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Widget buildNavBar(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  return BottomNavigationBar(
    backgroundColor: const Color.fromARGB(255, 245, 253, 198),
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined, color: Color.fromARGB(255, 65, 82, 31)),
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
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline,
            color: Color.fromARGB(255, 65, 82, 31)),
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
