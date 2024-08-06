import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/gradient_selector.dart';
import 'package:tokihakanenari/customized_widgets/setting_container.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

// import 'dart:developer' as developer;

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
  Setting setting = Setting.none;

  List<Widget> getColorSettings() {
    return [
      const GradientSelector(
        title: 'background',
      ),
      const GradientSelector(
        title: 'total income',
        cardType: CardType.totalIncome,
      ),
      const GradientSelector(
        title: 'add income',
        cardType: CardType.addCard,
      ),
      const GradientSelector(
        title: 'content creation',
        cardType: CardType.contentCreation,
      ),
      const GradientSelector(
        title: 'custom incomes',
        cardType: CardType.customIncome,
      ),
      const GradientSelector(
        title: 'index funds',
        cardType: CardType.indexFunds,
      ),
      const GradientSelector(
        title: 'private funds',
        cardType: CardType.privateFunds,
      ),
      const GradientSelector(
        title: 'real estate',
        cardType: CardType.realEstate,
      ),
      const GradientSelector(
        title: 'salaries',
        cardType: CardType.salaries,
      ),
      const GradientSelector(
        title: 'saving accounts',
        cardType: CardType.savingAccounts,
      ),
      const GradientSelector(
        title: 'stock accounts:',
        cardType: CardType.stockAccounts,
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                '(work in progress)',
                style: TextStyles.incomeExtraInformation,
              ),
              SizedBox(
                height: size.height * 0.85,
                child: ListView(
                  children: [
                    SettingContainer(
                      title: 'General',
                      milliseconds: 500,
                      open: setting == Setting.general,
                      onOpen: (bool open) {
                        setState(() {
                          setting = open ? Setting.general : Setting.none;
                        });
                      },
                      children: [],
                    ),
                    SettingContainer(
                      title: 'Color',
                      milliseconds: 500,
                      open: setting == Setting.color,
                      onOpen: (bool open) {
                        setState(() {
                          setting = open ? Setting.color : Setting.none;
                        });
                      },
                      children: getColorSettings(),
                    ),
                    SettingContainer(
                      title: 'Danger',
                      milliseconds: 300,
                      open: setting == Setting.danger,
                      onOpen: (bool open) {
                        setState(() {
                          setting = open ? Setting.danger : Setting.none;
                        });
                      },
                      borderColor: Colors.red,
                      children: [],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
