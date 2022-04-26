import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:int_app/src/app/bluetooth/interactors/robot_interactor.dart';
import '../../../util/bluetooth_characteristics.dart';
import '../bluetooth_controller.dart';

class RobotController extends BluetoothController {
  final RobotInteractor _interactor;

  StreamSubscription<List<int>>? _collisionSubscription;
  late StreamController<int> _collisionController = StreamController<int>();

  RobotController(this._interactor) : super(_interactor) {}

  Future<void> setAcceleration(int acceleration) {
    return _interactor.write(Guid(ROBOT_ACCELERATION_UUID), [acceleration]);
  }

  Future<void> setSteering(int steering) {
    return _interactor.write(Guid(ROBOT_STEERING_UUID), [steering]);
  }

  Future<void> setAutomode() {
    return _interactor.write(Guid(ROBOT_MODE_UUID), [0]);
  }

  /*Future<bool> startCollision() async {
    return _interactor.setNotifyValue(Guid(ROBOT_COLLISION_UUID), true);
  }*/

  /*Future<bool> stopCollision() async {
    _collisionSubscription?.cancel();
    return _interactor.setNotifyValue(Guid(ROBOT_COLLISION_UUID), false);
  }*/

  /*Stream<int> collisionResults() {
    _collisionSubscription =
        _interactor.value(Guid(ROBOT_COLLISION_UUID)).listen((event) {
      if (event.isNotEmpty) _collisionController.add(event.first);
    });

    return _collisionController.stream.asBroadcastStream();
  }*/
}
