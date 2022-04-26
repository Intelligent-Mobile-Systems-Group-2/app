import 'package:flutter/material.dart';
import 'package:control_pad/views/joystick_view.dart';

import 'package:int_app/src/app/view/bluetooth-view/bluetoothBody.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Pad Ee', home: FindDevicesScreen(),
//      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control Pad Ee'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          JoystickView(size: 200),
        ],
      ),
    );
  }
}
