import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpView extends StatefulWidget {
  @override
  HttpViewState createState() => HttpViewState();
}

class HttpViewState extends State<HttpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: null,
          child: new Text("Get Data"),
        ),
      ),
    );
  }
}
