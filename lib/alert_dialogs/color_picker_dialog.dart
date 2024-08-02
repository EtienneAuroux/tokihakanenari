import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class ColorPickerDialog extends StatefulWidget {
  final List<Color> originalGradient;

  const ColorPickerDialog({
    super.key,
    required this.originalGradient,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  final Offset wheelCenter = const Offset(50, 50);
  late Offset cursorCenter;
  double shadeCursor = 50;
  late Color shadeColor;

  Offset getCursorPosition(double angle, double wheelRadius) {
    return Offset(wheelRadius * (cos(angle) + 1), wheelRadius * (sin(angle) + 1));
  }

  double getSliderPosition(double pan) {
    if (pan < 0) {
      return 0;
    } else if (pan > 100) {
      return 100;
    } else {
      return pan;
    }
  }

  Color getWheelColor(double angle) {
    double x = 1 - (angle / 60) % 2 - 1;
    return Colors.red;
  }

  @override
  void initState() {
    super.initState();

    cursorCenter = getCursorPosition(0, 50);
    shadeColor = getWheelColor(0);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Gradient creator',
            style: TextStyles.dialogTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'top right:',
                style: TextStyles.dialogText,
              ),
              GestureDetector(
                onPanUpdate: (details) {
                  final pan = details.localPosition - wheelCenter;
                  final double angle = atan2(pan.dy, pan.dx);
                  setState(() {
                    cursorCenter = getCursorPosition(angle, 50);
                  });
                },
                child: CustomPaint(
                  size: const Size(100, 100),
                  painter: ColorPickerPainter(const Offset(50, 50), cursorCenter),
                ),
              ),
              GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    shadeCursor = getSliderPosition(details.localPosition.dy);
                  });
                },
                child: Container(
                  height: 100,
                  width: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [Colors.black, shadeColor, Colors.white],
                      stops: const [0, 0.5, 1],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: CustomPaint(
                    painter: SliderCursorPainter(shadeCursor),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ColorPickerPainter extends CustomPainter {
  final Offset center;
  final Offset cursorCenter;

  final double radius = 50;
  final double cursorRadius = 10;

  ColorPickerPainter(
    this.center,
    this.cursorCenter,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wheelPaint = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..shader = const SweepGradient(colors: [
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.red,
      ], stops: [
        0,
        1 / 3,
        2 / 3,
        1,
      ]).createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ));

    final Paint cursorPaint = Paint()..color = Colors.black.withAlpha(130);

    canvas.drawCircle(center, radius, wheelPaint);
    canvas.drawCircle(cursorCenter, cursorRadius, cursorPaint);
  }

  @override
  bool shouldRepaint(ColorPickerPainter oldDelegate) {
    return oldDelegate.cursorCenter != cursorCenter;
  }
}

class SliderCursorPainter extends CustomPainter {
  final double position;

  final double cursorRadius = 10;

  SliderCursorPainter(
    this.position,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Paint cursorPaint = Paint()..color = Colors.black.withAlpha(130);
    canvas.drawCircle(Offset(-15, position), cursorRadius, cursorPaint);
  }

  @override
  bool shouldRepaint(SliderCursorPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
