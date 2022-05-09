import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:int_app/src/app/view/http/data_model.dart';

const baseUrl = "http://ims.matteobernardi.fr";
const testURL = "https://jsonplaceholder.typicode.com/users";

class API {
  static Future getUsers() {
    var url = testURL;
    return http.get(Uri.parse(url));
  }

  static Future getObjectCollision() {
    var url = baseUrl + "/object-collision/";
    return http.get(Uri.parse(url));
  }

  static Future getBoundaryCollision() {
    var url = baseUrl + "/boundary-collision/";
    return http.get(Uri.parse(url));
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var users = new List<User>.empty();
  // var objectCollisions = new List<ObjectCollision>.empty();
  // var boundaryCollisions = new List<BoundaryCollision>.empty();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        print(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  // //Get and add object collision to list
  // _getObjectCollision() {
  //   API.getObjectCollision().then((response) {
  //     setState(() {
  //       Iterable list = json.decode(response.body);
  //       print(response.body);
  //       objectCollisions = list.map((model) => ObjectCollision.fromJson(model)).toList();
  //     });
  //   });
  // }

  // //Get and add boundary collision to list
  //  _getBoundaryCollision() {
  //   API.getObjectCollision().then((response) {
  //     setState(() {
  //       Iterable list = json.decode(response.body);
  //       print(response.body);
  //       boundaryCollisions = list.map((model) => BoundaryCollision.fromJson(model)).toList();
  //     });
  //   });
  // }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User List"),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(users[index].name),
              subtitle: Text(users[index].email)
              
            );
          },
        ));
  }
}

class Boundary {
}
