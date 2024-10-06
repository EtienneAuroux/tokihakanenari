import 'package:flutter/material.dart';

class SlidingColors extends StatefulWidget {
  final List<Color> colors;
  final Widget child;

  const SlidingColors({
    super.key,
    required this.colors,
    required this.child,
  });

  @override
  State<SlidingColors> createState() => _SlidingColorsState();
}

class _SlidingColorsState extends State<SlidingColors> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 4),
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
              colors: List.generate(widget.colors.length + 1, (index) {
                if (index < widget.colors.length) {
                  return widget.colors[index];
                } else {
                  return widget.colors.first;
                }
              }),
            ),
          ),
          child: widget.child,
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
