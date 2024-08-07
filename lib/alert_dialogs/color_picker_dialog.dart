import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/slider_shade_picker.dart';
import 'package:tokihakanenari/customized_widgets/wheel_color_picker.dart';
import 'package:tokihakanenari/ledger_data/color_gradient.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class ColorPickerDialog extends StatefulWidget {
  final CardType? cardType;
  final ColorGradient originalColors;
  final void Function(List<Color>) onNewColors;

  const ColorPickerDialog({
    super.key,
    required this.cardType,
    required this.originalColors,
    required this.onNewColors,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Ledger ledger = Ledger();
  late Color wheelColorTopRight;
  late Color wheelColorBottom;
  late double shadeTopRight;
  late double shadeBottom;
  late double angleTopRight;
  late double angleBottom;
  late Color shadedColorTopRight;
  late Color shadedColorBottom;

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
    ledger.resetCardGradient(widget.cardType);
    ColorGradient resettedGradient = ledger.getCardGradient(widget.cardType);

    shadedColorBottom = resettedGradient.bottom;
    shadedColorTopRight = resettedGradient.topRight;

    List<double> angleShadeBottom = getAngleAndShade(shadedColorBottom);
    angleBottom = angleShadeBottom.first;
    shadeBottom = angleShadeBottom.last;

    List<double> angleShadeTopRight = getAngleAndShade(shadedColorTopRight);
    angleTopRight = angleShadeTopRight.first;
    shadeTopRight = angleShadeTopRight.last;

    wheelColorBottom = getWheelColor(angleBottom);
    wheelColorTopRight = getWheelColor(angleTopRight);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    shadedColorBottom = widget.originalColors.bottom;
    shadedColorTopRight = widget.originalColors.topRight;

    List<double> angleShadeBottom = getAngleAndShade(shadedColorBottom);
    angleBottom = angleShadeBottom.first;
    shadeBottom = angleShadeBottom.last;

    List<double> angleShadeTopRight = getAngleAndShade(shadedColorTopRight);
    angleTopRight = angleShadeTopRight.first;
    shadeTopRight = angleShadeTopRight.last;

    wheelColorBottom = getWheelColor(angleBottom);
    wheelColorTopRight = getWheelColor(angleTopRight);
    setState(() {});
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
                originalAngle: angleBottom,
                shadedColor: shadedColorBottom,
                onNewWheelColor: (Color newWheelColor) {
                  setState(() {
                    wheelColorBottom = newWheelColor;
                    shadedColorBottom = shadeColor(wheelColorBottom, shadeBottom);
                  });
                },
                topGradient: false,
              ),
              SliderShadePicker(
                originalShade: shadeBottom,
                wheelColor: wheelColorBottom,
                onNewSliderShade: (double newSliderShade) {
                  setState(() {
                    shadeBottom = newSliderShade;
                    shadedColorBottom = shadeColor(wheelColorBottom, shadeBottom);
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
                    colors: [shadedColorBottom, shadedColorTopRight],
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
                      widget.onNewColors([shadedColorBottom, shadedColorTopRight]);
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
                      widget.onNewColors([shadedColorBottom, shadedColorTopRight]);
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
