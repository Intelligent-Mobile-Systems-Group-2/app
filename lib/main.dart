//@dart=2.9
import 'package:flutter/material.dart';

import 'package:control_pad/views/joystick_view.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:int_app/src/app/view/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get_it/get_it.dart';
import 'package:int_app/src/app/view/home/joystick.dart';
import 'package:int_app/src/app/view/http/http.dart';
import 'dart:async';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'main',
//      home: BluetoothView(),
          home: HomePage()),
    );
  }
}
