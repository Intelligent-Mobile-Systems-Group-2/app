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
    print(size);

    canvas.translate((size.width / 2), (size.height / 2));
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    List<DrawModel> pointsListScaled = scalePoints(size, pointsList);

    for (int i = 0; i < pointsList.length; i++) {
      print(
          'Point: ${pointsList[i].offset}, Point scaled: ${pointsListScaled[i].offset}');
    }
    for (int i = 0; i < (pointsListScaled.length - 1); i++) {
      if (pointsListScaled[i] != null && pointsListScaled[i + 1] != null) {
        canvas.drawLine(
            pointsListScaled[i].offset, pointsListScaled[i + 1].offset, paint);
      } else if (pointsListScaled[i] != null &&
          pointsListScaled[i + 1] == null) {
        List<Offset> offsetList = [];
        offsetList.add(pointsListScaled[i].offset);
        canvas.drawPoints(PointMode.points, offsetList, paint);
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
  DrawModel(this.offset);
}

scalePoints(Size windowSize, List<DrawModel> pointsList) {
  final scaleVal = getScaleValue(windowSize, pointsList);
  final points = pointsList.map((e) => (e.offset * scaleVal) / 2);

  List<DrawModel> pointsListScaled = [];
  for (var point in points) {
    pointsListScaled.add(DrawModel(point));
  }
  return pointsListScaled;
}

getScaleValue(Size windowSize, List<DrawModel> pointsList) {
  double highestWidth = 0;
  double highestHeight = 0;
  for (var point in pointsList) {
    if (point.offset.dx > highestWidth) {
      highestWidth = point.offset.dx;
    }
    if (point.offset.dy > highestHeight) {
      highestHeight = point.offset.dy;
    }
  }
  if (highestHeight > highestWidth) {
    return ((windowSize.height - 10) / highestHeight);
  } else {
    return ((windowSize.width - 10) / highestWidth);
  }
}
