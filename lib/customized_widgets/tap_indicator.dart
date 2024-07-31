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

  final Animatable<double> doubleClick = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 50, end: 45).chain(CurveTween(curve: Curves.linear)),
      weight: 1,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 45, end: 50).chain(CurveTween(curve: Curves.linear)),
      weight: 1,
    ),
  ]);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    left = Tween<double>(begin: -100, end: (widget.size.width - beginIconSize) / 2)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0, 0.8, curve: Curves.linear)));
    top = Tween<double>(begin: widget.size.height, end: (widget.size.height - beginIconSize) / 2)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0, 0.8, curve: Curves.linear)));

    iconSize = doubleClick.animate(CurvedAnimation(parent: controller, curve: const Interval(0.8, 1, curve: Curves.linear)));

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
                child: Icon(
                  FontAwesome5.hand_point_up,
                  size: iconSize.value,
                ),
              )
            ],
          );
        });
    // Size size = MediaQuery.of(context).size;
    // return Stack(
    //   children: [
    //     PositionedTransition(
    //       rect: RelativeRectTween(
    //         begin: RelativeRect.fromSize(
    //           Rect.fromLTWH(-size.width - 50, 50, iconSize.width, iconSize.height),
    //           iconSize,
    //         ),
    //         end: RelativeRect.fromSize(
    //           Rect.fromLTWH(0, 0, iconSize.width, iconSize.height),
    //           iconSize,
    //         ),
    //       ).animate(CurvedAnimation(parent: controller, curve: Curves.linear)),
    //       child: const Icon(FontAwesome5.hand_point_up),
    //     )
    //   ],
    // );
  }
}
