// ignore_for_file: use_key_in_widget_constructors

/*********************************************************************************
 * Author: Argost Ye
 * Time: 1/4/22
 **********************************************************************************/
import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationTestState();
  }
}

class _AnimationTestState extends State<AnimationTest> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    animation = Tween(begin: 0.0, end: 150.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
          controller.reverseDuration = Duration(seconds: 100);
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$runtimeType"),
      ),
      body: GrowTransition(
        animation: animation,
        child: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({
    required this.animation,
    this.child,
  });

  final Widget? child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (BuildContext context, child) {
            return Container(
              height: animation.value,
              width: animation.value,
              child: child,
            );
          }),
    );
  }
}
