import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
      home: Scaffold(
        key: scaffoldKey,
        drawer: new Drawer(
          child: new ListView(),
        ),
        body: Stack(
          children: <Widget>[
            new Center(
                child: new Column(
                  children: <Widget>[],
                )),
            Positioned(
              left: 10,
              top: 20,
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => scaffoldKey.currentState.openDrawer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}