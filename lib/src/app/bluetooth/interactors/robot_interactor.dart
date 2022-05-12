import 'package:flutter_blue/flutter_blue.dart';

import '../../../util/bluetooth_services.dart' as BLEServices;
import '../../../util/bluetooth_characteristics.dart' as BLECharacteristics;
import '../bluetooth_interactor.dart';
import '../bluetooth_resolver.dart';

class RobotInteractor extends BluetoothInteractor {
  factory RobotInteractor(List<BluetoothService> services) {
    final robotService =
        BluetoothResolver.findService(services, Guid(BLEServices.ROBOT_UUID))!;
    final robotAcceleration = BluetoothResolver.findCharacteristic(
        robotService, Guid(BLECharacteristics.ROBOT_ACCELERATION_UUID))!;
    final robotSteering = BluetoothResolver.findCharacteristic(
        robotService, Guid(BLECharacteristics.ROBOT_STEERING_UUID))!;
    final robotCollision = BluetoothResolver.findCharacteristic(
        robotService, Guid(BLECharacteristics.ROBOT_COLLISION_UUID))!;
    final robotMode = BluetoothResolver.findCharacteristic(
        robotService, Guid(BLECharacteristics.ROBOT_MODE_UUID))!;

    final servicesByUUID = Map<Guid, BluetoothService>();
    servicesByUUID[Guid(BLEServices.ROBOT_UUID)] = robotService;

    final characteristicsByUUID = Map<Guid, BluetoothCharacteristic>();
    characteristicsByUUID[Guid(BLECharacteristics.ROBOT_ACCELERATION_UUID)] =
        robotAcceleration;
    characteristicsByUUID[Guid(BLECharacteristics.ROBOT_STEERING_UUID)] =
        robotSteering;
    characteristicsByUUID[Guid(BLECharacteristics.ROBOT_COLLISION_UUID)] =
        robotCollision;
    characteristicsByUUID[Guid(BLECharacteristics.ROBOT_MODE_UUID)] = robotMode;

    return RobotInteractor._(servicesByUUID, characteristicsByUUID);
  }

  RobotInteractor._(Map<Guid, BluetoothService> serviceByUUID,
      Map<Guid, BluetoothCharacteristic> characteristicByUUID)
      : super(serviceByUUID, characteristicByUUID);
}
