import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_helloworld_app/screens/base_screen.dart';
import 'package:simple_helloworld_app/screens/temperature.dart';
import 'package:simple_helloworld_app/screens/volume.dart';

class Home extends BaseScreen {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends BaseScreenState {
  String nameUnit = "";

  final List<String> _measureLength = [
    'Milimeters',
    'Centimeters',
    'Meters',
    'Kilometers',
    'Feets',
    'Inches',
    'Miles'
  ];

  final Map<String, int> _measureMap = {
    'Milimeters': 0,
    'Centimeters': 1,
    'Meters': 2,
    'Kilometers': 3,
    'Feets': 4,
    'Inches': 5,
    'Miles': 6,
  };
  dynamic _formulas = {
    0: [1.0, 0.1, 0.001, 0.000001, 0.00328, 0.0394, 0.00000062137],
    1: [10.0, 1.0, 0.01, 0.00001, 0.0328, 0.394, 0.0000062137],
    2: [1000.0, 100.0, 1.0, 0.001, 3.28, 39.37, 0.00062137],
    3: [1000000.0, 100000.0, 1000.0, 1.0, 3280.84, 39370.1, 0.62137],
    4: [304.8, 30.48, 0.3048, 0.0003048, 1.0, 12.0, 0.00018940],
    5: [25.4, 2.54, 0.0254, 0.0000254, 0.0833, 1.0, 0.000015783],
    6: [1609344.0, 160934.4, 1609.344, 1.609344, 5280.0, 63360.0]
  };

  late double _userInput;
  var _startMeasureLength;
  var _convertLength;
  var _resultMessage;

  void iniState() {
    _userInput = 0;
    super.initState();
  }

  @override
  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: HexColor("#446DFF"),
      title: Text(
        'Welcome to Quantity Measurement',
        style: TextStyle(fontSize: 20.0, color: HexColor("#FFFFFF")),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(42.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Title(
                                color: HexColor("#000000"),
                                // ignore: prefer_const_constructors
                                // ignore: unnecessary_new
                                child: Text('Choose Type',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: HexColor("#000000"),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)))),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Card(
                              color: HexColor("#FFFFFF"),
                              elevation: 5.0,
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Image.asset(
                                          'assets/Images/Length1.png'),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 30, right: 20, top: 78),
                                        child: Text('Length',
                                            style: TextStyle(
                                                color: HexColor('#0EC098'),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                {Navigator.pushNamed(context, '/temperature')},
                            child: Container(
                              child: Card(
                                color: HexColor("#FFFFFF"),
                                elevation: 5.0,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.asset(
                                            'assets/Images/temperatureBW.png'),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              top: 80, left: 15),
                                          child: Text('Temperature',
                                              style: TextStyle(
                                                  color: HexColor('#919090'),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                {Navigator.pushNamed(context, '/volume')},
                            child: Container(
                              child: Card(
                                color: HexColor("#FFFFFF"),
                                elevation: 5.0,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.asset(
                                            'assets/Images/beaker.jpg'),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              top: 80, left: 30),
                                          child: Text('Volume',
                                              style: TextStyle(
                                                  color: HexColor('#919090'),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 20,
                          width: 160,
                          child: Text('FROM',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: HexColor("#919090"),
                                fontSize: 12,
                              )),
                        ),
                        Container(
                          height: 20,
                          width: 160,
                          child: Text('TO',
                              style: TextStyle(
                                color: HexColor("#919090"),
                                fontSize: 12,
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Container(
                            height: 40,
                            width: 160,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                var input = double.tryParse(text);
                                if (input != null) {
                                  setState(() {
                                    _userInput = input;
                                  });
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                hintText: '1',
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 11, 0, 0),
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                                border: Border.all(color: HexColor("#919090"))),
                            child: Text(
                                (_resultMessage == null) ? '' : _resultMessage,
                                style: TextStyle(
                                  color: HexColor("#000000"),
                                  fontSize: 15,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                              border: Border.all(color: HexColor("#919090"))),
                          child: DropdownButton(
                            hint: Text('Meters',
                                style: TextStyle(
                                  color: HexColor('#000000'),
                                  fontSize: 12,
                                )),
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            isExpanded: true,
                            underline: SizedBox(),
                            style: TextStyle(
                              color: HexColor('#000000'),
                              fontSize: 12,
                            ),
                            value: _startMeasureLength,
                            onChanged: (newValueSelected) {
                              setState(() {
                                this._startMeasureLength = newValueSelected;
                              });
                            },
                            items: _measureLength.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                              border: Border.all(color: HexColor('#919090'))),
                          child: DropdownButton(
                            hint: Text('Meters',
                                style: TextStyle(
                                  color: HexColor('#000000'),
                                  fontSize: 12,
                                )),
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            isExpanded: true,
                            underline: SizedBox(),
                            style: TextStyle(
                              color: HexColor('#000000'),
                              fontSize: 12,
                            ),
                            value: _convertLength,
                            onChanged: (newValueSelected) {
                              setState(() {
                                this._convertLength = newValueSelected;
                              });
                            },
                            items: _measureLength.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        Convert(
                            _userInput, _startMeasureLength, _convertLength);
                      },
                      child: Container(
                          alignment: AlignmentDirectional.center,
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: HexColor('#446DFF'),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Convert',
                            style: TextStyle(
                                fontSize: 15,
                                color: HexColor('#FFFFFF'),
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ))));
  }

  // ignore: non_constant_identifier_names
  void Convert(double value, String From, String To) {
    print("Hello");
    int? numFrom = _measureMap[From];
    int? numTo = _measureMap[To];
    var formulaMultiple = _formulas[numFrom.toString()][numTo];
    var result = value * formulaMultiple;

    _resultMessage = '${result.toString()}';

    setState(() {
      _resultMessage = _resultMessage;
    });
  }
}
