// create a canvas element here using the package flutter_canvas
import 'dart:ui';

import 'package:flutter/material.dart';

class MowerMap extends CustomPainter {
  final List<DrawModel> pointsList;

  MowerMap(this.pointsList);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate((size.width / 2), (size.height / 2));
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < (pointsList.length - 1); i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].offset, pointsList[i + 1].offset, paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        List<Offset> offsetList = [];
        offsetList.add(pointsList[i].offset);
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
