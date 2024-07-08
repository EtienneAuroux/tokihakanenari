import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class LargeCardContour extends CustomClipper<Path> {
  final double flippedDistance;

  LargeCardContour({required this.flippedDistance});

  Point calculateCornerPoint(Size size, double cord, double cornerOffset) {
    // The radius of the circle on which the corner travels.
    final double radius = (size.height / 3) / 2 + pow(2 * size.width, 2) / (8 * size.height / 3);

    // The angle of the bottom left corner of the screen if it was on a circle of [radius].
    final double initialAngle = cos((radius - (size.width - cornerOffset)) / radius);

    // The angle of the new point, assuming small increments.
    double angle = initialAngle + cord / radius;

    return Point(
      size.width - cornerOffset - (radius * cos(angle) - (radius - (size.width))),
      size.height + cornerOffset - (radius * sin(angle) - (radius - size.height / 3)),
    );
  }

  @override
  Path getClip(Size size) {
    final double flippedCornerLength = size.shortestSide / 5;

    Point cornerControl = calculateCornerPoint(size, flippedDistance, flippedCornerLength);

    Point topLeft = Point(0, cornerControl.y - flippedDistance * 1.65);
    if (topLeft.y < 0) {
      topLeft = Point(flippedDistance - cornerControl.y / 1.65, 0);
    }

    Point bottomRight = Point(cornerControl.x - flippedDistance * 0.25, size.height);
    if (bottomRight.x > size.width) {
      bottomRight = Point(size.width, size.height);
    }

    Path path = Path();
    path.lineTo(topLeft.x.toDouble(), topLeft.y.toDouble());
    path.lineTo(bottomRight.x.toDouble(), bottomRight.y.toDouble());
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(topLeft.x.toDouble(), 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class FlippedCornerContour extends CustomClipper<Path> {
  final double flippedDistance;

  FlippedCornerContour({required this.flippedDistance});

  Point calculateCornerPoint(Size size, double cord, double cornerOffset) {
    // The radius of the circle on which the corner travels.
    final double radius = (size.height / 3) / 2 + pow(2 * size.width, 2) / (8 * size.height / 3);

    // The angle of the bottom left corner of the screen if it was on a circle of [radius].
    final double initialAngle = cos((radius - (size.width - cornerOffset)) / radius);

    // The angle of the new point, assuming small increments.
    double angle = initialAngle + cord / radius;

    return Point(
      size.width - cornerOffset - (radius * cos(angle) - (radius - (size.width))),
      size.height + cornerOffset - (radius * sin(angle) - (radius - size.height / 3)),
    );
  }

  @override
  Path getClip(Size size) {
    final double flippedCornerLength = size.shortestSide / 5;
    final double cornerRadius = size.shortestSide / 10;

    Point cornerControl = calculateCornerPoint(size, flippedDistance, flippedCornerLength);

    Point topLeft = Point(0, cornerControl.y - flippedDistance * 1.65);
    Point top = topLeft;
    if (topLeft.y < 0) {
      topLeft = Point(flippedDistance - cornerControl.y / 1.65, 0);
      top = Point(topLeft.x * 1.3, topLeft.y);
    }

    Point bottomRight = Point(cornerControl.x - flippedDistance * 0.25, size.height);
    if (bottomRight.x > size.width) {
      bottomRight = Point(size.width, size.height);
    }

    double cornerBottomInclination = atan((cornerControl.x - bottomRight.x) / (bottomRight.y - cornerControl.y));

    Point cornerBottom = Point(
      cornerControl.x - cornerRadius * sin(cornerBottomInclination),
      cornerControl.y + cornerRadius * cos(cornerBottomInclination),
    );

    double cornerLeftInclination = atan((cornerControl.y - topLeft.y) / cornerControl.x);

    Point cornerLeft = Point(
      cornerControl.x - cornerRadius * cos(cornerLeftInclination),
      cornerControl.y - cornerRadius * sin(cornerLeftInclination),
    );

    Path path = Path();
    path.moveTo(topLeft.x.toDouble(), topLeft.y.toDouble());
    path.lineTo(bottomRight.x.toDouble(), bottomRight.y.toDouble());
    path.lineTo(cornerBottom.x.toDouble(), cornerBottom.y.toDouble());
    path.quadraticBezierTo(
      cornerControl.x.toDouble(),
      cornerControl.y.toDouble(),
      cornerLeft.x.toDouble(),
      cornerLeft.y.toDouble(),
    );
    path.lineTo(top.x.toDouble(), top.y.toDouble());
    path.lineTo(topLeft.x.toDouble(), topLeft.y.toDouble());

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
