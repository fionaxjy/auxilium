/*import 'package:flutter/material.dart';
import 'archive/mysqlconnector.dart';

class UserInput extends StatelessWidget {
  UserInfo user;
  UserInfo newUser;
  UserInput(this.user, {Key key}) : super(key: key) {
    newUser = UserInfo(
        user.userID, user.personName, user.mobileNo, user.bankAccNo, user.bio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            backgroundColor: Colors.white,
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_outlined, color: Colors.black),
            backgroundColor: Colors.white,
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, color: Colors.black),
            backgroundColor: Colors.white,
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            backgroundColor: Colors.white,
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: Colors.black),
            backgroundColor: Colors.white,
            label: '',
          )
        ],
      ),
      appBar: AppBar(
        title: const Text('Enter User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextFormField(
              initialValue: user.personName,
              maxLength: 30,
              onChanged: (text) {
                newUser.personName = text;
              },
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'How you want to be addressed',
              ),
            ),
            TextFormField(
              initialValue: user.mobileNo,
              maxLength: 30,
              keyboardType: TextInputType.phone,
              onChanged: (mobileNo) {
                newUser.mobileNo = mobileNo;
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
                newUser.bankAccNo = accNo;
              },
              initialValue: user.bankAccNo,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.account_balance_wallet),
                labelText: 'Bank Account Number',
                hintText: '123 4567 890',
              ),
            ),
            TextFormField(
              maxLength: 150,
              onChanged: (bio) {
                newUser.bio = bio;
              },
              initialValue: user.bio,
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
        sqlUpdateUser(newUser);
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
*/