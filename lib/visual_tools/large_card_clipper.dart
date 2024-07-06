import 'package:flutter/material.dart';

class LargeCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    const double cornerRadius = 20;
    const double flippedCornerLength = 50;

    // Left vertical line
    path.moveTo(0, cornerRadius);
    path.lineTo(0, size.height - flippedCornerLength);

    // Bottom left corner diagonal line
    path.lineTo(flippedCornerLength, size.height);

    // Bottom horizontal line
    path.lineTo(size.width - cornerRadius, size.height);

    // Bottom right corner
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - cornerRadius);

    // Right vertical line
    path.lineTo(size.width, cornerRadius);

    // Top right conner
    path.quadraticBezierTo(size.width, 0, size.width - cornerRadius, 0);

    // Top horizontal line
    path.lineTo(cornerRadius, 0);

    // Top left corner
    path.quadraticBezierTo(0, 0, 0, cornerRadius);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
