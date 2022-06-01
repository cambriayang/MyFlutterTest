// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/test/ysl_listener.dart';

double maxHeight = 650.0;
double minHeight = 200.0;

class CustomAnim extends StatefulWidget {
  const CustomAnim({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomAnimState();
  }
}

class Config extends ChangeNotifier {
  ScrollPhysics scrollPhysics = NeverScrollableScrollPhysics();
  double scrollHeight = minHeight;
}

class _CustomAnimState extends State<CustomAnim> with TickerProviderStateMixin {
  Config config = Config();

  ScrollController scollController = ScrollController();

  late Animation<double> animation;
  late AnimationController controller;

  bool top = false;

  late Color _bgColor;

  double _firstBottom = 0;
  double _secondBottom = 0;

  @override
  void initState() {
    super.initState();

    _bgColor = Color.fromARGB(255, Random().nextInt(256) + 0,
        Random().nextInt(256) + 0, Random().nextInt(256) + 0);
    // if (scollController.hasListeners == false) {
    //   scollController.addListener(() {
    //     print("==[offset: ${scollController.offset}");
    //     if(scollController.offset<=0){
    //       config.scrollPhysics=NeverScrollableScrollPhysics();
    //       // config.scrollHeight=minHeight;
    //
    //       setState(() {
    //         // //启动动画(正向执行)
    //         // controller.forward();
    //       });
    //     }
    //   });
    // }

    // controller = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );
    //
    // //匀速
    // animation = Tween(begin: maxHeight, end: minHeight).animate(controller)
    //   ..addListener(() {
    //     setState(() => {});
    //   });
    //
    // //启动动画(正向执行)
    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("$runtimeType"),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _bgColor = Color.fromARGB(255, Random().nextInt(256) + 0,
                    Random().nextInt(256) + 0, Random().nextInt(256) + 0);
              });
            },
            child: Container(
              color: _bgColor,
            ),
          ),
          Positioned(
            bottom: 50,
            width: size.width,
            height: config.scrollHeight,
            child: YSListener(
              onPointerUp: (PointerUpEvent event) {
                print("onPointerUp==[${scollController.offset}");
              },
              onPointerExit: (PointerExitEvent event) {
                print("onPointerExit==[${scollController.offset}");
              },
              onPointerMove: (PointerMoveEvent event) {
                print("onPointerMove==[${event.delta.dy}");
                print("controller==[${scollController.offset}");

                if ((scollController.offset > 0 &&
                        top == true &&
                        event.delta.dy > 0) ||
                    (config.scrollHeight == maxHeight && event.delta.dy < 0)) {
                  //(scollController.offset > 0 &&
                  //                         top == true &&
                  //                         event.delta.dy > 0)
                  //是滑动到顶部，向下拉，需要平滑拉下来

                  // (config.scrollHeight == maxHeight && event.delta.dy < 0)
                  //第一次上划到顶部时，继续上划，需要响应

                  double y = scollController.offset;
                  y -= event.delta.dy;
                  scollController.jumpTo(y);
                  return;
                }

                config.scrollHeight -= event.delta.dy;
                if (config.scrollHeight > maxHeight) {
                  config.scrollHeight = maxHeight;
                  config.scrollPhysics = BouncingScrollPhysics();
                  top = true;
                } else if (config.scrollHeight < minHeight) {
                  config.scrollHeight = minHeight;
                  scollController.jumpTo(scollController.initialScrollOffset);
                  config.scrollPhysics = NeverScrollableScrollPhysics();
                  top = false;
                } else {}

                setState(() {
                  _firstBottom -= event.delta.dy;

                  if (_firstBottom < 0) {
                    _firstBottom = 0;
                  }

                  if (_firstBottom > 50) {
                    _firstBottom = 50;
                  }
                });
              },
              child: SingleChildScrollView(
                physics: config.scrollPhysics,
                controller: scollController,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: _firstBottom,
                            child: Opacity(
                              opacity: _firstBottom/50.0,
                              child: Container(
                                height: 50,
                                color: Colors.red,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("data1"),
                                    Text("data2"),
                                    Text("data3"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: _secondBottom,
                            child: Container(
                              height: 50,
                              color: Colors.blue,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("sec1"),
                                  Text("sec2"),
                                  Text("sec3"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.amber,
                      height: 600,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
