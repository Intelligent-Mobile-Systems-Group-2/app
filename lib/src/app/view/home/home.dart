import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../Canvas.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Size size = WidgetsBinding.instance!.window.physicalSize;

  List<DrawModel> pointsList = [
    DrawModel(const Offset(0, 0)),
    DrawModel(const Offset(100, 50)),
    DrawModel(const Offset(500, 1000))
  ];

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
          child: ClipRect(
            child: CustomPaint(
              painter: MowerMap(pointsList),
              size: Size(size.width, size.height),
            ),
          ),
        ));
  }
}
