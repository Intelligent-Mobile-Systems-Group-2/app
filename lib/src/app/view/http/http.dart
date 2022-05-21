import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:int_app/src/app/view/http/data_model.dart';

const baseUrl = "http://ims.matteobernardi.fr";
DateTime now = DateTime.now();
String convertedDateTime =
    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
String convertedTime =
    "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

/*int hour = now.hour.toInt();
String newHour = "${hour - 2}";*/

class API {
  static Future getObjectCollision() {
    print(convertedDateTime);
    var url = baseUrl +
        "/object-collision/?date=" +
        convertedDateTime +
        "&time=" +
        convertedTime +
        ":00";
    print("object " + url);
    return http.get(Uri.parse(url));
  }

  static Future getBoundaryCollision() {
    var url = baseUrl +
        "/boundary-collision/?date=" +
        convertedDateTime +
        "&time=" +
        convertedTime +
        ":00";
    print("boundary " + url);
    return http.get(Uri.parse(url));
  }
}

Future<List<CollisionModel>> getCollision() async {
  var boundaryCollisions = List<CollisionModel>.empty();
  var objectCollisions = List<CollisionModel>.empty();
  var listOfCollisions = List<CollisionModel>.empty();

  // get bondary collison
  await API.getBoundaryCollision().then((response) {
    print("bound" + response.toString());
    Iterable list = json.decode(response.body);
    boundaryCollisions =
        list.map((model) => CollisionModel.fromJson(model)).toList();
  });

  // get object collition
  await API.getObjectCollision().then((response) {
    print("hej" + response.toString());
    Iterable list = json.decode(response.body);
    objectCollisions =
        list.map((model) => CollisionModel.fromJson(model)).toList();
  });

  //Combine the two lists
  listOfCollisions = [...objectCollisions, ...boundaryCollisions];

  //Sort by time
  listOfCollisions.sort((a, b) => a.time.compareTo(b.time));

  return listOfCollisions;
}
