import 'dart:async';
import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:int_app/src/app/view/home/home_page.dart';
import 'package:stacked/stacked.dart';
import '../bluetooth/bluetooth_device_manager.dart';
import '../bluetooth/bluetooth_discover_manager.dart';
import '../bluetooth/controllers/robot_controller.dart';
import '../bluetooth/interactors/robot_interactor.dart';

class BluetoothViewModel extends BaseViewModel {
  final _discoveryManager = GetIt.I<BluetoothDiscoverManager>();
  final _deviceManager =
      GetIt.I<BluetoothDeviceManager<RobotInteractor, RobotController>>();

  final _refreshTimeout = const Duration(seconds: 10);

  Stream<List<ScanResult>> get scanResults => _discoveryManager.scanResults;

  Future<bool> get isAvailable => _discoveryManager.isAvailable;

  Future<bool> get isEnabled => _discoveryManager.isEnabled;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  BluetoothDevice? _selectedDevice;
  BluetoothDevice? get selectedDevice => _selectedDevice;

  Future<void> initialize() async {
    return refresh();
  }

  Future<void> connect(BluetoothDevice device) async {
    await _discoveryManager.stopScan();

    _isRefreshing = false;
    _selectedDevice = device;
    notifyListeners();

    try {
      await _deviceManager.connect(device);
      await Get.offAll(HomePage());
    } on TimeoutException catch (e) {
      await disconnect();
      log(e.message!);
    }
  }

  Future<void> disconnect() async {
    await _deviceManager.disconnect();
    _selectedDevice = null;
    notifyListeners();
  }

  Future<void> refresh() async {
    if (!await isRefreshable()) return;

    await _discoveryManager.stopScan();
    _isRefreshing = true;
    notifyListeners();

    await _discoveryManager.startScan(timeout: _refreshTimeout);
    _isRefreshing = false;
    notifyListeners();
  }

  Future<bool> isRefreshable() async {
    if (!await _discoveryManager.requestPermissions()) {
      _snackbar("Permission", "Permission denied.",
          SnackBarAction(label: "App settings", onPressed: () => {}));
      return false;
    }

    if (!await _discoveryManager.isAvailable) {
      _snackbar("Bluetooth", "Bluetooth adapter missing.",
          SnackBarAction(label: "Bluetooth settings", onPressed: () => {}));
      return false;
    }

    if (!await _discoveryManager.isEnabled) {
      _snackbar("Bluetooth", "Bluetooth not enabled.",
          SnackBarAction(label: "Bluetooth settings", onPressed: () => {}));
      return false;
    }

    return true;
  }

  void _snackbar(String title, String message, SnackBarAction action) {
    if (Get.isSnackbarOpen) {
      void _snackbar(String title, String message, SnackBarAction action) {
        Get.snackbar(
          title,
          message,
        );
      }
    }
  }
}
