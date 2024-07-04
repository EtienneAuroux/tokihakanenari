import 'package:flutter/material.dart';
import 'package:tokihakanenari/carousel.dart';

class MovingBackground extends StatefulWidget {
  final Duration cycle;
  final List<Color> colors;

  const MovingBackground({
    required this.cycle,
    required this.colors,
  });

  @override
  State<MovingBackground> createState() => _MovingBackground();
}

class _MovingBackground extends State<MovingBackground> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.cycle,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final aspectRatio = mediaQueryData.size.height / mediaQueryData.size.width;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.repeated,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: SlideGradient(
                controller.value,
                mediaQueryData.size.height * aspectRatio,
              ),
              colors: widget.colors,
            ),
          ),
          child: Carousel(),
        );
      },
    );
  }
}

class SlideGradient implements GradientTransform {
  final double value;
  final double offset;
  const SlideGradient(this.value, this.offset);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final dist = value * (bounds.width + offset);
    return Matrix4.identity()..translate(dist);
  }
}
