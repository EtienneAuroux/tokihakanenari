import 'package:flutter/material.dart';

class DropPaths {
  static Path getBlop(Size size) {
    Path blop = Path();

    blop.lineTo(size.width * 0.8, size.height * 0.03);
    blop.cubicTo(size.width * 0.88, size.height * 0.09, size.width * 0.89, size.height * 0.23, size.width * 0.92, size.height * 0.37);
    blop.cubicTo(size.width * 0.96, size.height * 0.52, size.width * 1.03, size.height * 0.66, size.width * 0.98, size.height * 0.76);
    blop.cubicTo(size.width * 0.94, size.height * 0.86, size.width * 0.77, size.height * 0.93, size.width * 0.61, size.height * 0.96);
    blop.cubicTo(size.width * 0.45, size.height, size.width * 0.28, size.height * 1.02, size.width * 0.17, size.height * 0.96);
    blop.cubicTo(size.width * 0.06, size.height * 0.91, 0, size.height * 0.78, 0, size.height * 0.68);
    blop.cubicTo(0, size.height * 0.58, size.width * 0.07, size.height * 0.49, size.width * 0.1, size.height * 0.42);
    blop.cubicTo(size.width * 0.14, size.height * 0.35, size.width * 0.15, size.height * 0.29, size.width * 0.19, size.height * 0.23);
    blop.cubicTo(size.width * 0.23, size.height * 0.16, size.width * 0.3, size.height * 0.09, size.width * 0.42, size.height * 0.05);
    blop.cubicTo(size.width * 0.54, 0, size.width * 0.71, -0.02, size.width * 0.8, size.height * 0.03);
    blop.cubicTo(size.width * 0.8, size.height * 0.03, size.width * 0.8, size.height * 0.03, size.width * 0.8, size.height * 0.03);

    return blop;
  }

  static Path getBlip(Size size) {
    Path blip = Path();

    blip.lineTo(size.width * 0.93, size.height * 0.12);
    blip.cubicTo(size.width, size.height / 5, size.width, size.height * 0.34, size.width, size.height * 0.51);
    blip.cubicTo(size.width * 0.98, size.height * 0.67, size.width * 0.95, size.height * 0.86, size.width * 0.83, size.height * 0.94);
    blip.cubicTo(size.width * 0.72, size.height * 1.03, size.width * 0.52, size.height, size.width * 0.34, size.height * 0.93);
    blip.cubicTo(size.width * 0.16, size.height * 0.85, 0, size.height * 0.71, 0, size.height * 0.57);
    blip.cubicTo(0, size.height * 0.42, size.width * 0.15, size.height * 0.28, size.width * 0.28, size.height * 0.18);
    blip.cubicTo(size.width * 0.41, size.height * 0.08, size.width * 0.51, size.height * 0.02, size.width * 0.62, 0);
    blip.cubicTo(size.width * 0.74, -0.01, size.width * 0.87, size.height * 0.03, size.width * 0.93, size.height * 0.12);
    blip.cubicTo(size.width * 0.93, size.height * 0.12, size.width * 0.93, size.height * 0.12, size.width * 0.93, size.height * 0.12);

    return blip;
  }

  static Path getSplash(Size size) {
    Path splash = Path();

    splash.lineTo(size.width * 0.72, size.height * 0.04);
    splash.cubicTo(size.width * 0.76, size.height * 0.11, size.width * 0.75, size.height * 0.27, size.width * 0.8, size.height * 0.39);
    splash.cubicTo(size.width * 0.84, size.height * 0.52, size.width * 0.95, size.height * 0.61, size.width, size.height * 0.73);
    splash.cubicTo(size.width * 1.02, size.height * 0.85, size.width * 0.98, size.height, size.width * 0.89, size.height);
    splash.cubicTo(size.width * 0.8, size.height, size.width * 0.67, size.height * 0.88, size.width * 0.58, size.height * 0.82);
    splash.cubicTo(size.width / 2, size.height * 0.77, size.width * 0.47, size.height * 0.79, size.width * 0.41, size.height * 0.83);
    splash.cubicTo(size.width * 0.36, size.height * 0.87, size.width * 0.26, size.height * 0.92, size.width * 0.18, size.height * 0.9);
    splash.cubicTo(size.width * 0.09, size.height * 0.89, 0, size.height * 0.79, 0, size.height * 0.69);
    splash.cubicTo(0, size.height * 0.59, size.width * 0.07, size.height * 0.47, size.width * 0.15, size.height * 0.41);
    splash.cubicTo(size.width * 0.23, size.height * 0.35, size.width * 0.3, size.height * 0.34, size.width * 0.36, size.height * 0.28);
    splash.cubicTo(size.width * 0.42, size.height * 0.23, size.width * 0.46, size.height * 0.12, size.width * 0.52, size.height * 0.06);
    splash.cubicTo(size.width * 0.59, 0, size.width * 0.68, -0.03, size.width * 0.72, size.height * 0.04);
    splash.cubicTo(size.width * 0.72, size.height * 0.04, size.width * 0.72, size.height * 0.04, size.width * 0.72, size.height * 0.04);

    return splash;
  }

  static Path getPloc(Size size) {
    Path ploc = Path();

    ploc.lineTo(size.width * 0.86, 0);
    ploc.cubicTo(size.width * 0.95, -0.01, size.width, size.height * 0.09, size.width, size.height / 5);
    ploc.cubicTo(size.width, size.height * 0.3, size.width * 0.9, size.height * 0.41, size.width * 0.87, size.height / 2);
    ploc.cubicTo(size.width * 0.84, size.height * 0.59, size.width * 0.88, size.height * 0.66, size.width * 0.86, size.height * 0.71);
    ploc.cubicTo(size.width * 0.84, size.height * 0.76, size.width * 0.78, size.height * 0.8, size.width * 0.72, size.height * 0.86);
    ploc.cubicTo(size.width * 0.66, size.height * 0.92, size.width * 0.6, size.height, size.width * 0.54, size.height);
    ploc.cubicTo(size.width * 0.49, size.height, size.width * 0.44, size.height * 0.89, size.width / 3, size.height * 0.86);
    ploc.cubicTo(size.width * 0.22, size.height * 0.82, size.width * 0.06, size.height * 0.86, size.width * 0.01, size.height * 0.81);
    ploc.cubicTo(-0.03, size.height * 0.77, size.width * 0.04, size.height * 0.64, size.width * 0.07, size.height * 0.53);
    ploc.cubicTo(size.width * 0.09, size.height * 0.41, size.width * 0.06, size.height * 0.31, size.width * 0.11, size.height * 0.27);
    ploc.cubicTo(size.width * 0.16, size.height * 0.24, size.width * 0.29, size.height * 0.27, size.width * 0.37, size.height * 0.28);
    ploc.cubicTo(size.width * 0.46, size.height * 0.29, size.width / 2, size.height * 0.28, size.width * 0.58, size.height / 5);
    ploc.cubicTo(size.width * 0.66, size.height * 0.14, size.width * 0.77, size.height * 0.01, size.width * 0.86, 0);
    ploc.cubicTo(size.width * 0.86, 0, size.width * 0.86, 0, size.width * 0.86, 0);

    return ploc;
  }
}
