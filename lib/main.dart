import 'package:flutter/material.dart';
import 'package:control_pad/views/joystick_view.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:int_app/src/app/view/home/joystick.dart';
import 'package:int_app/src/app/view/http/http.dart';
import 'src/app/view/http/http.dart';

Future<void> main() async {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'main',
//      home: BluetoothView(),
      home: HttpView(),
    );
  }
}
