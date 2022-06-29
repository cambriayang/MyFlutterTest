// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

/*********************************************************************************
 * Author: Argost Ye
 * Time: 1/13/22
 **********************************************************************************/
import 'package:flutter/material.dart';

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            InkWell(
              child: Hero(
                tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/sanjiao.png",
                    width: 50.0,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return HeroAnimationRouteB();
                  },
                ));

                //打开B路由
                // Navigator.push(context, PageRouteBuilder(
                //   pageBuilder: (
                //       BuildContext context,
                //       animation,
                //       secondaryAnimation,
                //       ) {
                //     return FadeTransition(
                //       opacity: animation,
                //       child: Scaffold(
                //         appBar: AppBar(
                //           title: Text("原图"),
                //         ),
                //         body: HeroAnimationRouteB(),
                //       ),
                //     );
                //   },
                // ));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("点击头像"),
            )
          ],
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  Future<bool> onBackPress() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        appBar: AppBar(
        title: Text("$runtimeType"),
        ),
        body: Center(
          child: Hero(
            tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
            child: Image.asset("assets/images/sanjiao.png"),
          ),
        ),
      ),
    );
  }
}
