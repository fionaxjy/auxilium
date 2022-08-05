import 'package:auxilium/my_account_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class CreateUser extends StatefulWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;

  const CreateUser(this.user, this.googleSignIn, {Key key}) : super(key: key);

  @override
  CreateUserState createState() => CreateUserState();
}

class CreateUserState extends State<CreateUser> {
  int stateNo = 1; // Name, Mobile, Bank, Bio
  String tempName = '';
  String tempMobile = '';
  String tempBank = '';
  String tempBio = '';

  Widget cancelNextButton(BuildContext context, GoogleSignInAccount user,
      GoogleSignIn googleSignIn) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (stateNo > 1) {
                  stateNo--;
                } else {
                  stateNo == 1;
                }
              });
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: stateNo == 1 ? Colors.grey : Colors.black,
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () async {
              if (stateNo < 4) {
                setState(() {
                  stateNo++;
                });
              } else {
                await usersRef.doc(user.id).set({
                  "name": tempName,
                  "mobileNo": tempMobile,
                  "bankAccNo": tempBank,
                  "bio": tempBio,
                  "dp": user.photoUrl,
                }).then((value) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyAccountPage(user, googleSignIn))));
              }
            },
            label: stateNo == 4
                ? const Text('Let\'s Go!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                : const Text(''),
            icon: stateNo == 4
                ? const Icon(Icons.check, color: Colors.black)
                : const Icon(Icons.arrow_forward_ios),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 227, 196),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: const Text('create user',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 180),
            child: Text(
              'welcome to auxilium!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          checkStateNo(stateNo),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child:
                  cancelNextButton(context, widget.user, widget.googleSignIn))
        ],
      ),
    );
  }

  Widget checkStateNo(int n) {
    switch (n) {
      case 2:
        return enterMobile(widget.user);
        break;
      case 3:
        return enterBank(widget.user);
        break;
      case 4:
        return enterBio(widget.user);
        break;
      default:
        return enterName(context, widget.user, widget.googleSignIn);
        break;
    }
  }

  Widget enterName(BuildContext context, GoogleSignInAccount user,
      GoogleSignIn googleSignIn) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          const Text(
            'how should we address you?',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            key: Key(user.displayName),
            initialValue: tempName.isEmpty ? '' : tempName,
            style: const TextStyle(fontSize: 18),
            maxLength: 30,
            onChanged: (name) {
              tempName = name;
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
                labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31))),
          ),
        ]));
  }

  Widget enterMobile(GoogleSignInAccount user) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'your mobile number would be used for authentication purposes.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: tempMobile.isEmpty ? '' : tempMobile,
                style: const TextStyle(fontSize: 18),
                maxLength: 30,
                keyboardType: TextInputType.phone,
                onChanged: (mobileNo) {
                  tempMobile = mobileNo;
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
                  hintText: '12345678',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
                ),
              ),
            ]));
  }

  Widget enterBank(GoogleSignInAccount user) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'your bank account number will be used to give and receive financial resources.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                key: const Key(null),
                initialValue: tempBank.isEmpty ? '' : tempBank,
                style: const TextStyle(fontSize: 18),
                maxLength: 16,
                keyboardType: TextInputType.number,
                onChanged: (accNo) {
                  tempBank = accNo;
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
            ]));
  }

  Widget enterBio(GoogleSignInAccount user) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'tell us a bit about yourself.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: tempBio.isEmpty ? '' : tempBio,
                style: const TextStyle(fontSize: 18),
                maxLength: 150,
                onChanged: (bio) {
                  tempBio = bio;
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
                  suffixIcon: Icon(Icons.person),
                  labelText: 'Bio',
                  hintText: 'About yourself',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
                ),
              ),
            ]));
  }
}
