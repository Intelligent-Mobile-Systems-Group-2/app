import 'package:flutter/material.dart';
import 'dart:core';

class User {
  late String time;
  late String x;
  late String y;

  User(String time, String x, String y) {
    this.time = time;
    this.x = x;
    this.y = y;
  }

  User.fromJson(Map json)
      : time = json['time'],
        x = json['x'],
        y = json['y'];

  Map toJson() {
    return {'time': time, 'x': x, 'y': y};
  }
}
