import 'package:flutter/material.dart';

class LargeCardContour extends CustomClipper<Path> {
  final double _flippedCornerLength;
  final double _cornerRadius;

  LargeCardContour({
    required double flippedCornerLength,
    required double cornerRadius,
  })  : assert(flippedCornerLength >= cornerRadius),
        _flippedCornerLength = flippedCornerLength,
        _cornerRadius = cornerRadius;

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Left vertical line
    path.moveTo(0, _cornerRadius);
    path.lineTo(0, size.height - _flippedCornerLength);

    // Bottom left corner diagonal line
    path.lineTo(_flippedCornerLength, size.height);

    // Bottom horizontal line
    path.lineTo(size.width - _cornerRadius, size.height);

    // Bottom right corner
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - _cornerRadius);

    // Right vertical line
    path.lineTo(size.width, _cornerRadius);

    // Top right conner
    path.quadraticBezierTo(size.width, 0, size.width - _cornerRadius, 0);

    // Top horizontal line
    path.lineTo(_cornerRadius, 0);

    // Top left corner
    path.quadraticBezierTo(0, 0, 0, _cornerRadius);

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
