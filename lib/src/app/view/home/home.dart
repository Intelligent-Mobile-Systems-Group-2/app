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
    DrawModel(const Offset(50, 50)),
    DrawModel(const Offset(100, 60)),
    DrawModel(const Offset(100, 60)),
    DrawModel(const Offset(100, 90)),
    DrawModel(const Offset(50, 80)),
    DrawModel(const Offset(-50, 30))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("home"),
        ),
        body: Container(
          color: Colors.white,
          // Inner yellow container
          child: Center(
              child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: CustomPaint(
              painter: MowerMap(pointsList),
            ),
          )),
        ));
  }
}
