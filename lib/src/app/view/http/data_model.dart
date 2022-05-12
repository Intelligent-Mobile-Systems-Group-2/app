import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:core';

class CollisionModel {
  late String time;
  late String x;
  late String y;
  late String? object;

  CollisionModel(String time, String x, String y, String object) {
    this.time = time;
    this.x = x;
    this.y = y;
    this.object = object;
  }

  CollisionModel.fromJson(Map json)
      : time = json['time'],
        x = json['x'],
        y = json['y'],
        object = json['object'] ?? null;

  Map toJson() {
    if (object != null) {
      return {'time': time, 'x': x, 'y': y, 'object': object};
    } else {
      return {'time': time, 'x': x, 'y': y};
    }
  }
}
