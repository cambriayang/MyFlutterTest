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
  ScrollPhysics scrollPhysics=NeverScrollableScrollPhysics();
  double scrollHeight=200;
}

class _ScrollAnimationState extends State<ScrollAnimation> {
  Config config = Config();

  ScrollController controller=ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(controller.hasListeners==false){
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
              onPointerMove:(PointerMoveEvent event){
                print("onPointerMove==[${event.delta.dy}");
                print("controller==[${controller.offset}");
                config.scrollHeight-=event.delta.dy;

                if (config.scrollHeight >= 600) {
                  config.scrollHeight = 600;
                  config.scrollPhysics = BouncingScrollPhysics();
                } else if (config.scrollHeight <= 200) {
                  config.scrollHeight = 200;
                  config.scrollPhysics = NeverScrollableScrollPhysics();
                }

                setState(() {});
              } ,
              child: SingleChildScrollView(
                physics: config.scrollPhysics,
                controller: controller,
                child: Container(
                  color: Colors.red,
                  height: 1400,
                ),
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
