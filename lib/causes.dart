// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CausesPage extends StatelessWidget {
  const CausesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Causes', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  primary: Colors.white,
                ),
                onPressed: () {},
                child: Text('Food'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  primary: Colors.white,
                ),
                onPressed: () {},
                child: Text('Healthcare'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  primary: Colors.white,
                ),
                onPressed: () {},
                child: Text('Resources'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  primary: Colors.white,
                ),
                onPressed: () {},
                child: Text('Housing'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  primary: Colors.white,
                ),
                onPressed: () {},
                child: Text('Education'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  primary: Colors.white,
                ),
                onPressed: () {},
                child: Text('Others'),
              ),
            ],
          ),
          //bottomNavigationBar: BottomNavigationBar(
          //  items: [
          //    BottomNavigationBarItem(
          //      icon: Icon(Icons.home),
          //    )
          //  ],
          //  ),
        ));
  }
}
