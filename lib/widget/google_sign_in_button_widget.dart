import 'package:flutter/material.dart';

class GoogleButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(4.0),
    child: OutlinedButton.icon(
      label: const Text(
        'Sign In With Google',
      )
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      highlightedBorderColor: Colors.black,
      borderSide: BorderSide(color: COlors.black),
      textColor: Colors.black,
      icon: FaIcon(),
    onPressed: onPressed, icon: icon, label: label),
  )
}
