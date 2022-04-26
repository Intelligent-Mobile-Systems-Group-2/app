import 'package:flutter_blue/flutter_blue.dart';
import 'package:int_app/src/app/bluetooth/interactors/robot_interactor.dart';
import 'package:synchronized/synchronized.dart';

class BluetoothInteractor {
  Map<Guid, BluetoothService> _servicesByUUID;
  Map<Guid, BluetoothCharacteristic> _characteristicsByUUID;

  BluetoothInteractor(this._servicesByUUID, this._characteristicsByUUID);

  var _lock = new Lock();

  Future<void> write(Guid uuid, List<int> values) async {
    await _lock.synchronized(() async {
      return _characteristicsByUUID[uuid]!.write(values);
    });
  }

  Future<List<int>> read(Guid uuid) {
    return _characteristicsByUUID[uuid]!.read();
  }

  Future<bool> setNotifyValue(Guid uuid, bool state) {
    return _characteristicsByUUID[uuid]!.setNotifyValue(state);
  }

  Stream<List<int>> value(Guid uuid) {
    return _characteristicsByUUID[uuid]!.value;
  }

  static Interactor? createInstance<Interactor extends BluetoothInteractor>(
      List<BluetoothService> services) {
    switch (Interactor) {
      case RobotInteractor:
        return RobotInteractor(services) as Interactor;
    }
  }
}
