import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:ims/src/app/bluetooth/bluetooth_controller.dart';
import 'package:ims/src/app/bluetooth/controllers/robot_controller.dart';
import 'package:ims/src/app/bluetooth/bluetooth_characteristics.dart';

class RobotController extends BluetoothController {
  RobotInteractor _interactor;

  StreamSubscription<List<int>> _collissionSubscription;
  late StreamController<int> _collissionController = StreamController<int>();

  RobotController(this._interactor) : super(_interactor) {}

  Future<void> setAcceleration(int acceleration) {
    return this._interactor.write(Guid(ROBOT_ACCELERATION_UUID), [acceleration.toInt()]);
  }

  Future<void> setSteering(int steering) {
    return this._interactor.write(Guid(ROBOT_STEERING_UUID), [steering.toInt()]);
  }

  Future<void> setAutoMode() {
    return this._interactor.write(Guid(ROBOT_MODE_UUID), [0]);
  }

  Future<bool> startCollission() async {
    return this._interactor.setNotifyValue(Guid(ROBOT_COLLISION_UUID), true);
  }

  Future<bool> stopCollission() async {
    _collissionSubscription?.cancel();
    return this._interactor.setNotifyValue(Guid(ROBOT_COLLISION_UUID), false);
  }

  Stream<int> collissionResults() {
    _collissionSubscription = this._interactor.value(Guid(ROBOT_COLLISION_UUID)).listen((event) {
      if (event.isNotEmpty) _collissionController.add(event.first);
    });

    return _collissionController.stream.asBroadcastStream();
  }
}