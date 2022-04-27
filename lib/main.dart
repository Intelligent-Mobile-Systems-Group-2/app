import 'package:flutter/material.dart';
import 'package:control_pad/views/joystick_view.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';

import 'package:int_app/src/app/view-model/bluetooth_view_model.dart';
import 'package:int_app/src/app/view/bluetooth-view/bluetooth_view.dart';
import 'src/app/bluetooth/bluetooth_device_manager.dart';
import 'src/app/bluetooth/interactors/robot_interactor.dart';
import 'src/app/bluetooth/controllers/robot_controller.dart';
import 'src/app/bluetooth/bluetooth_discover_manager.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton(BluetoothDiscoverManager());
  getIt.registerSingleton(
      BluetoothDeviceManager<RobotInteractor, RobotController>());
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Pad', home: BluetoothView(),
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
