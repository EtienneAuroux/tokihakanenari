import 'package:flutter/material.dart';

class FloatingWaves extends StatefulWidget {
  /// Two colors are recommended.
  final List<Color> colors;
  final Widget child;

  const FloatingWaves({super.key, required this.colors, required this.child});

  @override
  State<FloatingWaves> createState() => _FloatingWaves();
}

class _FloatingWaves extends State<FloatingWaves> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Alignment> topAnimation;
  late Animation<Alignment> bottomAnimation;
  late Animation<Alignment> topAnimationLandscape;
  late Animation<Alignment> bottomAnimationLandscape;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 15));

    topAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.topRight, end: Alignment.centerLeft), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.centerLeft, end: Alignment.center), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.center, end: Alignment.centerRight), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.centerRight, end: Alignment.topLeft), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.topRight, end: Alignment.topRight), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.topRight, end: Alignment.topCenter), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.topCenter, end: Alignment.topLeft), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topLeft), weight: 1),
    ]).animate(animationController);

    bottomAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.bottomRight, end: Alignment.bottomRight), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.bottomRight, end: Alignment.bottomRight), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.bottomRight, end: Alignment.bottomCenter), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.bottomCenter, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.bottomLeft, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.bottomLeft, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.bottomLeft, end: Alignment.centerLeft), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.centerLeft, end: Alignment.center), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.center, end: Alignment.centerRight), weight: 1),
      TweenSequenceItem<Alignment>(tween: Tween<Alignment>(begin: Alignment.centerRight, end: Alignment.bottomRight), weight: 1),
    ]).animate(animationController);

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.colors,
                begin: topAnimation.value,
                end: bottomAnimation.value,
              ),
            ),
            child: widget.child,
          );
        });
  }
}
