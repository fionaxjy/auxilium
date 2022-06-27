import 'package:auxilium/causes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51LExNJDxXm9klQ4gV3CsHKUkClDf2BOQbwjdPxzLOEUNkSbgB40ICdgozbWUUfLZ5UG3zkbGsk3a1r660PJVmM7h003QvYVNfU';
  runApp(
    const MaterialApp(
      title: 'Auxilium',
      home: CausesPage(),
    ),
  );
}
