import 'package:auxilium/causes.dart';
import 'package:auxilium/login.dart';
import 'package:flutter/material.dart';

Widget buildNavBar(BuildContext context) {
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CausesPage()));
            }),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline,
            color: Color.fromARGB(255, 65, 82, 31)),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.notifications_outlined,
            color: Color.fromARGB(255, 65, 82, 31)),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            color: const Color.fromARGB(255, 65, 82, 31),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }),
        label: '',
      )
    ],
  );
}
