import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../view/home/home_page.dart';
import './bluetooth_device_manager.dart';

class BluetoothDiscoverManager {
  Stream<BluetoothState> get state => FlutterBlue.instance.state;
  Stream<List<ScanResult>> get scanResults =>
      FlutterBlue.instance.scanResults.asBroadcastStream();
  BluetoothDeviceManager _deviceManager = BluetoothDeviceManager();

  Future<BluetoothDevice?> foundResults() async {
    await FlutterBlue.instance.scanResults.listen((results) {
      try {
        for (ScanResult result in results) {
          print(result.device.name);
          if (result.device.id.id == "BE:AC:10:00:00:01") {
            print("Found device: ${result.device.id.id}");
            _deviceManager.connect(result.device);
            stopScan();
          }
        }
      } catch (e) {
        print(e);
        rethrow;
      }
    });
    //B8:27:EB:EA:63:31
  }

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
