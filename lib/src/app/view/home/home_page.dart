import 'package:flutter/material.dart';
import 'package:control_pad/views/joystick_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
