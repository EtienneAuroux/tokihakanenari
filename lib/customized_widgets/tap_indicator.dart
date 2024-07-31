import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';

class TapIndicator extends StatefulWidget {
  final Size size;
  final bool animationOn;

  const TapIndicator({
    super.key,
    required this.size,
    this.animationOn = true,
  });

  @override
  State<TapIndicator> createState() => _TapIndicatorState();
}

class _TapIndicatorState extends State<TapIndicator> with TickerProviderStateMixin {
  final double beginIconSize = 50;
  final double endIconSize = 45;

  late AnimationController controller;
  late final Animation<double> left;
  late final Animation<double> top;
  late final Animation<double> iconSize;
  late final Animation<double> circleRadius;

  final Animatable<double> doubleClick = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 50, end: 40).chain(CurveTween(curve: Curves.linear)),
      weight: 1,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 40, end: 50).chain(CurveTween(curve: Curves.linear)),
      weight: 1,
    ),
  ]);

  final Animatable<double> circleExpansion = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0, end: 50).chain(CurveTween(curve: Curves.linear)),
      weight: 1,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 50, end: 0).chain(CurveTween(curve: Curves.linear)),
      weight: 1,
    ),
  ]);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    left = Tween<double>(begin: -100, end: (widget.size.width - beginIconSize) / 2)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0.5, 0.9, curve: Curves.linear)));
    top = Tween<double>(begin: widget.size.height, end: (widget.size.height - beginIconSize) / 2 - 50)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0.5, 0.9, curve: Curves.linear)));

    iconSize = doubleClick.animate(CurvedAnimation(parent: controller, curve: const Interval(0.9, 1, curve: Curves.linear)));

    circleRadius = circleExpansion.animate(CurvedAnimation(parent: controller, curve: const Interval(0.9, 1, curve: Curves.linear)));

    if (!widget.animationOn) {
      controller.dispose();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              Positioned(
                  left: left.value,
                  top: top.value,
                  width: iconSize.value,
                  child: Stack(
                    children: [
                      Icon(
                        FontAwesome5.hand_point_up,
                        size: iconSize.value,
                      ),
                      CustomPaint(
                        size: widget.size,
                        painter: ClickCircle(const Offset(20, 0), circleRadius.value),
                      )
                    ],
                  )),
            ],
          );
        });
  }
}

class ClickCircle extends CustomPainter {
  final Offset center;
  final double radius;

  ClickCircle(this.center, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
