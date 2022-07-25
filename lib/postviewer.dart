import 'package:flutter/material.dart';
import 'posts_placeholder.dart';

Widget postViewer() {
  return Container(
    color: Colors.white,
    child: ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return posts[index];
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 0,
      ),
      itemCount: posts.length,
    ),
  );
}
