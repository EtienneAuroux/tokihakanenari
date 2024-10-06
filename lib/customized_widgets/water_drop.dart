import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';

class WaterDrop extends StatefulWidget {
  final double top;
  final double left;
  final double width;
  final double height;
  final double opacity;

  const WaterDrop({
    super.key,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.opacity,
  });

  @override
  State<WaterDrop> createState() => _WaterDropState();
}

class _WaterDropState extends State<WaterDrop> {
  Alignment get beginAlignment => Alignment(
        widget.left / Dimensions.deviceSize.width - 0.5,
        widget.top / Dimensions.deviceSize.height - 0.5,
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
    Widget dome = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [Colors.grey, Colors.white],
          begin: beginAlignment,
          end: endAlignment,
        ),
        backgroundBlendMode: BlendMode.overlay,
      ),
    );

    return Opacity(
      opacity: widget.opacity,
      child: Stack(
        children: [
          _DropShadow(
            top: widget.top,
            left: widget.left,
            width: widget.width,
            height: widget.height,
          ),
          ClipPath(
            clipper: DropClipper(
              center,
              widget.width,
              widget.height,
            ),
            child: dome,
          ),
          _LightSpot(
            top: widget.top,
            left: widget.left,
            width: widget.width,
            height: widget.height,
          ),
        ],
      ),
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

class _DropShadow extends StatelessWidget {
  final double top;
  final double left;
  final double width;
  final double height;

  const _DropShadow({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.elliptical(width / 2, height / 2),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(4, 4),
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _LightSpot extends StatelessWidget {
  final double top;
  final double left;
  final double width;
  final double height;

  const _LightSpot({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left + width / 4,
      top: top + height / 4,
      width: width / 4,
      height: height / 4,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.elliptical(width / 2, height / 2),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.white.withOpacity(0.9),
            ),
          ],
        ),
      ),
    );
  }
}
