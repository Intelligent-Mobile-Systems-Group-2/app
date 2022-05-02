import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Communication {
  
  //Bluetooth
  FlutterBluetoothSerial fls;
  BluetoothConnection connection;
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  String result = '';

  // Connect to the device via Bluetooth
  Future<void> connectBl(address) async{
    await BluetoothConnection.toAddress(address).then((_connection) {
      print('Connected to the device');
      connection = _connection;

      // Creates a listener to receive data
      connection.input.listen(onDataReceived).onDone(() {});
    }).catchError((error) {
      print('Cannot connect, exception occured');
    });
  }