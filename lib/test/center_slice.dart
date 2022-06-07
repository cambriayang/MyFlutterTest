// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';

class CenterSlice extends StatelessWidget {
  const CenterSlice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CenterSlice"),
      ),
      body: Center(
        child: Column(
          children: [
            _bubbleBody(),
            _arrowBody(),
          ],
        ),
      ),
    );
  }
}

_arrowBody() {
  return Stack(children: <Widget>[
    Positioned(
        child: Image.asset(
          "assets/images/text_bg.png",
          fit: BoxFit.fill,
          centerSlice: Rect.fromLTRB(10.0, 2.0, 12.0, 46.0),
          // centerSlice: Rect.fromLTWH(10.0, 2.0, 15.0, 40.0),
        ),
        left: 0.0,
        right: 0.0,
        top: 0.0,
        bottom: 0.0),
    Container(
      width: 200,
      height: 60,
      alignment: Alignment.centerLeft,
      child: Text("#" + "全新为拆封未激活平果",
          style: TextStyle(fontSize: 12.0, color: Colors.white),
          textAlign: TextAlign.center),
      padding: EdgeInsets.only(left: 20),
    ),
  ]);
}

_bubbleBody() {
  return Container(
    alignment: Alignment.centerLeft,
    child: Stack(
      children: [
        // Container(
        //   margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        //   child: Image.asset('assets/images/sanjiao.png'),
        // ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              centerSlice: Rect.fromLTWH(19, 13, 8, 8),
              image: AssetImage('assets/images/icon_bubble.png'),
            ),
          ),
          constraints: const BoxConstraints(minWidth: 48, maxWidth: 480),
          padding: const EdgeInsets.fromLTRB(18.5, 3.0, 14.5, 20.0),
          child: const Text(
            '点xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx点xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx点xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx点xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx点xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx点xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15.0,
            ),
          ),
        ),
      ],
    ),
  );
}
