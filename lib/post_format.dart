import 'package:auxilium/posts_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Post extends StatelessWidget {
  final String dp;
  final String username;
  final String timeAgo;
  final String title;
  final String text;
  final String comments;
  final String favorites;

  const Post(
      {Key key,
      @required this.dp,
      @required this.username,
      @required this.timeAgo,
      @required this.title,
      @required this.text,
      @required this.comments,
      @required this.favorites})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postDp(),
          postBody(),
        ],
      ),
    );
  }

  Widget postDp() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(this.dp),
      ),
    );
  }

  Widget postBody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          postHeader(),
          postTitle(),
          postText(),
          postButtons(),
        ],
      ),
    );
  }

  Widget postHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            this.username,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.angleDown,
            size: 14.0,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget postText() {
    return Text(
      text,
      overflow: TextOverflow.clip,
    );
  }

  Widget postTitle() {
    return Text(
      '$title\n',
      overflow: TextOverflow.clip,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    );
  }

  Widget postButtons() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          postIconButton(FontAwesomeIcons.comment, this.comments),
          postIconButton(FontAwesomeIcons.heart, this.favorites),
          postIconButton(FontAwesomeIcons.share, ''),
        ],
      ),
    );
  }

  Widget postIconButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: Colors.black45,
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
