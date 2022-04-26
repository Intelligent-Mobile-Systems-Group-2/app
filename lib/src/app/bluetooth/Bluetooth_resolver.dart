import 'package:flutter_blue/flutter_blue.dart';
import 'package:collection/collection.dart';

class BluetoothResolver {
  /// Find a specific [BluetoothService] by [uuid] among a list of [services.]
  static BluetoothService? findService(
      List<BluetoothService> services, Guid uuid) {
    return services.firstWhereOrNull((s) => s.uuid == uuid);
  }

  /// Find a specific [BluetoothCharacteristic] by [uuid] in a [service].
  static BluetoothCharacteristic? findCharacteristic(
      BluetoothService service, Guid uuid) {
    return service.characteristics.firstWhereOrNull((c) => c.uuid == uuid);
  }
}
