import 'package:auxilium/community.dart';
import 'package:auxilium/login.dart';
import 'package:auxilium/my_account.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_button.dart';
import 'navbar.dart';

class CreateUser extends StatelessWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const CreateUser(this.user, this.googleSignIn, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String inputName;
    String inputMobileNo;
    String inputBankAccNo;
    String inputBio;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 168, 159, 104),
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('create new user',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198),
          leading: homeButton(context, user, googleSignIn)),
      bottomNavigationBar: buildNavBar(context, user, googleSignIn),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextFormField(
              maxLength: 30,
              onChanged: (text) {
                // ADD
                inputName = text;
              },
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Name',
                  hintText: 'How you want to be addressed',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 65, 82, 31))),
            ),
            TextFormField(
              maxLength: 8,
              keyboardType: TextInputType.phone,
              onChanged: (mobileNo) {
                inputMobileNo = mobileNo;
              },
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.phone),
                labelText: 'Mobile Number',
                hintText: 'Used for Paylah/PayNow',
                labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
              ),
            ),
            TextFormField(
              maxLength: 16,
              keyboardType: TextInputType.number,
              onChanged: (accNo) {
                inputBankAccNo = accNo;
              },
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.account_balance_wallet),
                labelText: 'Bank Account Number',
                hintText: '1234 5678 9098 7654',
                labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
              ),
            ),
            TextFormField(
              maxLength: 150,
              onChanged: (bio) {
                // ADD
                inputBio = bio;
              },
              //initialValue:
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 82, 31)),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.person),
                labelText: 'Bio',
                hintText: 'About yourself',
                labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
              ),
            ),
            Row(children: <Widget>[
              IconButton(
                  onPressed: () {
                    // Navigate back to first route when tapped.
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 238, 238, 238),
                  ),
                  onPressed: () {
                    confirmChangesAlert(context, inputName, inputMobileNo,
                        inputBankAccNo, inputBio);
                  },
                  child: const Text(
                    'Create Profile',
                    style: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
                  ))
            ]),
          ],
        ),
      ),
    );
  }

  confirmChangesAlert(BuildContext context, String name, String mobileNo,
      String bankAccNo, String bio) {
    // set up the buttons
    IconButton cancelButton = IconButton(
      icon: const Icon(Icons.cancel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget confirmButton = IconButton(
      icon: const Icon(Icons.check),
      onPressed: () async {
        await usersRef.doc(user.id).set({
          "name": name,
          "mobileNo": mobileNo,
          "bankAccNo": bankAccNo,
          "bio": bio,
          "bookmarks": {},
        }).then((value) => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyAccountPage(user, googleSignIn))));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Create New Profile"),
      content: const Text("Create Profile?"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
