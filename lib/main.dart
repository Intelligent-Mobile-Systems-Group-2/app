//@dart=2.9
import 'package:flutter/material.dart';

import 'package:int_app/src/app/bluetooth/MainPage.dart';

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
          home: MainPage()),
    );
  }
}
