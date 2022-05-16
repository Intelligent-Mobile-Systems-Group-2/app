import 'package:flutter/material.dart';
import 'package:control_pad/views/joystick_view.dart';
import 'package:int_app/src/app/view/home/stop&startButton.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:int_app/src/app/view/bluetooth/ChatPage.dart';

class HomePage extends StatelessWidget {
  late ChatPage _chatPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 450),
          LiteRollingSwitch(
            value: true,
            textOn: 'Auto',
            textOff: 'Remote',
            colorOn: Colors.green,
            colorOff: Colors.grey,
            iconOn: Icons.power_settings_new,
            iconOff: Icons.power_settings_new,
            onChanged: (bool state) {
              print('Switch turned ${(state) ? 'on' : 'off'}');
            },
          ),
          JoystickView(
            size: 300,
          ),
        ],
      ),
    );
  }
}
