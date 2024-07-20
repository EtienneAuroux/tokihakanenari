import 'package:flutter/material.dart';
import 'package:tokihakanenari/carousel.dart';
import 'package:tokihakanenari/my_enums.dart';

class SlidingColors extends StatefulWidget {
  /// At least four colors are recommended.
  final List<Color> colors;
  final Widget child;

  const SlidingColors({
    super.key,
    required this.colors,
    required this.child,
  });

  @override
  State<SlidingColors> createState() => _SlidingColors();
}

class _SlidingColors extends State<SlidingColors> with SingleTickerProviderStateMixin {
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
              colors: widget.colors,
            ),
          ),
          child: Carousel(
            cardStatus: CardStatus.inert,
            onRequestBigCard: (cardType) {},
          ),
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
