import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:control_pad/views/joystick_view.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:int_app/src/app/bluetooth/remotePage.dart';
import 'package:int_app/src/app/map/map.dart';

class HomePage extends StatefulWidget {
  final BluetoothDevice server;

  const HomePage({required this.server});
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      RemotePage(
        server: widget.server,
      ),
      MapState(
        server: widget.server,
      )
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.gamepad), label: "Controller"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
