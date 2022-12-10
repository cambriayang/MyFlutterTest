// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, slash_for_doc_comments

/*********************************************************************************
 * Author: Argost Ye
 * Time: 1/18/22
 **********************************************************************************/
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDrawPathRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CustomDrawPathRoute"),
      ),
      body: CustomPaint(
        painter: MyDrawPathPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class MyDrawPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // _firstPath(canvas, size);
    // _starPath(canvas, size);
    // _addOvalPath(canvas, size);
    _addArcPath(canvas, size);
  }

  void _firstPath(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path()..moveTo(100, 100);

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5.0;
    paint.color = Colors.black;
    path.lineTo(250, 250);
    path.lineTo(350, 180);
    path.lineTo(200, 500);
    // 控制路径是否闭合，可不写
    path.close();

    canvas.drawPath(path, paint);
  }

  void _starPath(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path()..moveTo(size.width / 2, 200);
    // paint.style = PaintingStyle.stroke;
    // paint.strokeWidth = 5.0;
    // paint.color = Colors.red;
    path.lineTo(size.width / 4, 500);
    path.lineTo(size.width / 7 * 6, 320);
    path.lineTo(size.width / 7, 320);
    path.lineTo(size.width / 4 * 3, 500);
    path.close();
    // path.fillType = PathFillType.nonZero;
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }

  void _addOvalPath(Canvas canvas, Size size) {
    Paint paint = Paint();
    // 只有path.addArc方法，path.moveTo方法将会无效
    Path path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5.0;
    paint.color = Colors.red;
// path.moveTo(size.width / 2, 200); 无效
    Rect oval = Rect.fromPoints(const Offset(0, 0), const Offset(280, 180));
    // oval = Rect.fromLTRB(10, 10, 10, 10);
    // path.addArc(oval, 0, pi / -2);
    path.addOval(oval);
    canvas.drawPath(path, paint);
  }

  void _addArcPath(Canvas canvas, Size size) {
    Paint paint = Paint();
    // 只有path.addArc方法，path.moveTo方法将会无效
    Path path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5.0;
    paint.color = Colors.red;
// path.moveTo(size.width / 2, 200); 无效
    Rect oval = Rect.fromPoints(const Offset(0, 0), const Offset(280, 180));
    path.addArc(oval, 100, pi / -2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
