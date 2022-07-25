import 'package:auxilium/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey =
      'pk_test_51LNIctG51iBBw3VjKbJNTjeMrsJ6vV9eBGRw6BuDLFQEEkiVHO59uZhR2tX6Nfa8TswCg3qaf29WPZWn7eHnh1m000PuQLNw7b';
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
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
