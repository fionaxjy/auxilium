import 'package:auxilium/login.dart';
import 'package:auxilium/my_account.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CreateUser extends StatelessWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const CreateUser(this.user, this.googleSignIn, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 168, 159, 104),
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('create user',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextFormField(
              initialValue: user.displayName,
              maxLength: 30,
              onChanged: (text) {
                // ADD
                // FirebaseName = text;
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
              maxLength: 30,
              keyboardType: TextInputType.phone,
              onChanged: (mobileNo) {
                // ADD
                //FirebaseMobile = mobileNo as int;
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
              maxLength: 17,
              keyboardType: TextInputType.number,
              onChanged: (accNo) {
                // ADD
                // FirebaseBankNo = accNo as int;
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
                hintText: '123 4567 890',
                labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
              ),
            ),
            TextFormField(
              maxLength: 150,
              onChanged: (bio) {
                // ADD
                // FirebaseBio = bio;
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 238, 238, 238),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MyAccountPage(user, googleSignIn)));
                  },
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
                  ))
            ]),
          ],
        ),
      ),
    );
  }
}
