import 'package:auxilium/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Auxilium',
      theme: ThemeData(
          fontFamily: 'AltonaSans',
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: const Color.fromARGB(255, 65, 82, 31)),
          scaffoldBackgroundColor: Colors.white),
      home: const LoginPage(),
    ),
  );
}
