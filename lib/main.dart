import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';

import 'package:int_app/src/app/view-model/bluetooth_view_model.dart';
import 'package:int_app/src/app/view/bluetooth/bluetooth_view.dart';
import 'src/app/bluetooth/bluetooth_device_manager.dart';
import 'src/app/bluetooth/interactors/robot_interactor.dart';
import 'src/app/bluetooth/controllers/robot_controller.dart';
import 'src/app/bluetooth/bluetooth_discover_manager.dart';
import 'package:int_app/src/app/view/home/home_page.dart';

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
      title: 'main',
//      home: BluetoothView(),
      home: HomePage(),
    );
  }
}
