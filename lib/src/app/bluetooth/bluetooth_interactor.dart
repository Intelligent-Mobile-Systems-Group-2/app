import 'package:flutter_blue/flutter_blue.dart';
import 'package:int_app/src/app/bluetooth/interactors/robot_interactor.dart';
import 'package:synchronized/synchronized.dart';

class BluetoothInteractor {
  Map<Guid, BluetoothService> _serviceByUUID;
  Map<Guid, BluetoothCharacteristic> _characteristicByUUID;

  BluetoothInteractor(this._serviceByUUID, this._characteristicByUUID);

  final _lock = Lock();

  Future<void> write(Guid uuid, List<int> values) async {
    await _lock.synchronized(() async {
      await _characteristicByUUID[uuid]!.write(values);
    });

    Future<List<int>> read(Guid uuid) async {
      return await _characteristicByUUID[uuid]!.read();
    }

    Future<bool> setNotifyValue(Guid uuid, bool state) async {
      return await _characteristicByUUID[uuid]!.setNotifyValue(state);
    }

    Stream<List<int>> value(Guid uuid) {
      return _characteristicByUUID[uuid]!.value;
    }

    Interactor? createInstance<Interactor extends BluetoothInteractor>(
        List<BluetoothService> services) {
      switch (Interactor) {
        case RobotInteractor:
          return RobotInteractor(services) as Interactor;
      }
    }
  }
}
