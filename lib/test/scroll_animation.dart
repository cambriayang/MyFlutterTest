import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double maxHeight=650.0;
double minHeight=200.0;

class ScrollAnimation extends StatefulWidget {
  const ScrollAnimation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScrollAnimationState();
  }
}

class Config extends ChangeNotifier {
  ScrollPhysics scrollPhysics = NeverScrollableScrollPhysics();
  double scrollHeight = minHeight;
}

class _ScrollAnimationState extends State<ScrollAnimation> with TickerProviderStateMixin{
  Config config = Config();

  ScrollController scollController = ScrollController();

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

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

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    //匀速
    animation = Tween(begin: maxHeight, end: minHeight).animate(controller)
      ..addListener(() {
        setState(() => {});
      });

    //启动动画(正向执行)
    controller.forward();
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
              onPointerSignal: (PointerSignalEvent event){
                print("onPointerSignal==[${event.delta.dy}");
              },
              onPointerHover: (PointerHoverEvent event){
                print("onPointerHover==[${event.delta.dy}");
              },
              // behavior: HitTestBehavior.opaque,
              onPointerMove: (PointerMoveEvent event) {
                print("onPointerMove==[${event.delta.dy}");
                print("controller==[${scollController.offset}");

                if(scollController.offset==Offset.zero)
                  return;
                config.scrollHeight -= event.delta.dy;
                if (config.scrollHeight > maxHeight) {
                  config.scrollHeight = maxHeight;
                  config.scrollPhysics = BouncingScrollPhysics();
                } else if (config.scrollHeight < minHeight) {
                  config.scrollHeight = minHeight;
                  config.scrollPhysics = NeverScrollableScrollPhysics();
                } else{

                }

                setState(() {});
              },
              child: CustomScrollView(
                physics: config.scrollPhysics,
                controller: scollController,
                slivers: [
                  // AppBar，包含一个导航栏.
                  // SliverAppBar(
                  //   pinned: true, // 滑动到顶端时会固定住
                  //   expandedHeight: 250.0,
                  //   flexibleSpace: FlexibleSpaceBar(
                  //     title: const Text('Demo'),
                  //     background: Image.asset(
                  //       'assets/images/sanjiao.png',
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ),
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
          //       if(config.scrollHeight>maxHeight){
          //         config.scrollHeight=maxHeight;
          //         config.scrollPhysics=BouncingScrollPhysics();
          //       }else if(config.scrollHeight<minHeight){
          //         config.scrollHeight=minHeight;
          //         config.scrollPhysics=NeverScrollableScrollPhysics();
          //       }
          //
          //       setState(() {});
          //     },
          //     child: CustomScrollView(
          //       physics: config.scrollPhysics,
          //       controller: scollController,
          //       slivers: [
          //         // AppBar，包含一个导航栏.
          //         // SliverAppBar(
          //         //   pinned: true, // 滑动到顶端时会固定住
          //         //   expandedHeight: 250.0,
          //         //   flexibleSpace: FlexibleSpaceBar(
          //         //     title: const Text('Demo'),
          //         //     background: Image.asset(
          //         //       'assets/images/sanjiao.png',
          //         //       fit: BoxFit.fill,
          //         //     ),
          //         //   ),
          //         // ),
          //         SliverPadding(
          //           padding: const EdgeInsets.all(8.0),
          //           sliver: SliverGrid(
          //             //Grid
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2, //Grid按两列显示
          //               mainAxisSpacing: 10.0,
          //               crossAxisSpacing: 10.0,
          //               childAspectRatio: 4.0,
          //             ),
          //             delegate: SliverChildBuilderDelegate(
          //                   (BuildContext context, int index) {
          //                 //创建子widget
          //                 return Container(
          //                   alignment: Alignment.center,
          //                   color: Colors.cyan[100 * (index % 9)],
          //                   child: Text('grid item $index'),
          //                 );
          //               },
          //               childCount: 20,
          //             ),
          //           ),
          //         ),
          //         SliverFixedExtentList(
          //           itemExtent: 50.0,
          //           delegate: SliverChildBuilderDelegate(
          //                 (BuildContext context, int index) {
          //               //创建列表项
          //               return Container(
          //                 alignment: Alignment.center,
          //                 color: Colors.lightBlue[100 * (index % 9)],
          //                 child: Text('list item $index'),
          //               );
          //             },
          //             childCount: 20,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
