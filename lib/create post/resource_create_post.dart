import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../community_page.dart';
import '../post_comments.dart';
import '../home_button.dart';
import '../navbar.dart';
import 'package:quantity_input/quantity_input.dart';

// RESOURCE POST contains INTEGER only quantity input

// Problem with text input and dropdown menu state changes
// Add validators -> no unselected tags, no empty titles or post bodies

final postsRef = FirebaseFirestore.instance.collection('Posts');
final DateTime timestamp = DateTime.now();

class CreateResourcePost extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const CreateResourcePost(this.user, this.googleSignIn, {Key key})
      : super(key: key);

  @override
  CreateResourcePostState createState() => CreateResourcePostState();
}

class CreateResourcePostState extends State<CreateResourcePost> {
  String selectedTag = 'Tags';
  String selectedCol = 'Select Collection Method';
  String selectedCond = 'Item Condition';
  String tempTitle = '';
  String tempContent = '';
  String reqOrDonTag = 'req';
  DateTime dateAndTime = timestamp;
  int tempQuantity = 1;

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

  final collList = const [
    'Select Collection Method',
    'Postage',
    'Courier',
    'Meet Up',
    'Collection Point'
  ];

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
              "reqOrDonTag": reqOrDonTag,
              "dateAndTime": timestamp,
              "quantity": tempQuantity,
            }).then(
                /*(value) => showComments(
                  widget.user,
                  widget.googleSignIn,
                  context,
                  postId: value.id,
                  userId: widget.user.id,
                  userDp: widget.user.photoUrl,
                ));*/
                (value) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CommunityPage(widget.user, widget.googleSignIn))));
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
          padding: const EdgeInsets.all(15),
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
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedTag,
                      elevation: 2,
                      items: causeList.map(buildMenuItem).toList(),
                      onChanged: (select) =>
                          setState(() => selectedTag = select),
                    ),
                  )
                ])),
              ),

              const Divider(
                height: 5,
              ),
// REQ/DON TAG
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                // REQUESTS
                TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setState(() {
                        reqOrDonTag = "req";
                      });
                    },
                    child: Text(
                      'request',
                      style: reqOrDonTag == "req"
                          ? const TextStyle(
                              color: Color.fromARGB(255, 65, 82, 31),
                              fontSize: 16,
                              fontWeight: FontWeight.w600)
                          : const TextStyle(
                              color: Color.fromARGB(255, 245, 195, 150),
                              fontSize: 16),
                    )),

                //Donating
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    setState(() {
                      reqOrDonTag = "don";
                    });
                  },
                  child: Text('donation',
                      style: reqOrDonTag != "req"
                          ? const TextStyle(
                              color: Color.fromARGB(255, 65, 82, 31),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                          : const TextStyle(
                              color: Color.fromARGB(255, 245, 195, 150),
                              fontSize: 16)),
                ),
              ]),

              Divider(
                height: 5,
              ),

              // Title
              TextFormField(
                style: const TextStyle(fontSize: 18, height: 1.4),
                maxLength: 150,
                initialValue: tempTitle,
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
              TextFormField(
                style: const TextStyle(fontSize: 17),
                maxLength: 1200,
                initialValue: tempContent,
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
                maxLines: 16,
                autofocus: true,
              ),

// Quantity Indicator (integer)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.numbers),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Quantity: ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      QuantityInput(
                          value: tempQuantity,
                          buttonColor: const Color.fromARGB(255, 65, 82, 31),
                          onChanged: (value) => setState(() => tempQuantity =
                              int.parse(value.replaceAll(',', '')))),
                    ]),
              ),

              // Collection Method
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

              // Item Condition
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
