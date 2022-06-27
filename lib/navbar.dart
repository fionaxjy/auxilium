import 'package:auxilium/causes.dart';
import 'package:flutter/material.dart';
import 'login.dart';

Widget buildNavBar(BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined, color: Colors.black),
        backgroundColor: Colors.white,
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.volunteer_activism_outlined),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CausesPage()));
            }),
        backgroundColor: Colors.white,
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline, color: Colors.black),
        backgroundColor: Colors.white,
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.notifications_outlined, color: Colors.black),
        backgroundColor: Colors.white,
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }),
        backgroundColor: Colors.white,
        label: '',
      )
    ],
  );
}
