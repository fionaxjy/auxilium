/*import 'package:auxilium/causes.dart';
import 'package:flutter/material.dart';

class SelectCause extends CausesPage {


  const SelectCause({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
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
}
*/