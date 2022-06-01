// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyAnimatedSwitcherRouter extends StatefulWidget {
  const MyAnimatedSwitcherRouter({Key? key}) : super(key: key);



  @override
  State<StatefulWidget> createState() {
    return _MyAnimatedSwitcherRouterState();
  }
}

class _MyAnimatedSwitcherRouterState extends State<MyAnimatedSwitcherRouter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$runtimeType"),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                // return SlideTransition(
                //   child: child,
                //   position: tween.animate(animation),
                // );
                // return MySlideTransition(
                //   child: child,
                //   position: tween.animate(animation),
                // );
                return SlideTransitionX(
                  child: child,
                  direction: AxisDirection.down, //上入下出
                  position: animation,
                );
              },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ElevatedButton(
              child: const Text('+1',),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

}

class MySlideTransition extends AnimatedWidget {
  const MySlideTransition({
    Key? key,
    required Animation<Offset> position,
    this.transformHitTests = true,
    required this.child,
  }) : super(key: key, listenable: position);

  final bool transformHitTests;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<Offset>;
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key? key,
    required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    required this.child,
  }) : super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: const Offset(0, -1), end: const Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
    }
  }

  final bool transformHitTests;

  final Widget child;

  final AxisDirection direction;

  late final Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}