import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantity_input/quantity_input.dart';
import '../community_page.dart';
import '../post_comments.dart';
import '../home_button.dart';
import '../navbar.dart';
import 'package:intl/intl.dart';

// FINANCE POST does NOT contain collection method, item condition, and contains DOUBLE quantity input

final postsRef = FirebaseFirestore.instance.collection('Posts');
final DateTime timestamp = DateTime.now();
final formatCurrency =
    NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'SGD');

class CreateMoneyPost extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  const CreateMoneyPost(this.user, this.googleSignIn, {Key key})
      : super(key: key);

  @override
  CreateMoneyPostState createState() => CreateMoneyPostState();
}

class CreateMoneyPostState extends State<CreateMoneyPost> {
  String selectedTag = 'tags';
  String tempTitle = '';
  String tempContent = '';
  DateTime dateAndTime = timestamp;
  double tempQuantity = 0;
  String reqOrDonTag = 'req';

  final causeList = const [
    'tags',
    'food',
    'healthcare',
    'space',
    'utilities',
    'clothes',
    'education',
    'others'
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
              "reqOrDonTag": reqOrDonTag,
              "dateAndTime": timestamp,
              "quantity": tempQuantity,
            }).then((value) => Navigator.of(context).push(MaterialPageRoute(
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
                  const Icon(
                    Icons.discount,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 12,
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
                  ),
                ])),
              ),

              const Divider(
                height: 5,
              ),

              // Quantity Indicator (double)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.attach_money,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "amount:",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(children: [
                        InkWell(
                          child: Text(
                            formatCurrency.format(tempQuantity),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                        child: Text(
                                      'enter amount',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    )),
                                  ),
                                  Center(
                                      child: TextFormField(
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        color: Color.fromARGB(255, 65, 82, 31)),
                                    decoration: const InputDecoration(
                                      prefixIcon: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(110, 3, 0, 3),
                                          child: Text('\$',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40,
                                                color: Color.fromARGB(
                                                    255, 95, 95, 95),
                                              ))),
                                      border: InputBorder.none,
                                    ),

                                    validator: (String amount) {
                                      return (amount != null)
                                          ? 'Enter a donation greater than \$0.'
                                          : null;
                                    },
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    textAlign: TextAlign.center,
                                    initialValue:
                                        tempQuantity.toStringAsFixed(2),
                                    onChanged: (value) => setState(() =>
                                        tempQuantity = double.parse(value)),
                                    // *** ISSUE WITH DECIMAL PLACES, IF INPUT IS 0.001, DATABASE REFLECTS 0.001 INSTEAD OF ROUNDING UP ***
                                    autofocus: true,
                                  ))
                                ]);
                              },
                            );
                          },
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Center(
                                          child: Text(
                                        'enter amount',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87),
                                      )),
                                    ),
                                    Center(
                                        child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                          color:
                                              Color.fromARGB(255, 65, 82, 31)),
                                      decoration: const InputDecoration(
                                        prefixIcon: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                110, 3, 0, 3),
                                            child: Text('\$',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40,
                                                  color: Color.fromARGB(
                                                      255, 95, 95, 95),
                                                ))),
                                        border: InputBorder.none,
                                      ),
                                      textAlign: TextAlign.center,
                                      initialValue:
                                          tempQuantity.toStringAsFixed(2),
                                      onChanged: (value) => setState(() =>
                                          tempQuantity = double.parse(value)),
                                      // *** ISSUE WITH DECIMAL PLACES, IF INPUT IS 0.001, DATABASE REFLECTS 0.001 INSTEAD OF ROUNDING UP ***
                                      autofocus: true,
                                    ))
                                  ]);
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Color.fromARGB(255, 97, 97, 97),
                            ))
                      ])
                    ]),
              ),

              const Divider(
                height: 10,
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

              const Divider(
                height: 5,
              ),

              // Title
              TextFormField(
                style: const TextStyle(fontSize: 18),
                initialValue: tempTitle,
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
                    hintStyle: TextStyle(fontSize: 18, color: Colors.black54)),
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                autofocus: true,
              ),

              // Post
              TextFormField(
                style: const TextStyle(fontSize: 16),
                initialValue: tempContent,
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
                    hintText: 'insert description here...',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.black38)),
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                autofocus: true,
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
