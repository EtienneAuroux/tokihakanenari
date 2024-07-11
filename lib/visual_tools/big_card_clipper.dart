import 'dart:math';
import 'dart:ui';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/drop_paths.dart';

class BigCardContour extends CustomClipper<Path> {
  final double flippedDistance;
  final bool droppingIn;
  final int numberOfDrops;
  final int dropNumber;
  final List<List<int>> randoms;

  BigCardContour({
    required this.flippedDistance,
    required this.droppingIn,
    required this.numberOfDrops,
    required this.dropNumber,
    required this.randoms,
  });

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

  Path generateDropPath(int dropNumber, Size size) {
    Path path = Path();

    int pattern = dropNumber % 3;
    if (pattern == 0) {
      return DropPaths.getBlop(size);
    } else if (pattern == 1) {
      return DropPaths.getBlip(size);
    } else if (pattern == 2) {
      return DropPaths.getPloc(size);
    }

    return path;
  }

  Offset generateDropOffset(int dropNumber, Size size, double cornerOffset, PathMetric pathMetric) {
    double x = (randoms[dropNumber][0] * size.width / numberOfDrops) - 40;
    double y = (randoms[dropNumber][1] * size.height / numberOfDrops) - 40;

    Point cornerControl = calculateCornerPoint(size, 0, cornerOffset);
    double dropLength = pathMetric.length / pi;

    if (x <= cornerControl.x && y >= cornerControl.y - dropLength * 0.85) {
      x += dropLength * 0.85;
      y -= dropLength * 0.85;
    }

    return Offset(x, y);
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double flippedCornerLength = size.shortestSide / 5;

    if (droppingIn) {
      Size newSize = Size(size.width / 5, size.height / 7.5);
      for (int drop = 0; drop < dropNumber; drop++) {
        Path dropPath = generateDropPath(drop, newSize);
        path.addPath(dropPath, generateDropOffset(drop, size, flippedCornerLength, dropPath.computeMetrics().first));
      }
    } else {
      Point cornerControl = calculateCornerPoint(size, flippedDistance, flippedCornerLength);

      Point topLeft = Point(0, cornerControl.y - flippedDistance * 1.65);
      if (topLeft.y < 0) {
        topLeft = Point(flippedDistance - cornerControl.y / 1.65, 0);
      }

      Point bottomRight = Point(cornerControl.x - flippedDistance * 0.25, size.height);
      if (bottomRight.x > size.width) {
        bottomRight = Point(size.width, size.height);
      }

      path.lineTo(topLeft.x.toDouble(), topLeft.y.toDouble());
      path.lineTo(bottomRight.x.toDouble(), bottomRight.y.toDouble());
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(topLeft.x.toDouble(), 0);
    }

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
