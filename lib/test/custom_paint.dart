// ignore_for_file: use_key_in_widget_constructors

/*********************************************************************************
 * Author: Argost Ye
 * Time: 1/18/22
 **********************************************************************************/
import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print("paint");
    var rect = Offset.zero & size;
    drawChessboard(canvas, rect);
    drawPieces(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawChessboard(Canvas canvas, Rect rect) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0xffdcc48c);
    canvas.drawRect(rect, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black38
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }

  void drawPieces(Canvas canvas, Rect rect) {
    double eWidth = rect.width / 15;
    double eHeight = rect.height / 15;
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
        Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
        min(eWidth / 2, eHeight / 2),
        paint);
    paint.color = Colors.white;
    canvas.drawCircle(
        Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
        min(eWidth / 2, eHeight / 2), paint);
  }
}
