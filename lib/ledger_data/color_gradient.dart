import 'package:flutter/material.dart';

class ColorGradient {
  final Color originalBottom;
  final Color originalTopRight;
  late Color bottom;
  late Color topRight;

  ColorGradient(this.originalBottom, this.originalTopRight) {
    _reset();
  }

  void _reset() {
    bottom = originalBottom;
    topRight = originalTopRight;
  }

  ColorGradient alpha(int alpha) {
    bottom = bottom.withAlpha(alpha);
    topRight = topRight.withAlpha(alpha);
    return this;
  }
}
