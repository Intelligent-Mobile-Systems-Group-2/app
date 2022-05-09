import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:core';

class User {
  late String name;
  late String email;
  late int id;

  User(String date, String x) {
    this.name = name;
    this.email = email;
    this.id = id;
  }

  User.fromJson(Map json)
      : name = json['name'],
        email = json['email'],
        id = json['id'];

  Map toJson() {
    return {'name': name, 'email': email, 'id': id};
  }
  
}


// //Function to get Object collision
// class ObjectCollision {
//   late String date;
//   late String time;
//   late String x;
//   late String y;
//   late String object;
  

//   ObjectCollision(String date, String time, String x, String y, String object) {
//     this.date = date;
//     this.time = time;
//     this.x = x;
//     this.x = y;
//     this.x = object;
//   }

//   ObjectCollision.fromJson(Map json)
//       : date = json['date'],
//         time = json['time'],
//         x = json['x'];
//         y = json['y'];
//         object = json['object'];

//   Map toJson() {
//     return {'date': date, 'time': time, 'x': x, 'y': y, 'object': object};
//   }
  
// }

// //Function to get bounadary collision
// class BoundaryCollision {
//   late String date;
//   late String time;
//   late String x;
//   late String y;
  

//   BoundaryCollision(String date, String time, String x, String y) {
//     this.date = date;
//     this.time = time;
//     this.x = x;
//     this.x = y;
//   }

//   BoundaryCollision.fromJson(Map json)
//       : date = json['date'],
//         time = json['time'],
//         x = json['x'];
//         y = json['y'];

//   Map toJson() {
//     return {'date': date, 'time': time, 'x': x, 'y': y};
//   }
  
// }
