import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:int_app/src/app/map/Canvas.dart';
import 'package:int_app/src/app/http/data_model.dart';
import 'package:int_app/src/app/http/http.dart';

class MapState extends StatefulWidget {
  final BluetoothDevice server;

  const MapState({required this.server});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<List<CollisionModel>>(
        future: getCollision(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CollisionModel> points = snapshot.data!;
            final List<DrawModel> pointsList = createDrawModelList(points);
            final List<ListTile> objectList = createObjectList(points);
            return SafeArea(
              child: Column(children: [
                // Map
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 115, 115, 115),
                          width: 5)),
                  child: Align(
                      alignment: Alignment.bottomCenter,
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
                      children: ListTile.divideTiles(
                              context: context, tiles: objectList)
                          .toList()),
                )
              ]),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ));
  }
}

createDrawModelList(List<CollisionModel> points) {
  final List<DrawModel> pointList = [];
  for (final point in points) {
    try {
      double xVal = double.parse(point.x);
      double yVal = double.parse(point.y);

      String type = "Boundary";
      if (point.object == null) {
        type = "Boundary";
      } else {
        type = "Object";
      }
      pointList.add(DrawModel(Offset(xVal, yVal), type));
    } catch (err) {
      throw err;
    }
  }
  return pointList;
}

createObjectList(List<CollisionModel> points) {
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
