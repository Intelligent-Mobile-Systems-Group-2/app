// create a canvas element here using the package flutter_canvas
import 'package:flutter/material.dart';

class MowerMap extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 4.0
      ..color = Colors.indigo;
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(20, 40, 100, 100), Radius.circular(20)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}