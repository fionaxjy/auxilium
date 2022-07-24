import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'community.dart';
import 'home_button.dart';
import 'navbar.dart';

class CreatePost extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  const CreatePost(this.user, this.googleSignIn, {Key key}) : super(key: key);

  @override
  CreatePostState createState() => CreatePostState();
}

class CreatePostState extends State<CreatePost> {
  String selectedTag = 'Tags';
  String selectedCol = 'Postage';
  String selectedCond = 'Brand New';

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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CommunityPage(widget.user, widget.googleSignIn)));
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
                maxLength: 1,
                onChanged: (content) {
                  // HELLO FIONA CAN U DO THIS
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
                  // HELLO FIONA CAN U DO THIS SHIT ALDJGKLSJGLSKJSLKJL
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
