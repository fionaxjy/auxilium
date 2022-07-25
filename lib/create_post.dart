import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'comments.dart';
import 'community.dart';
import 'home_button.dart';
import 'navbar.dart';

final postsRef = FirebaseFirestore.instance.collection('Posts');
final DateTime timestamp = DateTime.now();

class CreatePost extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  final String reqOrDonTag;
  const CreatePost(this.user, this.googleSignIn, this.reqOrDonTag, {Key key})
      : super(key: key);

  @override
  CreatePostState createState() => CreatePostState();
}

class CreatePostState extends State<CreatePost> {
  String selectedTag = 'Tags';
  String selectedCol = 'Postage';
  String selectedCond = 'Item Condition';
  String tempTitle;
  String tempContent;
  DateTime dateAndTime = timestamp;

  final causeList = const [
    'Tags',
    'Food',
    'Healthcare',
    'Space',
    'Utilities',
    'Clothes',
    'Education',
    'Others'
  ];

  final collList = const ['Postage', 'Courier', 'Meet Up', 'Collection Point'];
  final condList = const [
    'Item Condition',
    'Brand New',
    'Used Without Defects',
    'Used With Defects'
  ];

  @override
  Widget build(BuildContext context) {
    Widget postButton() {
      return TextButton(
          onPressed: () async {
            await postsRef.doc(widget.user.id).collection('Posts').add({
              "causeTag": selectedTag,
              "postage": selectedCol,
              "condition": selectedCond,
              "title": tempTitle,
              "content": tempContent,
              "reqOrDonTag": widget.reqOrDonTag,
              "dateAndTime": timestamp,
            }).then((value) => showComments(
                  widget.user,
                  widget.googleSignIn,
                  context,
                  postId: value.id,
                  userId: widget.user.id,
                  userDp: widget.user.photoUrl,
                ));
            // (value) =>  Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) =>
            //         CommunityPage(widget.user, widget.googleSignIn))));
          },
          child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(
                'share',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 65, 82, 31)),
              )));
    }

    DropdownMenuItem<String> buildMenuItem(String value) => DropdownMenuItem(
        value: value,
        child: Text(
          value,
        ));

    GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');

    return Scaffold(
        key: navBarGlobalKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: const Text('new post',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198),
          leading: homeButton(context, widget.user, widget.googleSignIn),
          actions: [postButton()],
        ),
        bottomNavigationBar:
            buildNavBar(context, widget.user, widget.googleSignIn),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                    child: Row(children: [
                  const Icon(Icons.discount),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: selectedTag,
                    elevation: 2,
                    items: causeList.map(buildMenuItem).toList(),
                    onChanged: (select) => setState(() => selectedTag = select),
                  ),
                ])),
              ),

              //Title
              TextField(
                style: const TextStyle(fontSize: 18),
                maxLength: 10,
                onChanged: (content) {
                  tempTitle = content;
                },
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    filled: true,
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 18)),
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                autofocus: true,
              ),

              //Post
              TextField(
                style: const TextStyle(fontSize: 16),
                maxLength: 1200,
                onChanged: (content) {
                  tempContent = content;
                },
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    filled: true,
                    fillColor: Colors.white,
                    alignLabelWithHint: true,
                    labelText: 'My Post',
                    hintText: 'Hey community!',
                    hintStyle: TextStyle(fontSize: 18)),
                keyboardType: TextInputType.multiline,
                maxLines: 22,
                autofocus: true,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                    child: Row(children: [
                  const Icon(Icons.swap_vert),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: selectedCol,
                    elevation: 2,
                    items: collList.map(buildMenuItem).toList(),
                    onChanged: (select) => setState(() => selectedCol = select),
                  ),
                ])),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                    child: Row(children: [
                  const Icon(Icons.library_add_check_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: selectedCond,
                    elevation: 2,
                    items: condList.map(buildMenuItem).toList(),
                    onChanged: (select) =>
                        setState(() => selectedCond = select),
                  ),
                ])),
              ),
            ],
          ),
        ));
  }
}

showComments(user, googleSignIn, BuildContext context,
    {String postId, String userId, String userDp}) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CommentsPage(
            user: user,
            googleSignIn: googleSignIn,
            postId: postId,
            userId: userId,
            userDp: userDp,
          )));
}
