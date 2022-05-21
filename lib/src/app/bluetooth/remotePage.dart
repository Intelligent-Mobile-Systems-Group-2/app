import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:control_pad/views/joystick_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class RemotePage extends StatefulWidget {
  final BluetoothDevice server;

  const RemotePage({required this.server});

  @override
  _RemotePage createState() => new _RemotePage();
}

class _RemotePage extends State<RemotePage> {
  static final clientID = 0;
  BluetoothConnection? connection;

  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
        } else {}
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {});
  }

  @override
  void dispose() {
    // disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serverName = widget.server.name ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting to ' + serverName + '...')
              : isConnected
                  ? Text('Live with ' + serverName)
                  : Text('Live with ' + serverName))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 275),
            LiteRollingSwitch(
              value: true,
              textOn: 'Remote',
              textOff: 'Auto',
              colorOn: Colors.green,
              colorOff: Colors.grey,
              iconOn: Icons.power_settings_new,
              iconOff: Icons.power_settings_new,
              onChanged: (bool state) {
                if (state == true) {
                  _sendInput("120 1");
                } else {
                  _sendInput("0");
                }
              },
            ),
            JoystickView(
              size: 250,
              onDirectionChanged: (double degree, double distance) {
                _sendInput(degree.toStringAsFixed(0) + ' 1');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sendInput(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
  }
}
