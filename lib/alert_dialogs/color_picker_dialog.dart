import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/slider_shade_picker.dart';
import 'package:tokihakanenari/customized_widgets/wheel_color_picker.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class ColorPickerDialog extends StatefulWidget {
  final List<Color> originalGradient;

  const ColorPickerDialog({
    super.key,
    required this.originalGradient,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color wheelColorTopRight;
  late Color wheelColorBottomLeft;
  double shadeTopRight = 0.5;
  double shadeBottomLeft = 0.5;
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

  @override
  void initState() {
    super.initState();

    wheelColorBottomLeft = widget.originalGradient.first;
    wheelColorTopRight = widget.originalGradient.last;
    shadedColorBottomLeft = wheelColorBottomLeft;
    shadedColorTopRight = wheelColorTopRight;
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
                shadedColor: shadedColorTopRight,
                onNewWheelColor: (Color newWheelColor) {
                  setState(() {
                    wheelColorTopRight = newWheelColor;
                    shadedColorTopRight = shadeColor(wheelColorTopRight, shadeTopRight);
                  });
                },
              ),
              SliderShadePicker(
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
                shadedColor: shadedColorBottomLeft,
                onNewWheelColor: (Color newWheelColor) {
                  setState(() {
                    wheelColorBottomLeft = newWheelColor;
                    shadedColorBottomLeft = shadeColor(wheelColorBottomLeft, shadeBottomLeft);
                  });
                },
              ),
              SliderShadePicker(
                wheelColor: wheelColorBottomLeft,
                onNewSliderShade: (double newSliderShade) {
                  setState(() {
                    shadeBottomLeft = newSliderShade;
                    shadedColorBottomLeft = shadeColor(wheelColorBottomLeft, shadeBottomLeft);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
