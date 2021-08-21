import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'base_screen.dart';

class Temperature extends BaseScreen {
  @override
  TemperatureState createState() => TemperatureState();
}

class TemperatureState extends BaseScreenState {
  final List<String> _measureTemperature = ['Celsius', 'Fahrenheit', 'Kelvin'];
  late double _userInput;
  var _startMeasureTemperature;
  var _convertTemperature;
  var _resultMessage;
  final Map<String, int> _measureMap = {
    'Celsius': 0,
    'Fahrenheit': 1,
    'Kelvin': 2
  };
  dynamic _formulas = {
    0: [1.0, 57.6, 273.15],
    1: [-31.444, 1.0, 290.928],
    2: [-273.15, 33.8, 1.0]
  };

  void Convert(double value, String from, String to) {
    if (from == 'Celsius' && to == 'Fahrenheit') {
      var result = value * 1.8 + 32.0;
      _resultMessage = '${result.toString()}';
    } else if (from == 'Celsius' && to == 'Kelvin') {
      var result = value + 273.15;
      _resultMessage = '${result.toString()}';
    } else if (from == 'Fahrenheit' && to == 'Celsius') {
      var result = (value - 32.0) / 1.8;
      _resultMessage = '${result.toString()}';
    } else if (from == 'Fahrenheit' && to == 'Kelvin') {
      var result = (value + 459.67) * (5.0 / 9.0);
      _resultMessage = '${result.toString()}';
    } else if (from == 'Kelvin' && to == 'Celsius') {
      var result = value - 273.15;
      _resultMessage = '${result.toString()}';
    } else if (from == 'Kelvin' && to == 'Fahrenheit') {
      var result = value * (9.0 / 5.0) - 459.67;
      _resultMessage = '${result.toString()}';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  void initState() {
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
                                color: HexColor("#000000"),
                                // ignore: prefer_const_constructors
                                // ignore: unnecessary_new
                                child: Text('Choose Type',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: HexColor("#000000"),
                                      fontSize: 14,
                                    )))),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () =>
                                {Navigator.pushNamed(context, '/length')},
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
                                            'assets/Images/scale.png'),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              top: 80, left: 15),
                                          child: Text('Length',
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
                                          'assets/Images/hotColor.png'),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 14, right: 14, top: 82),
                                        child: Text('Temperature',
                                            style: TextStyle(
                                                color: HexColor('#0EC098'),
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                {Navigator.pushNamed(context, '/volume')},
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
                                        child: Image.asset(
                                            'assets/Images/volumeBW.png'),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
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
                          ),
                        ]),
                    const SizedBox(
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
                            hint: Text('Celsius',
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
                            value: _startMeasureTemperature,
                            onChanged: (newValueSelected) {
                              setState(() {
                                this._startMeasureTemperature =
                                    newValueSelected;
                              });
                            },
                            items: _measureTemperature.map((valueItem) {
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
                            hint: Text('Celsius',
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
                            value: _convertTemperature,
                            onChanged: (newValueSelected) {
                              setState(() {
                                this._convertTemperature = newValueSelected;
                              });
                            },
                            items: _measureTemperature.map((valueItem) {
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
                        Convert(_userInput, _startMeasureTemperature,
                            _convertTemperature);
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
}
