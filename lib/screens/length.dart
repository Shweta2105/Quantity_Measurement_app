import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'base_screen.dart';

class Length extends BaseScreen {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends BaseScreenState {
  String nameUnit = "";

  final List<String> measures = [
    'Meter',
    'Kilometer',
    'Centimeter',
    'Milimeter',
    'Micrometers',
    'Mile',
    'Foot',
    'Inch'
  ];
  final Map<String, int> measuresMap = {
    'Meter': 0,
    'Kilometer': 1,
    'Centimeter': 2,
    'Milimeter': 3,
    'Micrometers': 4,
    'Mile': 5,
    'Foot': 6,
    'Inch': 7
  };

  dynamic formulas = {
    '0': [1, 0.001, 100, 1000, 1000000, 0.000621371, 3.28084, 39.3701],
    '1': [1000, 1, 100000, 1000000, 1000000000, 0.621371, 3280.84, 39370.1],
    '2': [0.01, 0.00001, 1, 10, 10000, 0.0000062137, 0.0328084, 0.393701],
    '3': [0.001, 0.000001, 0.1, 1, 1000, 0.00000062137, 0.00328084, 0.0393701],
    '4': [
      0.000001,
      0.000000001,
      0.0001,
      0.001,
      1,
      0.00000000062137,
      0.0000032808,
      0.0000393701
    ],
    '5': [1609.34, 1.60934, 160934, 1609350, 1609350000, 1, 5280, 63360],
    '6': [0.3048, 0.0003048, 30.48, 304.8, 304800, 0.000189394, 1, 12],
    '7': [0.0254, 0.0000254, 2.54, 25.4, 25400, 0.0000157828, 0.0833333, 1]
  };

  void convert(double value, String from, String to) {
    int? nFrom = measuresMap[from];
    int? nTo = measuresMap[to];
    var multi = formulas[nFrom.toString()][nTo];
    var result = value * multi;

    resultMessage = '${result.toString()}';
    print('${resultMessage}');
    setState(() {
      resultMessage = resultMessage;
    });
  }

  var _startMeasures;
  var _convertedMeasures;
  var resultMessage;

  @override
  void initState() {
    userInput = 0;
    super.initState();
  }

  late double userInput;

  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: HexColor('#446DFF'),
      title: Text(
        'Welcome to quantity measurement',
        style: TextStyle(fontSize: 20.0, color: HexColor('#FFFFFF')),
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
                          color: HexColor('#000000'),
                          child: Text("Choose Type",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: HexColor('#000000'),
                                fontSize: 14,
                              )))),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                  Widget>[
                Container(
                  child: Card(
                    color: HexColor('#FFFFFF'),
                    elevation: 5.0,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset('assets/Images/scale.png'),
                          ),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 30, right: 20, top: 82),
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
                  onTap: () => {Navigator.pushNamed(context, '/temperature')},
                  child: Container(
                    child: Card(
                      color: HexColor('#FFFFFF'),
                      elevation: 5.0,
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset('assets/Images/hot.png'),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 82, left: 15),
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
                  onTap: () => {Navigator.pushNamed(context, '/volume')},
                  child: Container(
                    child: Card(
                      color: HexColor('#FFFFFF'),
                      elevation: 5.0,
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset('assets/Images/volumeBW.png'),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 82, left: 30),
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
                ),
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
                          color: HexColor('#919090'),
                          fontSize: 12,
                        )),
                  ),
                  Container(
                    height: 20,
                    width: 160,
                    child: Text('TO',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: HexColor('#919090'),
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
                      //decoration: BoxDecoration(
                      //border: Border.all(color: HexColor('#E7DCFE'))),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        //padding: EdgeInsets.fromLTRB(10, 11, 0, 0),
                        //textAlign: TextAlign.left,
                        onChanged: (text) {
                          var input = double.tryParse(text);
                          if (input != null) {
                            setState(() {
                              userInput = input;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                          ),
                          hintText: '1',
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
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
                          border: Border.all(color: HexColor('#919090'))),
                      child: Text((resultMessage == null) ? '' : resultMessage,
                          style: TextStyle(
                            color: HexColor('#000000'),
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
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#919090'))),
                    child: DropdownButton(
                      hint: Text('Meter',
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
                      value: _startMeasures,
                      onChanged: (newValueSelected) {
                        setState(() {
                          _startMeasures = newValueSelected;
                        });
                      },
                      items: measures.map((valueItem) {
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
                      hint: Text('Centimeter',
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
                      value: _convertedMeasures,
                      onChanged: (newValueSelected) {
                        setState(() {
                          this._convertedMeasures = newValueSelected;
                          //print($_convertedMeasures);
                        });
                      },
                      items: measures.map((valueItem) {
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
                    convert(userInput, _startMeasures, _convertedMeasures);
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
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
