import 'package:auxilium/causes.dart';
import 'package:auxilium/create_post.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SelectTag extends CausesPage {
  const SelectTag(GoogleSignInAccount user, GoogleSignIn googleSignIn,
      {Key key})
      : super(null, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 168, 159, 104),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text('select tag',
            style: TextStyle(
                color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
        backgroundColor: const Color.fromARGB(255, 245, 253, 198),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
        itemCount: causeList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).pop(MaterialPageRoute(
                    builder: (context) => CreatePost(user, googleSignIn)));
              },
              leading: causeList[index].icons,
              title: Text(
                causeList[index].category,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                causeList[index].about,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
