import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothDiscoverManager {
  Stream<BluetoothState> get state => FlutterBlue.instance.state;
  Stream<List<ScanResult>> get scanResults =>
      FlutterBlue.instance.scanResults.asBroadcastStream();

  Future<bool> get isAvailable => FlutterBlue.instance.isAvailable;

  Future<bool> get isEnabled => FlutterBlue.instance.isOn;

  Future<bool> requestPermissions() async {
    try {
      (await [
        Permission.bluetoothConnect,
        Permission.bluetoothAdvertise,
        Permission.bluetoothScan,
        Permission.location,
      ].request())
          .values
          .firstWhere((element) => element.isDenied);
      return false;
    } on StateError catch (_) {
      return true;
    }
  }

  Future<dynamic> startScan(
      {required Duration timeout,
      ScanMode scanMode = ScanMode.balanced}) async {
    return FlutterBlue.instance.startScan(timeout: timeout, scanMode: scanMode);
  }

  Future<dynamic> stopScan() async {
    return FlutterBlue.instance.stopScan();
  }
}
