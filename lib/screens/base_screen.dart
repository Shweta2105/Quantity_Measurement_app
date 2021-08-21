import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  @override
  BaseScreenState createState() => new BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(context),
    );
  }

  getAppBar() {}

  Widget getBody(BuildContext context) {
    return Text('Page not implemented');
  }
}
