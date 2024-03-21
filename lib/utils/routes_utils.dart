import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ClockPage(),
        ),
      ),
    );
  }
}

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  ClockModel _clockModel;
  DateTime _dateTime = DateTime.now();
  String _temperature = '';

  @override
  void initState() {
    super.initState();
    _clockModel = ClockModel();
    _updateTime();
    _updateTemperature();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
    });
  }

  void _updateTemperature() async {
    final newTemperature = await _clockModel.getTemperature();
    setState(() {
      _temperature = newTemperature;
    });
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hms().format(DateTime.now());
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontSize: 48.0,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Temperature: $_temperature',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
