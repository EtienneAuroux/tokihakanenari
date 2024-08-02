import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/drop_paths.dart';

class WheelColorPicker extends StatefulWidget {
  final Color shadedColor;
  final void Function(Color) onNewWheelColor;

  const WheelColorPicker({
    super.key,
    required this.shadedColor,
    required this.onNewWheelColor,
  });

  @override
  State<WheelColorPicker> createState() => _WheelColorPickerState();
}

class _WheelColorPickerState extends State<WheelColorPicker> {
  final Offset wheelCenter = const Offset(50, 50);
  late Offset cursorCenter;
  late Color chosenColor;

  Offset getCursorPosition(double angle, double wheelRadius) {
    return Offset(wheelRadius * (cos(angle) + 1), wheelRadius * (sin(angle) + 1));
  }

  Color getWheelColor(double angle) {
    double hue = (angle / pi + 1) * 180 / 60;
    int huePrime = hue.floor();
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

    cursorCenter = getCursorPosition(0, 50);
    chosenColor = getWheelColor(0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final pan = details.localPosition - wheelCenter;
        final double angle = atan2(pan.dy, pan.dx);
        widget.onNewWheelColor(getWheelColor(angle));
        setState(() {
          cursorCenter = getCursorPosition(angle, 50);
        });
      },
      child: CustomPaint(
        size: const Size(100, 100),
        painter: WheelColorPickerPainter(
          const Offset(50, 50),
          cursorCenter,
          widget.shadedColor,
        ),
      ),
    );
  }
}

class WheelColorPickerPainter extends CustomPainter {
  final Offset center;
  final Offset cursorCenter;
  final Color chosenColor;

  final double radius = 50;
  final double cursorRadius = 10;

  WheelColorPickerPainter(this.center, this.cursorCenter, this.chosenColor);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wheelPaint = Paint()
      ..strokeWidth = 10
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
    canvas.drawCircle(cursorCenter, cursorRadius, cursorPaint);

    // Choice
    Path path = Path();
    path.addPath(DropPaths.getSplash(Size(radius, radius)), Offset(radius / 2, radius / 2));
    canvas.drawPath(path, choicePaint);
    // canvas.drawCircle(center, radius / 2, choicePaint);
  }

  @override
  bool shouldRepaint(WheelColorPickerPainter oldDelegate) {
    return oldDelegate.cursorCenter != cursorCenter;
  }
}
