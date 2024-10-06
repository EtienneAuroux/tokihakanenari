import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/water_drop.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';

class FallingDroplets extends StatefulWidget {
  const FallingDroplets({
    super.key,
  });

  @override
  State<FallingDroplets> createState() => _FallingDropletsState();
}

class _FallingDropletsState extends State<FallingDroplets> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late final Animation<double> opacity;
  late final List<Animation<double>> top;

  final Random random = Random();
  final drops = 50;
  late final List<Offset> dropPositions;
  late final List<double> dropSizes;

  @override
  void initState() {
    super.initState();

    dropPositions = List.generate(
      drops,
      (index) => Offset(
        random.nextDouble() * Dimensions.deviceSize.width,
        random.nextDouble() * Dimensions.deviceSize.height,
      ),
    );

    dropSizes = List.generate(
      drops,
      (index) {
        return random.nextDouble() * 20;
      },
    );

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    opacity = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 1, curve: Curves.linear),
      ),
    );

    top = List.generate(
      drops,
      (index) => Tween<double>(
        begin: dropPositions[index].dy,
        end: dropPositions[index].dy + Dimensions.deviceSize.height / 2,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0, 1, curve: Curves.linear),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        drops,
        (index) => AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return WaterDrop(
              top: top[index].value,
              left: dropPositions[index].dx,
              width: dropSizes[index],
              height: dropSizes[index],
              opacity: opacity.value,
            );
          },
        ),
      ),
    );
  }
}
