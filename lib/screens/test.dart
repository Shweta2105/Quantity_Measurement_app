import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_screen.dart';

class Test extends BaseScreen {
  @override
  TestState createState() => TestState();
}

class TestState extends BaseScreenState {
  void iniState() {
    super.initState();
  }
}

Widget getAppBar() {
  return AppBar(
    backgroundColor: Color(1),
    // ignore: prefer_const_constructors
    title: Text(
      'Welcome',
      style: const TextStyle(fontSize: 12, color: Color(8)),
    ),
  );
}

Widget getBody() {
  return Center(
    child: Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          splashColor: Colors.blueAccent,
          child: Card(
            margin: EdgeInsets.only(top: 20, bottom: 30, left: 5, right: 5),
            child: Image.asset(
              'assets\Images\beaker.png',
              alignment: Alignment.center,
            ),
          ),
        )
      ],
    )),
  );
}
