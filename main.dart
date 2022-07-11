import 'package:auxilium/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Auxilium',
      theme: ThemeData(fontFamily: 'AltonaSans'),
      home: const LoginPage(),
    ),
  );
}
