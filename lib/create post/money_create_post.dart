import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../post_comments.dart';
import '../home_button.dart';
import '../navbar.dart';

// FINANCE POST does NOT contain collection method, item condition, and contains DOUBLE quantity input

final postsRef = FirebaseFirestore.instance.collection('Posts');
final DateTime timestamp = DateTime.now();

class CreateMoneyPost extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  final String reqOrDonTag;
  const CreateMoneyPost(this.user, this.googleSignIn, this.reqOrDonTag,
      {Key key})
      : super(key: key);

  @override
  CreateMoneyPostState createState() => CreateMoneyPostState();
}

class CreateMoneyPostState extends State<CreateMoneyPost> {
  String selectedTag = 'Tags';
  String tempTitle;
  String tempContent;
  DateTime dateAndTime = timestamp;
  // Add into db quantity
  // double tempQuantity;

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

  @override
  Widget build(BuildContext context) {
    Widget postButton() {
      return TextButton(
          onPressed: () async {
            await postsRef.doc(widget.user.id).collection('Posts').add({
              "causeTag": selectedTag,
              "postage": null,
              "condition": null,
              "title": tempTitle,
              "content": tempContent,
              "reqOrDonTag": widget.reqOrDonTag,
              "dateAndTime": timestamp,
              // "quantity" : tempQuantity,
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
          title: const Text('create post',
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

              // Title
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
                    hintText: 'insert post title...',
                    hintStyle: TextStyle(fontSize: 18)),
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                autofocus: true,
              ),

              // Post
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
                    hintText: 'insert description here...',
                    hintStyle: TextStyle(fontSize: 18)),
                keyboardType: TextInputType.multiline,
                maxLines: 22,
                autofocus: true,
              ),

              // Quantity Indicator (double)
              // *** ADD ***
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
