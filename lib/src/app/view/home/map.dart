import 'package:flutter/material.dart';
import 'package:int_app/src/app/view/Canvas.dart';

class MapState extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapState> {
  late final List<DrawModel> pointsList = createDrawModelList();
  List<ListTile> objectList = createObjectList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Map"),
        ),
        body: Column(children: [
          // Map
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromARGB(255, 115, 115, 115), width: 5)),
            child: Center(
                child: Container(
              color: Colors.white,
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: MowerMap(pointsList),
              ),
            )),
          ),
          // List
          Container(
            color: Colors.white,
            height: 250,
            width: double.infinity,
            child: ListView(
                children:
                    ListTile.divideTiles(context: context, tiles: objectList)
                        .toList()),
          )
        ]));
  }
}

createDrawModelList() {
  //TODO should get a list from request and make DrawModelList
  final List<DrawModel> pointList = [
    DrawModel(const Offset(0, 0), "Start"),
    DrawModel(const Offset(50, 50), "Object"),
    DrawModel(const Offset(100, 60), "Boundary"),
    DrawModel(const Offset(100, 80), "Boundary"),
    DrawModel(const Offset(90, 70), "Boundary"),
    DrawModel(const Offset(50, 80), "Object"),
    DrawModel(const Offset(-50, 30), "Object"),
    DrawModel(const Offset(-100, -60), "Boundary")
  ];
  return pointList;
}

createObjectList() {
  //TODO should get a list from request and make ObjectList
  List<ListTile> objectList = [
    const ListTile(
        leading: Text("1"),
        title: Text("Can"),
        trailing: Text("2022/11/2 - 13:37")),
    const ListTile(
        leading: Text("2"),
        title: Text("Dog"),
        trailing: Text("2022/11/2 - 13:40")),
    const ListTile(
        leading: Text("3"),
        title: Text("Bottle"),
        trailing: Text("2022/11/2 - 13:42"))
  ];
  return objectList;
}
