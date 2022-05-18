//@dart=2.9
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:int_app/src/app/view/bluetooth/MainPage.dart';
import 'package:int_app/src/app/view/home/joystick.dart';
import 'package:int_app/src/app/view/home/stop&startButton.dart';
import 'dart:async';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'main',
//      home: BluetoothView(),
      home: MainPage(),
    );
  }
}
