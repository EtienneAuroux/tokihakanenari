import 'dart:math';

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
  final double flippedDistance;

  FlippedCornerContour({required this.flippedDistance});

  @override
  Path getClip(Size size) {
    Path path = Path();

    final double flippedCornerLength = size.shortestSide / 5;
    final double cornerRadius = size.shortestSide / 10;

    Point topLeft = Point(0, size.height - flippedCornerLength - flippedDistance * 2);
    if (topLeft.y < 0) {
      topLeft = Point(flippedDistance - (size.height - flippedCornerLength) / 2, 0);
    }

    Point bottomRight = Point(flippedCornerLength + flippedDistance, size.height);
    if (bottomRight.x > size.width) {
      bottomRight = Point(size.width, size.height);
    }

    Point cornerBottom = Point(
      flippedCornerLength,
      size.height - (flippedCornerLength - cornerRadius),
    );

    Point cornerLeft = Point(
      flippedCornerLength - cornerRadius,
      size.height - flippedCornerLength,
    );

    Point cornerControl = Point(
      flippedCornerLength + flippedDistance * 1.5,
      size.height - flippedCornerLength - flippedDistance * 0.25,
    );
    if (cornerControl.x > size.width) {
      cornerControl = Point(size.width, size.height - flippedCornerLength - flippedDistance * 0.25);
    }

    path.moveTo(topLeft.x.toDouble(), topLeft.y.toDouble());
    path.lineTo(bottomRight.x.toDouble(), bottomRight.y.toDouble());
    path.lineTo(cornerBottom.x.toDouble(), cornerBottom.y.toDouble());
    path.quadraticBezierTo(
      cornerControl.x.toDouble(),
      cornerControl.y.toDouble(),
      cornerLeft.x.toDouble(),
      cornerLeft.y.toDouble(),
    );
    path.lineTo(topLeft.x.toDouble(), topLeft.y.toDouble());

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
