import 'package:auxilium/community_page.dart';
import 'package:auxilium/create%20post/resource_create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'create post/money_create_post.dart';
import 'package:auxilium/payment.dart';

// From NAVBAR -> Create Post
// Money or Resource?
resourceTypePostAlert(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('Are you donating/requesting Money or Resources?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateMoneyPost(user, googleSignIn)));
          },
          child: const Text('Money'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateResourcePost(user, googleSignIn)));
          },
          child: const Text('Resource'),
        )
      ],
    ),
  );
}

final paymentCntroller = Get.put(PaymentController()); // payment link

paymentAmtAlert(
    BuildContext context, GoogleSignInAccount user, GoogleSignIn googleSignIn) {
  String tempAmount = '0';

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
              child: Text(
            'how much will you be donating?',
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
                padding: EdgeInsets.fromLTRB(110, 3, 45, 3),
                child: Text('\$',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ))),
            border: InputBorder.none,
          ),
          initialValue: tempAmount.toString(),
          validator: (String amount) {
            return (amount != null)
                ? 'Enter a donation greater than \$0.'
                : null;
          },
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (String amount) {
            tempAmount = amount;
          },
          autofocus: true,
        )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      paymentCntroller.makePayment(
                          amount: tempAmount, currency: 'USD');
                    },
                    child: const Text(
                      'submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ]))
      ]);
    },
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