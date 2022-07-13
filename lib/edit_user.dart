import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_button.dart';
import 'navbar.dart';

class CreatePage extends StatelessWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const CreatePage(this.user, this.googleSignIn, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 168, 159, 104),
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('new post',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198),
          leading: homeButton(context, user, googleSignIn)),
      bottomNavigationBar: buildNavBar(context, user, googleSignIn),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextFormField(
              initialValue: user.displayName,
              maxLength: 30,
              onChanged: (text) {
                // ADD
              },
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'How you want to be addressed',
              ),
            ),
            TextFormField(
              maxLength: 30,
              keyboardType: TextInputType.phone,
              onChanged: (mobileNo) {
                // ADD
              },
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                  labelText: 'Mobile Number',
                  hintText: 'Used for Paylah/PayNow'),
            ),
            TextFormField(
              maxLength: 17,
              keyboardType: TextInputType.number,
              onChanged: (accNo) {
                // ADD
              },
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.account_balance_wallet),
                labelText: 'Bank Account Number',
                hintText: '123 4567 890',
              ),
            ),
            TextFormField(
              maxLength: 150,
              onChanged: (bio) {
                // ADD
              },
              //initialValue:
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.person),
                  labelText: 'Bio',
                  hintText: 'About yourself'),
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
                  onPressed: () {
                    confirmChangesAlert(context);
                  },
                  child: const Text('Save Profile'))
            ]),
          ],
        ),
      ),
    );
  }

  confirmChangesAlert(BuildContext context) {
    // set up the buttons
    IconButton cancelButton = IconButton(
      icon: const Icon(Icons.cancel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = IconButton(
      icon: const Icon(Icons.check),
      onPressed: () async {
        Navigator.of(context).pop();
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Changes"),
      content: const Text("Save Profile?"),
      actions: [
        cancelButton,
        continueButton,
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
