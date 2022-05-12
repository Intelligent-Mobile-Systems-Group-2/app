import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:int_app/src/app/view/http/data_model.dart';

const baseUrl = "http://ims.matteobernardi.fr";
DateTime now = DateTime.now();
String convertedDateTime =
    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

class API {
  static Future getObjectCollision() {
    var url = baseUrl + "/object-collision/?date=" + convertedDateTime;
    return http.get(Uri.parse(url));
  }

  static Future getBoundaryCollision() {
    var url = baseUrl + "/boundary-collision/?date=" + convertedDateTime;
    return http.get(Uri.parse(url));
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var boundryCollisions = List<CollisionModel>.empty();
  var objectCollisions = List<CollisionModel>.empty();

  _getCollition() {
    // get bondary collison
    API.getBoundaryCollision().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        boundryCollisions =
            list.map((model) => CollisionModel.fromJson(model)).toList();
      });
    });

    // get object collition
    API.getObjectCollision().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        objectCollisions =
            list.map((model) => CollisionModel.fromJson(model)).toList();
      });
    });
  }

  Timer? timer;

  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _getCollition());
  }

  dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User List"),
        ),
        body: ListView.builder(
//          itemCount: boundryCollisions.length,
          itemBuilder: (context, index) {
            return ListTile(
//                title: Text(boundryCollisions[index].time)
                );
          },
        ));
  }
}
