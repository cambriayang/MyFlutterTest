// ignore_for_file: use_key_in_widget_constructors

/*********************************************************************************
 * Author: Argost Ye
 * Time: 1/18/22
 **********************************************************************************/
import 'package:flutter/material.dart';
import 'dart:ui';

class GradientButton extends StatelessWidget {
  final List<Color>? colors;
  final double? width;
  final double? height;
  final Widget child;
  final BorderRadius? borderRadius;
  final GestureTapCallback? onPressed;

  const GradientButton(
      {Key? key,
      this.colors,
      this.width,
      this.height,
      this.borderRadius,
      this.onPressed,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: height,
              width: width,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientButtonRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GradientButtonRouteState();
  }
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  onTap() {
    print("Button clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            GradientButton(
              child: Text("Submit"),
              colors: [Colors.orange, Colors.red],
              height: 50.0,
            ),
            GradientButton(
              child: Text("Submit"),
              height: 50,
              colors: [Colors.lightGreen, Colors.green],
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightBlue, Colors.blueAccent],
              child: Text("Submit"),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
