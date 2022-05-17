import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:int_app/src/app/bluetooth/bluetooth_controller.dart';
import 'package:int_app/src/app/bluetooth/bluetooth_interactor.dart';

//create flutter class for bluetooth connection
class BluetoothDeviceManager<Interactor extends BluetoothInteractor,
    Controller extends BluetoothController> {
  BluetoothDevice? _device;
  Interactor? _interactor;
  Controller? _controller;

  //create bluetooth device
  BluetoothDevice? get device => _device;
  Interactor? get interactor => _interactor;
  Controller? get controller => _controller;

  Future<void> connect(BluetoothDevice device,
      {Duration timeout = const Duration(seconds: 10)}) async {
    await device.connect().timeout(timeout,
        onTimeout: () =>
            {throw TimeoutException("Timeout on device connect.")});

    final services = await device.discoverServices();
    _device = device;
    _interactor = BluetoothInteractor.createInstance<Interactor>(services)!;
    _controller = BluetoothController.createInstance<Controller, Interactor>(
        _interactor!)!;
  }

  //create bluetooth device
  Future<void> disconnect() async {
    //create bluetooth device
    await _device?.disconnect();
    _device = null;
    _interactor = null;
    _controller = null;
  }
}
