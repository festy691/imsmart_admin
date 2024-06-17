import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnSelectedCallback = Function(num value);

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final title;
  OnSelectedCallback onSelected;

  SliderWidget(
      {this.sliderHeight = 130,
      required this.onSelected,
      this.max = 12,
      this.min = 0,
      this.fullWidth = false,
      this.title = "months"});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 5.5,
      height: widget.sliderHeight,
      child: Column(
        children: [
          Container(
            width: this.widget.fullWidth
                ? double.infinity
                : (this.widget.sliderHeight) * 5.5,
            height: 50,
            decoration: BoxDecoration(
              color: Pallet.grey.withOpacity(0.7),
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Pallet.colorPrimary.withOpacity(0.2)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                ),
                TextView(
                  text:
                      '${(widget.min + (widget.max - widget.min) * _value).round()}',
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w600,
                    color: Pallet.black,
                  ),
                ),
                TextView(
                  text: '${widget.title}',
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w400,
                    color: Pallet.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Pallet.colorPrimary,
              inactiveTrackColor: Pallet.grey.withOpacity(0.4),
              trackHeight: 7.0,
              trackShape: CustomTrackShape(),
              thumbShape: CustomSliderThumbCircle(
                thumbRadius: this.widget.sliderHeight * .15,
                min: this.widget.min,
                max: this.widget.max,
              ),
              overlayColor: Pallet.colorPrimaryLight.withOpacity(.4),
              valueIndicatorColor: Pallet.colorPrimary,
              activeTickMarkColor: Pallet.colorPrimary,
              inactiveTickMarkColor: Pallet.grey,
            ),
            child: Slider(
                value: _value,
                onChanged: (value) {
                  _value = value;
                  widget.onSelected(
                      (widget.min + (widget.max - widget.min) * _value)
                          .round());
                  if (mounted) {
                    setState(() {});
                  }
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (_value != 0.0)
                TextView(
                  text: '${this.widget.min}',
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(10),
                    fontWeight: FontWeight.w400,
                    color: Pallet.black,
                  ),
                ),
              SizedBox(
                width: 20,
              ),
              if (_value != 1.0)
                TextView(
                  text: '${this.widget.max}',
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(10),
                    fontWeight: FontWeight.w400,
                    color: Pallet.black,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Pallet.red //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: ScreenUtil().setSp(10),
        fontWeight: FontWeight.w700,
        color: Pallet.black, //Text Color of Value on Thumb
      ),
      text: getValue(value!),
    );

    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy + (tp.height * 1.5));

    canvas.drawCircle(center, 8, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
