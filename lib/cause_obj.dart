import 'package:flutter/material.dart';

class Cause {
  final Widget icons;
  final String category;
  final String about;
  final int numPost;
  const Cause(this.icons, this.category, this.about, this.numPost);

  @override
  String toString() {
    return category;
  }
}
