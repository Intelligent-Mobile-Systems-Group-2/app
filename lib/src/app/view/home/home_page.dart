import 'package:flutter/material.dart';
import 'package:control_pad/views/joystick_view.dart';
import 'package:int_app/src/app/view/home/map.dart';

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
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapState()));
                },
                child: const Text("Go To Map")),
            SizedBox(height: 25),
            JoystickView(size: 200)
          ]),
    );
  }
}
