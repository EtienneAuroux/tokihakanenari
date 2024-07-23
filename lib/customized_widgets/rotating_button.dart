import 'package:flutter/material.dart';

class RotatingButton extends StatefulWidget {
  final IconData iconData;
  final void Function(bool) onPressed;

  const RotatingButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  State<RotatingButton> createState() => _RotatingButtonState();
}

class _RotatingButtonState extends State<RotatingButton> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  bool rotated = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          rotated = !rotated;
          if (!rotated) {
            controller.reverse(from: 0.5);
          } else {
            controller.forward(from: 0.0);
          }
          widget.onPressed(rotated);
        },
        icon: Icon(
          widget.iconData,
          size: 40,
        ),
      ),
    );
  }
}
