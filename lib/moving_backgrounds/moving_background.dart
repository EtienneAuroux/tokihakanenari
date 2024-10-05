import 'package:flutter/material.dart';
import 'package:tokihakanenari/moving_backgrounds/falling_droplets.dart';
import 'package:tokihakanenari/moving_backgrounds/floating_waves.dart';
import 'package:tokihakanenari/moving_backgrounds/sliding_colors.dart';
import 'package:tokihakanenari/my_enums.dart';

class MovingBackground extends StatefulWidget {
  final Background background;
  final List<Color> colors;
  final Widget child;

  const MovingBackground({
    super.key,
    required this.background,
    required this.colors,
    required this.child,
  });

  @override
  State<MovingBackground> createState() => _MovingBackgroundState();
}

class _MovingBackgroundState extends State<MovingBackground> {
  Widget getBackground(Background background) {
    switch (background) {
      case Background.waves:
        return FloatingWaves(colors: widget.colors, child: widget.child);
      case Background.slices:
        return SlidingColors(colors: widget.colors, child: widget.child);
      case Background.rain:
        return FallingDroplets(colors: widget.colors, child: widget.child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return getBackground(widget.background);
  }
}
