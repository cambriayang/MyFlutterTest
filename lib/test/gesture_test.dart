import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GestureTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$runtimeType"),
      ),
      body: _BothDirectionTest(),
    );
  }
}

class HitTestBehaviorTest extends StatelessWidget {
  const HitTestBehaviorTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        wChild(1),
        wChild(2),
      ],
    );
  }

  Widget wChild(int index) {
    return Listener(
      // behavior: HitTestBehavior.opaque, // 放开此行，点击只会输出 2
      behavior: HitTestBehavior.translucent, // 放开此行，点击会同时输出 2 和 1
      onPointerDown: (e) => print(index),
      onPointerMove: (e)=>print(e.delta),
      child: SizedBox.expand(),
    );
  }
}

class AllChildrenCanResponseEvent extends StatelessWidget {
  const AllChildrenCanResponseEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // IgnorePointer(child: wChild(1, 200)),
        // IgnorePointer(child: wChild(2, 200)),
        HitTestBlocker(child: wChild(1, 200)),
        HitTestBlocker(child: wChild(2, 200)),
      ],
    );
  }

  Widget wChild(int index, double size) {
    return Listener(
      onPointerDown: (e) => print(index),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey,
      ),
    );
  }
}

class HitTestBlocker extends SingleChildRenderObjectWidget {
  HitTestBlocker({
    Key? key,
    this.up = true,
    this.down = false,
    this.self = false,
    Widget? child,
  }) : super(key: key, child: child);

  /// up 为 true 时 , `hitTest()` 将会一直返回 false.
  final bool up;

  /// down 为 true 时, 将不会调用 `hitTestChildren()`.
  final bool down;

  /// `hitTestSelf` 的返回值
  final bool self;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderHitTestBlocker(up: up, down: down, self: self);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderHitTestBlocker renderObject) {
    renderObject
      ..up = up
      ..down = down
      ..self = self;
  }
}

class RenderHitTestBlocker extends RenderProxyBox {
  RenderHitTestBlocker({this.up = true, this.down = true, this.self = true});

  bool up;
  bool down;
  bool self;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    bool hitTestDownResult = false;

    if (!down) {
      hitTestDownResult = hitTestChildren(result, position: position);
    }

    bool pass =
        hitTestSelf(position) || (hitTestDownResult && size.contains(position));

    if (pass) {
      result.add(BoxHitTestEntry(this, position));
    }

    return !up && pass;
  }

  @override
  bool hitTestSelf(Offset position) => self;
}

class _BothDirectionTest extends StatefulWidget {
  @override
  _BothDirectionTestState createState() => _BothDirectionTestState();
}

class _BothDirectionTestState extends State<_BothDirectionTest> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //垂直方向拖动事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}