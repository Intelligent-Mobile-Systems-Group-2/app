import 'package:flutter/material.dart';
import 'package:control_pad/views/joystick_view.dart';

class JoyPad extends StatefulWidget {
  @override
  _JoyPadState createState() => _JoyPadState();
}

class _JoyPadState extends State<JoyPad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home")),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          JoystickView(
            onDirectionChanged: (double degree, double distance) {
              double data = degreeTranslater(degree);
              print(
                  "degrees: ${degree.toStringAsFixed(2)} distance: ${distance.toStringAsFixed(2)} sin: ${data.toStringAsFixed((2))} ");
            },
          ),
        ],
      )),
    );
  }
}

double degreeTranslater(double degree) {
  if (degree > 0 && degree < 90) {
    return (degree / 90);
  }

  if (degree > 90 && degree < 180) {
    return ((90 - (degree - 90)) / 90);
  }

  if (degree > 180 && degree < 270) {
    return -((degree - 180) / 90);
  }

  if (degree > 270 && degree < 360) {
    return -((270 - (degree - 90)) / 90);
  }

  return 0;
}
