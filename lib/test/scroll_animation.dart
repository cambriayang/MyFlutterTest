import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScrollAnimation extends StatefulWidget {
  const ScrollAnimation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScrollAnimationState();
  }
}

class Config extends ChangeNotifier {
  ScrollPhysics scrollPhysics = NeverScrollableScrollPhysics();
  double scrollHeight = 200;
}

class _ScrollAnimationState extends State<ScrollAnimation> {
  Config config = Config();

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (controller.hasListeners == false) {
      // controller.addListener(() {
      //   print("==[offset: ${controller.offset}");
      //   if(controller.offset<=-50){
      //     config.scrollPhysics=NeverScrollableScrollPhysics();
      //     setState(() {
      //
      //     });
      //   }
      // });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("$runtimeType"),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              print("==[Tap The Grey");
            },
            child: Container(
              color: Colors.grey,
            ),
          ),

          Positioned(
            bottom: 50,
            width: size.width,
            height: config.scrollHeight,
            child: Listener(
              // behavior: HitTestBehavior.opaque,
              onPointerMove: (PointerMoveEvent event) {
                print("onPointerMove==[${event.delta.dy}");
                print("controller==[${controller.offset}");
                config.scrollHeight -= event.delta.dy;

                if (config.scrollHeight >= 600) {
                  config.scrollHeight = 600;
                  config.scrollPhysics = BouncingScrollPhysics();
                } else if (config.scrollHeight <= 200) {
                  config.scrollHeight = 200;
                  config.scrollPhysics = NeverScrollableScrollPhysics();
                }

                setState(() {});
              },
              child: CustomScrollView(
                physics: config.scrollPhysics,
                controller: controller,
                slivers: [
                  // AppBar，包含一个导航栏.
                  SliverAppBar(
                    pinned: true, // 滑动到顶端时会固定住
                    expandedHeight: 250.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text('Demo'),
                      background: Image.asset(
                        'assets/images/sanjiao.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      //Grid
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //Grid按两列显示
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 4.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          //创建子widget
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.cyan[100 * (index % 9)],
                            child: Text('grid item $index'),
                          );
                        },
                        childCount: 20,
                      ),
                    ),
                  ),
                  SliverFixedExtentList(
                    itemExtent: 50.0,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        //创建列表项
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.lightBlue[100 * (index % 9)],
                          child: Text('list item $index'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 50,
          //   width: size.width,
          //   height: config.scrollHeight,
          //   child: GestureDetector(
          //     onVerticalDragUpdate: (DragUpdateDetails details) {
          //       print("==[ges_y: ${details.delta.dy}");
          //       config.scrollHeight-=details.delta.dy;
          //
          //       if(config.scrollHeight>=600){
          //         config.scrollHeight=600;
          //         config.scrollPhysics=BouncingScrollPhysics();
          //       }else if(config.scrollHeight<=200){
          //         config.scrollHeight=200;
          //         config.scrollPhysics=NeverScrollableScrollPhysics();
          //       }
          //
          //       setState(() {});
          //     },
          //     child: SingleChildScrollView(
          //       physics: config.scrollPhysics,
          //       controller: controller,
          //       child: Container(
          //         color: Colors.red,
          //         height: 1400,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
