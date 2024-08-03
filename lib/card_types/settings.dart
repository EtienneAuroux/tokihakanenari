import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tokihakanenari/alert_dialogs/color_picker_dialog.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'dart:developer' as developer;

class Settings extends StatefulWidget {
  const Settings({
    super.key,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> currencies = ['none', '\$', '€', '£'];
  late String currency;

  List<Widget> getSettingsGrid() {
    return [
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'currency:',
          style: TextStyles.cardBody,
        ),
      ),
      DropdownButton<String>(
        value: currency,
        isExpanded: true,
        underline: const SizedBox(),
        items: currencies.map<DropdownMenuItem<String>>((String currencys) {
          return DropdownMenuItem<String>(
            value: currencys,
            child: Center(
              child: Text(
                currencys,
                style: TextStyles.cardBody,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newCurrency) {
          setState(() {
            currency = newCurrency!;
          });
        },
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'background:',
          style: TextStyles.cardBody,
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ColorPickerDialog(
                    originalColors: [ColorPalette.mirrorYellow, ColorPalette.mirrorGrey],
                    onNewColors: (List<Color> newColors) {},
                  );
                });
          },
          child: Ink(
            width: 120,
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorPalette.mirrorYellow, ColorPalette.mirrorGrey],
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    currency = currencies.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesome5.tools_1,
                  color: Colors.black,
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Settings',
                  style: TextStyles.cardTitle,
                ),
              ],
            ),
            const Text(
              '(not yet implemented)',
              style: TextStyles.incomeExtraInformation,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 40,
                    ),
                    children: getSettingsGrid(),
                  ),
                  const Divider(
                    thickness: 3,
                    color: Colors.red,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
