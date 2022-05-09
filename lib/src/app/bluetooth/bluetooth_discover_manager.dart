import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import '../view-model/bluetooth_view_model.dart';
import '../view/home/home_page.dart';

class BluetoothDiscoverManager {
  Stream<BluetoothState> get state => FlutterBlue.instance.state;
  Stream<List<ScanResult>> get scanResults =>
      FlutterBlue.instance.scanResults.asBroadcastStream();

  var sub = FlutterBlue.instance.scanResults.listen((results) async {
    for (var result in results) {
      if (result.device.id.id == "38:53:9C:86:C3:10") {
        print("Found device: ${result.device.id.id}");
        await result.device.connect();

        Get.offAll(HomePage());
      } else if (result.device.id.id == "14:60:CB:1B:4A:03") {
        print("Found device: ${result.device.id.id}");
        result.device.connect();
      }
    }
  });
  //B8:27:EB:EA:63:31

  /*ElevatedButton button(BluetoothViewModel viewModel, BluetoothDevice device) {
    return ElevatedButton(
      child: Text("Connect"),
      style: ButtonStyle(),
      onPressed: () async => viewModel.connect(_device),
    );
  }*/

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
