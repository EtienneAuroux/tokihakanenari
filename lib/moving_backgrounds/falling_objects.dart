import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';

class FallingObjects extends StatefulWidget {
  final Weather weather;

  const FallingObjects({
    super.key,
    required this.weather,
  });

  @override
  State<FallingObjects> createState() => _FallingObjectsState();
}

class _FallingObjectsState extends State<FallingObjects> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [for (int i = 0; i < 200; i++) _FallingObject(widget.weather)],
    );
  }
}

class _FallingObject extends StatefulWidget {
  final Weather weather;

  const _FallingObject(this.weather);

  @override
  State<_FallingObject> createState() => _FallingObjectState();
}

class _FallingObjectState extends State<_FallingObject> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  late double dx, dy, dz, length;
  Random random = Random();

  double mapNumericalRanges(double x, double inMin, double inMax, double outMin, double outMax) {
    return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  Container getObject(Weather weather) {
    switch (weather) {
      case Weather.none:
        return Container();
      case Weather.rain:
        return Container(
          height: length,
          width: 2 * Dimensions.widthUnit,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5 * Dimensions.widthUnit),
            border: Border.all(
              width: mapNumericalRanges(
                dz,
                0,
                20 * Dimensions.widthUnit,
                1 * Dimensions.widthUnit,
                3 * Dimensions.widthUnit,
              ),
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        );
      case Weather.snow:
        return Container(
          width: length,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.4),
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();

    dx = random.nextDouble() * Dimensions.deviceSize.width;
    dy = random.nextDouble() * (-Dimensions.deviceSize.height);
    dz = random.nextDouble() * 20;
    length = mapNumericalRanges(
      dz,
      0,
      20 * Dimensions.heightUnit,
      10 * Dimensions.heightUnit,
      20 * Dimensions.heightUnit,
    );

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mapNumericalRanges(dz, 0, 20, 3500, 500).toInt()),
    );

    animation = Tween<double>(
      begin: dy,
      end: Dimensions.deviceSize.height,
    ).animate(animationController);

    animationController.forward();

    animationController.addListener(listener);
  }

  void listener() {
    if (animation.isCompleted) {
      animationController.reset();
      dx = random.nextDouble() * Dimensions.deviceSize.width;
      dy = random.nextDouble() * (-Dimensions.deviceSize.height);
      dz = random.nextDouble() * 20;
      length = mapNumericalRanges(
        dz,
        0,
        20 * Dimensions.heightUnit,
        10 * Dimensions.heightUnit,
        20 * Dimensions.heightUnit,
      );
      animationController.duration = Duration(milliseconds: mapNumericalRanges(dz, 0, 20, 3500, 500).toInt());
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.removeListener(listener);
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(dx, animation.value),
          child: getObject(widget.weather),
        );
      },
    );
  }
}
