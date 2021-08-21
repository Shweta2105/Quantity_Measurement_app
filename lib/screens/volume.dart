// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'base_screen.dart';

class Volume extends BaseScreen {
  @override
  VolumeState createState() => new VolumeState();
}

class VolumeState extends BaseScreenState {
  String nameUnit = "";
  @override
  void initState() {
    super.initState();
  }

  final List<String> _measures = ['cubicmtrs', 'litres', 'galons'];
  final Map<String, int> _measureMap = {
    'cublicmtrs': 0,
    'litres': 1,
    'galons': 2
  };
  dynamic _formulas = {
    0: [1.0, 1000.0, 264.172],
    1: [0.001, 1.0, 0.264172],
    2: [0.00378, 3.78541, 1.0]
  };
  late double _userInput;
  var _startMeasureVolume;
  var _convertVolume;
  var _resultMessage;

  void convert(double value, String from, String to) {
    int? nFrom = _measureMap[from];
    print('${nFrom}');
    int? nTo = _measureMap[to];
    print('${nTo}');

    var multi = _formulas[nFrom.toString()][nTo];
    var result = value * multi;

    _resultMessage = '${result.toString()}';
    print('${_resultMessage}');
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
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
    return SingleChildScrollView(
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
                  InkWell(
                    onTap: () => {Navigator.pushNamed(context, '/length')},
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
                                child: Image.asset('assets/Images/scale.png'),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(top: 80, left: 15),
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
                  InkWell(
                    onTap: () => {Navigator.pushNamed(context, '/temperature')},
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
                                child: Image.asset('assets/Images/hot.png'),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(top: 82, left: 15),
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
                              child: Image.asset('assets/Images/volume.png'),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 30, right: 20, top: 78),
                                child: Text('Volume',
                                    style: TextStyle(
                                        color: HexColor('#0EC098'),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)))
                          ],
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
                            _userInput = input;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                        ),
                        hintText: '1',
                        hintStyle: TextStyle(fontSize: 15, color: Colors.black),
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
                    child: Text((_resultMessage == null) ? '' : _resultMessage,
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
                    hint: Text('galon',
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
                    value: _startMeasureVolume,
                    onChanged: (newValueSelected) {
                      setState(() {
                        this._startMeasureVolume = newValueSelected;
                      });
                    },
                    items: _measures.map((valueItem) {
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
                    hint: Text('galon',
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
                    value: _convertVolume,
                    onChanged: (newValueSelected) {
                      setState(() {
                        this._convertVolume = newValueSelected;
                        print('$_convertVolume');
                      });
                    },
                    items: _measures.map((valueItem) {
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
                  convert(_userInput, _startMeasureVolume, _convertVolume);
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
    );
  }
}
