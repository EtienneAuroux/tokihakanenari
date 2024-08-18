import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';

class SliderShadePicker extends StatefulWidget {
  final double originalShade;
  final Color wheelColor;
  final void Function(double) onNewSliderShade;

  const SliderShadePicker({
    super.key,
    required this.originalShade,
    required this.wheelColor,
    required this.onNewSliderShade,
  });

  @override
  State<SliderShadePicker> createState() => _SliderShadePickerState();
}

class _SliderShadePickerState extends State<SliderShadePicker> {
  final double sliderHeight = 100 * Dimensions.heightUnit;
  late double shadeCursor;

  double getSliderPosition(double pan) {
    if (pan < 0) {
      return 0;
    } else if (pan > sliderHeight) {
      // maybe heightUnit? or SliderHeight?
      return sliderHeight;
    } else {
      return pan;
    }
  }

  @override
  void initState() {
    super.initState();

    shadeCursor = (1 - widget.originalShade) * sliderHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        shadeCursor = getSliderPosition(details.localPosition.dy);
        widget.onNewSliderShade((sliderHeight - shadeCursor) / sliderHeight);
        setState(() {});
      },
      child: Container(
        height: sliderHeight,
        width: 10 * Dimensions.widthUnit,
        padding: EdgeInsets.symmetric(horizontal: 20 * Dimensions.widthUnit),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * Dimensions.heightUnit),
          gradient: LinearGradient(
            colors: [Colors.black, widget.wheelColor, Colors.white],
            stops: const [0, 0.5, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: CustomPaint(
          painter: SliderCursorPainter(
            shadeCursor,
            (1 - widget.originalShade) * sliderHeight,
          ),
        ),
      ),
    );
  }
}

class SliderCursorPainter extends CustomPainter {
  final double position;
  final double originalPosition;

  final double cursorRadius = 10 * Dimensions.heightUnit;

  SliderCursorPainter(
    this.position,
    this.originalPosition,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Paint cursorPaint = Paint()..color = Colors.black.withAlpha(130);
    if (position != originalPosition) {
      canvas.drawCircle(Offset(-15 * Dimensions.widthUnit, originalPosition), cursorRadius, cursorPaint);
    } else {
      canvas.drawCircle(Offset(-15 * Dimensions.widthUnit, position), cursorRadius, cursorPaint);
    }
  }

  @override
  bool shouldRepaint(SliderCursorPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
