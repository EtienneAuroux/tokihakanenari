import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/slider_shade_picker.dart';
import 'package:tokihakanenari/customized_widgets/wheel_color_picker.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class ColorPickerDialog extends StatefulWidget {
  final List<Color> originalColors;
  final void Function(List<Color>) onNewColors;

  const ColorPickerDialog({
    super.key,
    required this.originalColors,
    required this.onNewColors,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color wheelColorTopRight;
  late Color wheelColorBottomLeft;
  late double shadeTopRight;
  late double shadeBottomLeft;
  late double angleTopRight;
  late double angleBottomLeft;
  late Color shadedColorTopRight;
  late Color shadedColorBottomLeft;

  Color shadeColor(Color color, double shade) {
    int red, green, blue;
    if (shade > 0.5) {
      red = color.red == 255 ? 255 : (color.red + (255 - color.red) * (shade - 0.5) / 0.5).round();
      green = color.green == 255 ? 255 : (color.green + (255 - color.green) * (shade - 0.5) / 0.5).round();
      blue = color.blue == 255 ? 255 : (color.blue + (255 - color.blue) * (shade - 0.5) / 0.5).round();
    } else if (shade < 0.5) {
      red = color.red == 0 ? 0 : (color.red * shade / 0.5).round();
      green = color.green == 0 ? 0 : (color.green * shade / 0.5).round();
      blue = color.blue == 0 ? 0 : (color.blue * shade / 0.5).round();
    } else {
      red = color.red;
      green = color.green;
      blue = color.blue;
    }

    return Color.fromARGB(255, red, green, blue);
  }

  List<double> getAngleAndShade(Color rgb) {
    double red = rgb.red / 255;
    double green = rgb.green / 255;
    double blue = rgb.blue / 255;

    double maxColor = max(max(red, green), blue);
    double minColor = min(min(red, green), blue);
    double delta = maxColor - minColor;

    double hue, shade = maxColor;
    developer.log('shade $shade');
    if (delta == 0) {
      hue = 0;
    } else if (maxColor == red) {
      hue = (green - blue) / delta;
    } else if (maxColor == green) {
      hue = (red - blue) / delta + 2;
    } else {
      hue = (red - green) / delta + 4;
    }

    if (hue < 0) {
      hue += 6;
    }
    hue = hue * 60 * pi / 180 + pi;
    return [hue, shade];
  }

  Color getWheelColor(double angle) {
    angle %= 2 * pi;
    double hue = (angle / pi + 1) * 180 / 60;
    int huePrime = hue.floor() % 6;
    double f = hue - huePrime;
    int v = 255;
    int p = 0;
    int q = (255 * (1 - f)).round();
    int t = (255 * f).round();

    if (huePrime == 0) {
      return Color.fromARGB(255, v, t, p);
    } else if (huePrime == 1) {
      return Color.fromARGB(255, q, v, p);
    } else if (huePrime == 2) {
      return Color.fromARGB(255, p, v, t);
    } else if (huePrime == 3) {
      return Color.fromARGB(255, p, q, v);
    } else if (huePrime == 4) {
      return Color.fromARGB(255, t, p, v);
    } else {
      return Color.fromARGB(255, v, p, q);
    }
  }

  void reset() {
    shadedColorBottomLeft = widget.originalColors.first;
    shadedColorTopRight = widget.originalColors.last;

    List<double> angleShadeBottomLeft = getAngleAndShade(shadedColorBottomLeft);
    angleBottomLeft = angleShadeBottomLeft.first;
    shadeBottomLeft = angleShadeBottomLeft.last;

    List<double> angleShadeTopRight = getAngleAndShade(shadedColorTopRight);
    angleTopRight = angleShadeTopRight.first;
    shadeTopRight = angleShadeTopRight.last;

    wheelColorBottomLeft = getWheelColor(angleBottomLeft);
    wheelColorTopRight = getWheelColor(angleTopRight);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    reset();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Gradient creator',
            style: TextStyles.dialogTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 60,
                child: Text(
                  'top\nright:',
                  textAlign: TextAlign.center,
                  style: TextStyles.dialogText,
                ),
              ),
              WheelColorPicker(
                originalAngle: angleTopRight,
                shadedColor: shadedColorTopRight,
                onNewWheelColor: (Color newWheelColor) {
                  setState(() {
                    wheelColorTopRight = newWheelColor;
                    shadedColorTopRight = shadeColor(wheelColorTopRight, shadeTopRight);
                  });
                },
              ),
              SliderShadePicker(
                originalShade: shadeTopRight,
                wheelColor: wheelColorTopRight,
                onNewSliderShade: (double newSliderShade) {
                  setState(() {
                    shadeTopRight = newSliderShade;
                    shadedColorTopRight = shadeColor(wheelColorTopRight, shadeTopRight);
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 60,
                child: Text(
                  'bottom\nleft:',
                  textAlign: TextAlign.center,
                  style: TextStyles.dialogText,
                ),
              ),
              WheelColorPicker(
                originalAngle: angleBottomLeft,
                shadedColor: shadedColorBottomLeft,
                onNewWheelColor: (Color newWheelColor) {
                  setState(() {
                    wheelColorBottomLeft = newWheelColor;
                    shadedColorBottomLeft = shadeColor(wheelColorBottomLeft, shadeBottomLeft);
                  });
                },
                topGradient: false,
              ),
              SliderShadePicker(
                originalShade: shadeBottomLeft,
                wheelColor: wheelColorBottomLeft,
                onNewSliderShade: (double newSliderShade) {
                  setState(() {
                    shadeBottomLeft = newSliderShade;
                    shadedColorBottomLeft = shadeColor(wheelColorBottomLeft, shadeBottomLeft);
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 75,
                child: Text(
                  'gradient:',
                  textAlign: TextAlign.center,
                  style: TextStyles.dialogText,
                ),
              ),
              Container(
                height: 100,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [shadedColorBottomLeft, shadedColorTopRight],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topRight,
                  ),
                ),
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(FontAwesome5.check_1),
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    constraints: const BoxConstraints(),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      widget.onNewColors([shadedColorBottomLeft, shadedColorTopRight]);
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: const Icon(FontAwesome5.redo),
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    constraints: const BoxConstraints(),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      reset();
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
