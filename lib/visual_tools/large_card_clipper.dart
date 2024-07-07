import 'package:flutter/material.dart';

class LargeCardContour extends CustomClipper<Path> {
  final double flippedCornerLength;

  LargeCardContour({required this.flippedCornerLength});

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Left vertical line
    path.lineTo(0, size.height - flippedCornerLength);

    // Bottom left corner diagonal line
    path.lineTo(flippedCornerLength, size.height);

    // Bottom horizontal line
    path.lineTo(size.width, size.height);

    // Right vertical line
    path.lineTo(size.width, 0);

    // Top horizontal line
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class FlippedCornerContour extends CustomClipper<Path> {
  final double _flippedCornerLength;
  final double _cornerRadius;

  FlippedCornerContour({
    required double flippedCornerLength,
    required double cornerRadius,
  })  : assert(flippedCornerLength >= cornerRadius),
        _flippedCornerLength = flippedCornerLength,
        _cornerRadius = cornerRadius;

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height - _flippedCornerLength);
    path.lineTo(_flippedCornerLength, size.height);
    path.lineTo(_flippedCornerLength, size.height - (_flippedCornerLength - _cornerRadius));
    path.quadraticBezierTo(
      _flippedCornerLength,
      size.height - _flippedCornerLength,
      _flippedCornerLength - _cornerRadius,
      size.height - _flippedCornerLength,
    );
    path.lineTo(0, size.height - _flippedCornerLength);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
