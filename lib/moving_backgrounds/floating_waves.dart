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
  late Animation<Alignment> portraitAnimation;
  late Animation<Alignment> landscapeAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    portraitAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.centerRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin: Alignment.centerLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      )
    ]).animate(animationController);

    landscapeAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.center,
        ),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin: Alignment.center,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      )
    ]).animate(animationController);

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.colors,
                begin: portraitAnimation.value,
                end: Alignment.bottomRight,
              ),
            ),
            child: widget.child,
          );
        });
  }
}
