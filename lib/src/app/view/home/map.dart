import 'package:flutter/material.dart';
import 'package:int_app/src/app/view/Canvas.dart';

class MapState extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

final apiData = [
  {'time': "2022/08/31:13:37", "x": 0.0, "y": 0.0},
  {'time': "2022/08/31:13:38", "x": 100.0, "y": 30.0, "object": "shoe"},
  {'time': "2022/08/31:13:39", "x": 90.0, "y": 100.0},
  {'time': "2022/08/31:13:40", "x": -80.3, "y": 20.1, "object": "rock"},
  {'time': "2022/08/31:13:41", "x": 90.0, "y": -30.1}
];

class _MapState extends State<MapState> {
  final List<PointModel> points = convertToPoints(apiData);
  late final List<DrawModel> pointsList = createDrawModelList(points);
  late final List<ListTile> objectList = createObjectList(points);
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

convertToPoints(List data) {
  List<PointModel> points = [];
  for (final e in data) {
    points.add(PointModel(e["time"], e["x"], e["y"], e["object"]));
  }
  return points;
}

createDrawModelList(List<PointModel> points) {
  final List<DrawModel> pointList = [];
  for (final point in points) {
    if (point.object == null) {
      pointList.add(DrawModel(Offset(point.x, point.y), "Boundary"));
    } else {
      pointList.add(DrawModel(Offset(point.x, point.y), "Object"));
    }
  }
  return pointList;
}

createObjectList(List<PointModel> points) {
  final List<ListTile> objectList = [];
  var index = 1;
  for (final point in points) {
    if (point.object != null) {
      objectList.add(ListTile(
          leading: Text(index.toString()),
          title: Text(point.object),
          trailing: Text(point.time)));
      index++;
    }
  }
  return objectList;
}

class PointModel {
  final String time;
  final double x;
  final double y;
  final String object;

  PointModel(this.time, this.x, this.y, this.object);
}
