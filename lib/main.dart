import 'package:auxilium/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
