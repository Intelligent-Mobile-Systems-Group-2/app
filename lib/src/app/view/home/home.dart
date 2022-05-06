
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../Canvas.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          // Inner yellow container
          child: Container(
            // pass double.infinity to prevent shrinking of the painter area to 0.
            width: double.infinity,
            height: double.infinity,
            color: Colors.yellow,
            child: CustomPaint(painter: MowerMap()),
          ),
      )
    );

  }
}
