import 'package:flutter_blue/flutter_blue.dart';
import 'package:syncronized/syncronized.dart';

class BluetoothInteractor {
  Map<Guid, BluetoothService> _serviceByUUID;
  Map<Guid, BluetoothCharacteristic> _characteristicByUUID;

  BluetoothInteractor(this._serviceByUUID, this._characteristicByUUID);

  var _lock = Lock();

  Future<void> write(Guid uuid, List<int> value) async {
    await _lock.synchronized(() async {
      await _characteristicByUUID[uuid]!.write(value);
    });

    Future<List<int>> read(Guid uuid) async {
      return await _characteristicByUUID[uuid]!.read();
    }

    Future<bool> setNotify(Guid uuid, bool state) async {
      return await _characteristicByUUID[uuid]!.setNotifyValue(state);
    }

    Stream<List<int>> value(Guid uuid) {
      return _characteristicByUUID[uuid]!.value;
    }

    static Interactor? createInstance<Interactor extends bluetoothInteractor>(List<BluetoothService> service) {
      switch (Interactor) {
        case : RobotInteractor
          return RobotInteractor(service) as Interactor;
      }
    }
  }
}