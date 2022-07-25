import 'package:auxilium/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_button.dart';
import 'navbar.dart';

class CausesPage extends StatelessWidget {
  final GoogleSignInAccount user;
  final GoogleSignIn googleSignIn;
  final List<Cause> causeList = const [
    Cause(Icon(Icons.fastfood), 'Food',
        'A meal, cooking ingredients, canned food...', 1234),
    Cause(Icon(Icons.local_hospital), 'Healthcare',
        'Medical bills, medication, first-aid...', 2345),
    Cause(Icon(Icons.house), 'Space',
        'Rooms, working areas, facilities, housing...', 4567),
    Cause(Icon(Icons.handyman), 'Utilities',
        'Washing machine, cooking utensils, tools', 4567),
    Cause(Icon(Icons.checkroom), 'Clothes',
        'Second-hand or new clothing, shoes, pants...', 123),
    Cause(Icon(Icons.school), 'Education',
        'Tuition, textbooks,  uniform, stationary...', 3456),
    Cause(Icon(Icons.more_horiz), 'Others', 'Miscellaneous', 45678)
  ];

  CausesPage(this.user, this.googleSignIn, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentCntroller = Get.put(PaymentController()); // payment link
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 168, 159, 104),
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('causes',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 82, 31), fontSize: 28)),
          backgroundColor: const Color.fromARGB(255, 245, 253, 198),
          leading: homeButton(context, user, googleSignIn)),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        itemCount: causeList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () =>
                  paymentCntroller.makePayment(amount: '5', currency: 'USD'),
              leading: causeList[index].icons,
              title: Text(
                causeList[index].category,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                "${causeList[index].numPost} Posts",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: buildNavBar(context, user, googleSignIn),
    );
  }
}

class Cause {
  final Widget icons;
  final String category;
  final String about;
  final int numPost;
  const Cause(this.icons, this.category, this.about, this.numPost);

  @override
  String toString() {
    return "Cause $category with $numPost Posts";
  }
}
