import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';

class Rain extends StatefulWidget {
  const Rain({
    super.key,
  });

  @override
  State<Rain> createState() => _RainState();
}

class _RainState extends State<Rain> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [for (int i = 0; i < 200; i++) const _RainDrop()],
    );
  }
}

class _RainDrop extends StatefulWidget {
  const _RainDrop({
    super.key,
  });

  @override
  State<_RainDrop> createState() => _RainDropState();
}

class _RainDropState extends State<_RainDrop> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  late double dx, dy;
  Random random = Random();

  @override
  void initState() {
    super.initState();

    dx = random.nextDouble() * Dimensions.deviceSize.width;
    dy = random.nextDouble() * -500;

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: random.nextInt(3000)),
    );

    animation = Tween<double>(
      begin: dy,
      end: Dimensions.deviceSize.height,
    ).animate(animationController);

    animationController.forward();

    animationController.addListener(() {
      if (animation.isCompleted) {
        animationController.reset();
        dx = random.nextDouble() * Dimensions.deviceSize.width;
        dy = random.nextDouble() * -500;
        animationController.duration = Duration(milliseconds: random.nextInt(3000));
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(dx, animation.value),
          child: Container(
            height: 20,
            width: 2,
            decoration: const BoxDecoration(color: Colors.white),
          ),
        );
      },
    );
  }
}
