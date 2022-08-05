import 'package:auxilium/create%20post/resource_create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'create post/money_create_post.dart';
import 'package:auxilium/payment.dart';

// From Create Post
// (1) Request or Donation?
reqDonPostAlert(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Will you be making a Donation or Request?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => resourceTypePostAlert(
                    context, user, googleSignIn, 'Donation')));
          },
          child: const Text('Donation'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => resourceTypePostAlert(
                    context, user, googleSignIn, 'Request')));
          },
          child: const Text('Request'),
        )
      ],
    ),
  );
}

// From Create Post
// (2) Money or Resource?
resourceTypePostAlert(BuildContext context, GoogleSignInAccount user,
    GoogleSignIn googleSignIn, String donReqType) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Is this a monetary or resource $donReqType?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CreateMoneyPost(user, googleSignIn, donReqType)));
          },
          child: const Text('Monetary'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CreateResourcePost(user, googleSignIn, donReqType)));
          },
          child: const Text('Resources'),
        )
      ],
    ),
  );
}

// From Community Post Viewer
reqDonContributionAlert(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Will you be making a Donation or Request?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => resourceTypePostAlert(context, user,
                    googleSignIn, 'Donation'))); // *** EDIT ACCORDINGLY ***
          },
          child: const Text('Donation'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    paymentAmtAlert(context, user, googleSignIn)));
          },
          child: const Text('Request'),
        )
      ],
    ),
  );
}

final paymentCntroller = Get.put(PaymentController()); // payment link

paymentAmtAlert(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  String tempAmount;
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoTextFormFieldRow(
      prefix: const Text('How much will you be donating?'),
      validator: (String amount) {
        return (amount != null) ? 'Enter a donation greater than \$0.' : null;
      },
      placeholder: "USD\$123.45",
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onFieldSubmitted: (String amount) {
        tempAmount = amount;
        paymentCntroller.makePayment(amount: tempAmount, currency: 'USD');
      },
    ),
  );
}

/* Alert dialog with  Column(children: [Text('what will you be contributing?'),

// Resource Name
TextFormField(
                style: const TextStyle(fontSize: 18),
                maxLength: 50,
                onChanged: (resource) {
                  tempResource = resource;
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
                  labelText: 'Resource',
                  hintText: 'input item name here',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
                ),
              ),

              // *** Quantity input ***

              // Item Description
              TextFormField(
                style: const TextStyle(fontSize: 18),
                maxLength: 50,
                onChanged: (resource) {
                  tempDescription = description;
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
                  labelText: 'Description',
                  hintText: 'input description here',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 65, 82, 31)),
                ),
              ),
              
              // Collection Date Picker

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

              // *** Submit Button ***

              ]
              */