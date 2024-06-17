import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class ImageScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;
  final double height;

  ImageScannerAnimation({Key? key, required this.stopped, required this.width, required this.height, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Animation<double?> get listenableValue => listenable as Animation<double?>;
  Widget build(BuildContext context) {
    final Animation<double?> animation = listenableValue;
    final scorePosition = (animation.value! * 440) + 16;

    Color color1 = Color(0x55226AB4);
    Color color2 = Color(0x00226AB4);

    if (animation.status == AnimationStatus.reverse) {
      color1 = Color(0x00226AB4);
      color2 = Color(0x55226AB4);
    }

    return new Positioned(
        bottom: scorePosition,
        child: new Opacity(
            opacity: (stopped) ? 0.0 : 1.0,
            child: Container(
              height: height,
              width: width,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.9],
                    colors: [color1, color2],
                  )),
            )));
  }
}