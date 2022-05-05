//@dart=2.9
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:int_app/src/app/view/bluetooth/bluetooth_view.dart';
import 'src/app/bluetooth/bluetooth_device_manager.dart';
import 'src/app/bluetooth/interactors/robot_interactor.dart';
import 'src/app/bluetooth/controllers/robot_controller.dart';
import 'src/app/bluetooth/bluetooth_discover_manager.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton(BluetoothDiscoverManager());
  getIt.registerSingleton(
      BluetoothDeviceManager<RobotInteractor, RobotController>());
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'main',
      home: BluetoothView(),
    );
  }
}
