import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class YSListener extends StatefulWidget {
  final PointerDownEventListener? onPointerDown;
  final PointerMoveEventListener? onPointerMove;
  final PointerUpEventListener? onPointerUp;
  final PointerCancelEventListener? onPointerCancel;
  final PointerEnterEventListener? onPointerEnter;
  final PointerExitEventListener? onPointerExit;
  final PointerHoverEventListener? onPointerHover;
  final PointerSignalEventListener? onPointerSignal;
  final Widget child;

  const YSListener(
      {Key? key,
      this.onPointerDown,
      required this.child,
      this.onPointerMove,
      this.onPointerUp,
      this.onPointerCancel,
      this.onPointerEnter,
      this.onPointerExit,
      this.onPointerHover,
      this.onPointerSignal})
      : super(key: key);

  @override
  _YSListenerState createState() {
    return _YSListenerState();
  }

  MultiDragGestureRecognizer createRecognizer(onStart) {
    return ImmediateMultiDragGestureRecognizer()..onStart = onStart;
  }
}

class _YSListenerState extends State<YSListener> {
  late GestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = ImmediateMultiDragGestureRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _recognizer.addPointer(event);
        // GestureBinding.instance.gestureArena.add(event.pointer, _recognizer);
        if (widget.onPointerDown != null) widget.onPointerDown!(event);
      },
      onPointerMove: widget.onPointerMove,
      onPointerUp: widget.onPointerUp,
      // others
      onPointerCancel: widget.onPointerCancel,
      onPointerHover: widget.onPointerHover,
      onPointerSignal: widget.onPointerSignal,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _recognizer.dispose();
  }
}
