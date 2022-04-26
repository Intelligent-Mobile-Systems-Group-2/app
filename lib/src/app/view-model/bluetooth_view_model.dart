import 'dart:async';
import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/gen/flutterblue.pbjson.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import '../bluetooth/bluetooth_device_manager.dart';
import '../bluetooth/bluetooth_discover_manager.dart';
import '../bluetooth/controllers/robot_controller.dart';
import '../bluetooth/interactors/robot_interactor.dart';

class BluetoothViewModel extends BaseViewModel {
  final _bluetoothDiscoveryManager = GetIt.I<BluetoothDiscoverManager>();
  final _bluetoothDeviceManager =
      GetIt.I<BluetoothDeviceManager<RobotInteractor, RobotController>>();

  final refreshTimeout = Duration(seconds: 10);

  Stream<List<ScanResult>> get scanResults =>
      _bluetoothDeviceManager.scanResults;

  Future<bool> get isAvailable => _bluetoothDiscoveryManager.isAvailable;

  Future<bool> get isEnabled => _bluetoothDiscoveryManager.isEnabled;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  BluetoothDevice? _selectedDevice;
  BluetoothDevice? get selectedDevice => _selectedDevice;

  Future<void> initialize() async {
    return isrefresh();
  }

  Future<void> startScan({ScanMode scanMode = ScanMode.balanced}) async {
    await _bluetoothDiscoveryManager.startScan(
        timeout: Duration(seconds: 5), scanMode: scanMode);
  }

  Future<void> stopScan() async {
    await _bluetoothDiscoveryManager.stopScan();
  }

  Future<void> connect(BluetoothDevice device) async {
    await _bluetoothDiscoveryManager.stopScan();

    _isRefreshing = false;
    _selectedDevice = device;
    notifyListeners();

    try {
      await _bluetoothDeviceManager.connect(device);
    } on TimeoutException catch (e) {
      await disconnect();
      log(e.message!);
    }
  }

  Future<void> disconnect() async {
    await _bluetoothDeviceManager.disconnect();
    _selectedDevice = null;
    notifyListeners();
  }

  Future<void> isrefresh() async {
    if (!await isRefreshable()) return;

    await _bluetoothDiscoveryManager.stopScan();
    _isRefreshing = true;
    notifyListeners();

    await _bluetoothDiscoveryManager.startScan(timeout: refreshTimeout);
    _isRefreshing = false;
    notifyListeners();
  }

  Future<bool> isRefreshable() async {
    if (!await _bluetoothDiscoveryManager.requestPermissions()) {
      _snackbar("Permission", "Permission denied.",
          SnackBarAction(label: "App settings", onPressed: () => {}));
      return false;
    }

    if (!await _bluetoothDiscoveryManager.isAvailable) {
      _snackbar("Bluetooth", "Bluetooth adapter missing.",
          SnackBarAction(label: "Bluetooth settings", onPressed: () => {}));
      return false;
    }

    if (!await _bluetoothDiscoveryManager.isEnabled) {
      _snackbar("Bluetooth", "Bluetooth not enabled.",
          SnackBarAction(label: "Bluetooth settings", onPressed: () => {}));
      return false;
    }

    return true;
  }

  void _snackbar(String title, String message, SnackBarAction action) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        padding:
            const EdgeInsets.only(left: 20, right: 30, top: 16, bottom: 16),
        title: title,
        message: message,
        mainButton: ElevatedButton(
            onPressed: action.onPressed, child: Text(action.label)),
      );
    }
  }
}
