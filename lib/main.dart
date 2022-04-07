import 'package:flutter/material.dart';
import 'package:joystick/joystick.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Pad Ee',
      home: HomePage(),
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
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Joystick(
              size: 100,
              isDraggable: true,
              iconColor: Colors.amber,
              backgroundColor: Colors.black,
              opacity: 0.5,
              joystickMode: JoystickModes.all,
              onUpPressed: () {},
              onLeftPressed: () {},
              onRightPressed: () {},
              onDownPressed: () {},
              onPressed: (_direction) {
                // print("pressed $_direction");
              }),
        ));
  }
}
