import 'dart:async';
import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ims/src/app/bluetooth/bluetooth_device_manager.dart';
import 'package:ims/src/app/bluetooth/bluetooth_discover_manager.dart';
import 'package:ims/src/app/bluetooth/controllers/robot_controller.dart';
import 'package:ims/src/app/bluetooth/interactors/robot_interactor.dart';
import 'package:stacked/stacked.dart';
import '../bluetooth/bluetooth_device_manager.dart';

class BluetoothViewModel extends BaseViewModel {
  BluetoothDiscoverManager _bluetoothDiscoverManager;
  BluetoothDeviceManager _bluetoothDeviceManager;
  RobotInteractor _robotInteractor;
  RobotController _robotController;

  BluetoothViewModel() {
    _bluetoothDiscoverManager = GetIt.I<BluetoothDiscoverManager>();
    _bluetoothDeviceManager = GetIt.I<BluetoothDeviceManager>();
    _robotInteractor = GetIt.I<RobotInteractor>();
    _robotController = GetIt.I<RobotController>();
  }

  Stream<List<BluetoothDevice>> get devices => _bluetoothDeviceManager.devices;

  Future<void> startScan({ScanMode scanMode = ScanMode.balanced}) async {
    await _bluetoothDiscoverManager.startScan(timeout: Duration(seconds: 5), scanMode: scanMode);
  }

  Future<void> stopScan() async {
    await _bluetoothDiscoverManager.stopScan();
  }

  Future<void> connect(BluetoothDevice device) async {
    await _bluetoothDeviceManager.connect(device);
  }

  Future<void> disconnect() async {
    await _bluetoothDeviceManager.disconnect();
  }

  Future<void> write(Guid uuid, List<int> value) async {
    await _robotInteractor.write(uuid, value);
  }

  Future<List<int>> read(Guid uuid) async {
    return await _robotInteractor.read(uuid);
  }

  Future<bool> setNotify(Guid uuid, bool state) async {
    return await _robotInteractor.setNotify(uuid, state);
  }

  Stream<List<int>> value(Guid uuid) {
    return _robotInteractor.value(uuid);
  }

  Future<void> disconnectAll() async {
    await _bluetoothDeviceManager.disconnectAll();
  }

  Future<void> connectAll() async {
    await _bluetoothDeviceManager.connectAll();
  }

  Future
  
}