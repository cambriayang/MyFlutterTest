import 'package:flutter/material.dart';

class CenterSlice extends StatelessWidget {
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
          ],
        ),
      ),
    );
  }
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
