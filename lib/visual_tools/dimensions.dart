import 'package:flutter/material.dart';

class Dimensions {
  static const double cornerLength = 0.25;
  static const double cornerMaxHeight = 0.7;
  static const double cornerRadius = 0.1;
  static const double cornerTopLeftDeviation = 1.65;
  static const double cornerBottomRightDeviation = 0.25;

  // Dimensions of the SM S901B
  static const double _referenceHeight = 732;
  static const double _referenceWidth = 360;

  static Size? _deviceSize;
  static Size get deviceSize => _deviceSize ?? Size.zero;
  static set deviceSize(Size onSizeAcquired) {
    if (_deviceSize == null) {
      _deviceSize = onSizeAcquired;
      _maxFlippingDistance = (_deviceSize!.height - _deviceSize!.shortestSide * cornerLength) / cornerMaxHeight / cornerTopLeftDeviation;
      _pageUnrollingSpeed = _maxFlippingDistance! / 0.25;
      _heightUnit = _deviceSize!.height / _referenceHeight;
      _widthUnit = _deviceSize!.width / _referenceWidth;
      _iconSize = 25 * heightUnit;
    }
  }

  static double? _maxFlippingDistance;
  static double get maxFlippingDistance => _maxFlippingDistance!;

  static double? _pageUnrollingSpeed;
  static double get pageUnrollingSpeed => _pageUnrollingSpeed!;

  static double? _heightUnit;
  static double get heightUnit => _heightUnit!;

  static double? _widthUnit;
  static double get widthUnit => _widthUnit!;

  static double? _iconSize;
  static double get iconSize => _iconSize!;
}
