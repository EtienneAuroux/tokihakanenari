import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';
import 'package:tokihakanenari/visual_tools/drop_paths.dart';

class WheelColorPicker extends StatefulWidget {
  final double originalAngle;
  final Color shadedColor;
  final void Function(Color) onNewWheelColor;
  final bool topGradient;

  const WheelColorPicker({
    super.key,
    required this.originalAngle,
    required this.shadedColor,
    required this.onNewWheelColor,
    this.topGradient = true,
  });

  @override
  State<WheelColorPicker> createState() => _WheelColorPickerState();
}

class _WheelColorPickerState extends State<WheelColorPicker> {
  final Offset wheelCenter = Offset(50 * Dimensions.widthUnit, 50 * Dimensions.heightUnit);
  final double wheelRadius = 50;
  late Offset cursorCenter;
  late Color originalColor;

  Offset getCursorPosition(double angle, double wheelRadius) {
    return Offset(
      wheelRadius * (cos(angle) + 1) * Dimensions.heightUnit,
      wheelRadius * (sin(angle) + 1) * Dimensions.heightUnit,
    );
  }

  Color getWheelColor(double angle) {
    angle %= 2 * pi;
    double hue = (angle / pi + 1) * 180 / 60;
    int huePrime = hue.floor() % 6;
    double f = hue - huePrime;
    int v = 255;
    int p = 0;
    int q = (255 * (1 - f)).round();
    int t = (255 * f).round();

    if (huePrime == 0) {
      return Color.fromARGB(255, v, t, p);
    } else if (huePrime == 1) {
      return Color.fromARGB(255, q, v, p);
    } else if (huePrime == 2) {
      return Color.fromARGB(255, p, v, t);
    } else if (huePrime == 3) {
      return Color.fromARGB(255, p, q, v);
    } else if (huePrime == 4) {
      return Color.fromARGB(255, t, p, v);
    } else {
      return Color.fromARGB(255, v, p, q);
    }
  }

  @override
  void initState() {
    super.initState();

    cursorCenter = getCursorPosition(widget.originalAngle, wheelRadius);
    originalColor = widget.shadedColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final Offset pan = details.localPosition - wheelCenter;
        final double angle = atan2(pan.dy, pan.dx);
        widget.onNewWheelColor(getWheelColor(angle));
        setState(() {
          cursorCenter = getCursorPosition(angle, wheelRadius);
        });
      },
      child: CustomPaint(
        size: Size(100 * Dimensions.widthUnit, 100 * Dimensions.heightUnit),
        painter: WheelColorPickerPainter(
          Offset(50 * Dimensions.heightUnit, 50 * Dimensions.heightUnit),
          cursorCenter,
          getCursorPosition(widget.originalAngle, wheelRadius),
          widget.shadedColor,
          originalColor,
          widget.topGradient,
        ),
      ),
    );
  }
}

class WheelColorPickerPainter extends CustomPainter {
  final Offset center;
  final Offset cursorCenter;
  final Offset originalCursorCenter;
  final Color chosenColor;
  final Color originalColor;
  final bool topGradient;

  final double radius = 50 * Dimensions.heightUnit;
  final double cursorRadius = 10 * Dimensions.heightUnit;

  WheelColorPickerPainter(
    this.center,
    this.cursorCenter,
    this.originalCursorCenter,
    this.chosenColor,
    this.originalColor,
    this.topGradient,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wheelPaint = Paint()
      ..strokeWidth = 10 * Dimensions.widthUnit
      ..style = PaintingStyle.stroke
      ..shader = const SweepGradient(
        colors: [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.red,
        ],
        stops: [
          0,
          1 / 3,
          2 / 3,
          1,
        ],
        transform: GradientRotation(pi),
      ).createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ));

    final Paint cursorPaint = Paint()..color = Colors.black.withAlpha(130);

    final Paint choicePaint = Paint()..color = chosenColor;

    // Wheel
    canvas.drawCircle(center, radius, wheelPaint);

    // Cursor
    if (chosenColor == originalColor) {
      canvas.drawCircle(originalCursorCenter, cursorRadius, cursorPaint);
    } else {
      canvas.drawCircle(cursorCenter, cursorRadius, cursorPaint);
    }

    // Choice
    Path path = Path();
    if (topGradient) {
      path.addPath(DropPaths.getPloc(Size(radius, radius)), Offset(radius / 2, radius / 2));
    } else {
      path.addPath(DropPaths.getSplash(Size(radius, radius)), Offset(radius / 2, radius / 2));
    }
    canvas.drawPath(path, choicePaint);
  }

  @override
  bool shouldRepaint(WheelColorPickerPainter oldDelegate) {
    return oldDelegate.cursorCenter != cursorCenter;
  }
}
