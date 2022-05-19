// create a canvas element here using the package flutter_canvas
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class MowerMap extends CustomPainter {
  final List<DrawModel> pointsList;

  MowerMap(this.pointsList);

  @override
  void paint(Canvas canvas, Size size) {
    //Center the origin point
    canvas.translate((size.width / 2), (size.height / 2));

    //Create painters
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round;

    //Create lists and scale
    List<DrawModel> pointsListScaled = scalePoints(size, pointsList);
    List<Offset> offsetList = [];
    List<Offset> objectList = [];

    //Paint
    for (int i = 0; i < (pointsListScaled.length - 1); i++) {
      //Draw lines
      if (pointsListScaled[i] != null && pointsListScaled[i + 1] != null) {
        canvas.drawLine(
            pointsListScaled[i].offset, pointsListScaled[i + 1].offset, paint);
      } else if (pointsListScaled[i] != null &&
          pointsListScaled[i + 1] == null) {
        offsetList.add(pointsListScaled[i].offset);
        canvas.drawPoints(PointMode.points, offsetList, paint);
      }

      //Draw dots
      if (pointsListScaled[i].type == "Object") {
        objectList.add(pointsListScaled[i].offset);
        canvas.drawPoints(PointMode.points, objectList, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class DrawModel {
  final Offset offset;
  final String type;
  DrawModel(this.offset, this.type);
}

scalePoints(Size windowSize, List<DrawModel> pointsList) {
  final scaleVal = getScaleValue(windowSize, pointsList);
  final points = pointsList.map((e) => (e.offset * scaleVal) / 2);

  List<DrawModel> pointsListScaled = [];
  for (int i = 0; i < pointsList.length; i++) {
    pointsListScaled.add(DrawModel(points.elementAt(i), pointsList[i].type));
  }
  return pointsListScaled;
}

getScaleValue(Size windowSize, List<DrawModel> pointsList) {
  double highestWidth = 0;
  double highestHeight = 0;
  double scale = 1;

  for (var point in pointsList) {
    if (point.offset.dx > highestWidth) {
      highestWidth = point.offset.dx;
    }
    if (point.offset.dy > highestHeight) {
      highestHeight = point.offset.dy;
    }
  }

  if (highestHeight > highestWidth) {
    scale = ((windowSize.height - 15) / highestHeight);
  } else {
    scale = ((windowSize.width - 15) / highestWidth);
  }

  return scale;
}
