import 'package:flutter/material.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class Settings extends StatefulWidget {
  const Settings({
    super.key,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Row(
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
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Divider(
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
