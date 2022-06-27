// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'navbar.dart';

class CausesPage extends StatelessWidget {
  const CausesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Causes', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 80.0,
                width: 330.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.amber,
                      primary: Colors.white,
                      textStyle: TextStyle(fontSize: 30.0)),
                  onPressed: () {},
                  child: Text('Food'),
                )),
            SizedBox(
                height: 80.0,
                width: 330.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 30.0),
                  ),
                  onPressed: () {},
                  child: Text('Healthcare'),
                )),
            SizedBox(
                height: 80.0,
                width: 330.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 30.0),
                  ),
                  onPressed: () {},
                  child: Text('Resources'),
                )),
            SizedBox(
                height: 80.0,
                width: 330.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 30.0),
                  ),
                  onPressed: () {},
                  child: Text('Housing'),
                )),
            SizedBox(
                height: 80.0,
                width: 330.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 30.0),
                  ),
                  onPressed: () {},
                  child: Text('Education'),
                )),
            SizedBox(
                height: 80.0,
                width: 330.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 30.0),
                  ),
                  onPressed: () {},
                  child: Text('Others'),
                )),
          ],
        ),
      ),
      bottomNavigationBar: buildNavBar(context),
    );
  }
}
