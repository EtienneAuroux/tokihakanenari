import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';
import 'dart:developer' as developer;

class WaterDrop extends StatefulWidget {
  final double top;
  final double left;
  final double width;
  final double height;

  const WaterDrop({
    super.key,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
  });

  @override
  State<WaterDrop> createState() => _WaterDropState();
}

class _WaterDropState extends State<WaterDrop> {
  Alignment get beginAlignment => Alignment(
        widget.left / Dimensions.deviceSize.width,
        widget.top / Dimensions.deviceSize.height,
      );

  Alignment get endAlignment => Alignment(
        (widget.left + widget.width) / Dimensions.deviceSize.width,
        (widget.top + widget.height) / Dimensions.deviceSize.height,
      );

  Offset get center => Offset(
        widget.left + widget.width / 2,
        widget.top + widget.height / 2,
      );
  @override
  Widget build(BuildContext context) {
    developer.log('begin: $beginAlignment, end: $endAlignment');
    Widget dome = Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.white],
          begin: beginAlignment,
          end: endAlignment,
        ),
        backgroundBlendMode: BlendMode.overlay,
      ),
    );

    return ClipPath(
      clipper: DropClipper(
        center,
        widget.width,
        widget.height,
      ),
      child: dome,
    );
  }
}

class DropClipper extends CustomClipper<Path> {
  final Offset center;
  final double width;
  final double height;

  DropClipper(this.center, this.width, this.height);

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCenter(
          center: center,
          width: width,
          height: height,
        ),
      );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
