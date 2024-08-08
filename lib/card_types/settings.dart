import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/danger_dialog.dart';
import 'package:tokihakanenari/customized_widgets/gradient_selector.dart';
import 'package:tokihakanenari/customized_widgets/setting_container.dart';
import 'package:tokihakanenari/customized_widgets/setting_dropdown.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
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
  Ledger ledger = Ledger();
  Setting setting = Setting.none;

  List<Widget> getGeneralSettings() {
    return [
      SettingDropdown(
          title: 'Currency',
          values: Currency.values,
          onNewValue: (dynamic newCurrency) {
            setState(() {
              ledger.currency = newCurrency;
            });
          }),
      SettingDropdown(
          title: 'Language',
          values: Language.values,
          onNewValue: (dynamic newLanguage) {
            setState(() {
              ledger.language = newLanguage;
            });
          }),
    ];
  }

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

  List<Widget> getDangerSettings() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Reset all colors:',
            style: TextStyles.cardBody,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DangerDialog(
                      title: 'Reset colors',
                      onActionValidated: () {
                        ledger.resetAllGradients();
                      },
                    );
                  });
            },
            icon: const Icon(FontAwesome5.paint_roller),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Erase all data:',
            style: TextStyles.cardBody,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DangerDialog(
                      title: 'Erase data',
                      onActionValidated: () {
                        ledger.deleteAllData();
                      },
                    );
                  });
            },
            icon: const Icon(FontAwesome5.trash_alt),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Erase everything:',
            style: TextStyles.cardBody,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DangerDialog(
                      title: 'Erase everything',
                      onActionValidated: () {
                        ledger.currency = Currency.none;
                        ledger.language = Language.english;
                        ledger.resetAllGradients();
                        ledger.deleteAllData();
                      },
                    );
                  });
            },
            icon: const Icon(FontAwesome5.skull_crossbones),
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
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
                      milliseconds: 300,
                      open: setting == Setting.general,
                      onOpen: (bool open) {
                        setState(() {
                          setting = open ? Setting.general : Setting.none;
                        });
                      },
                      children: getGeneralSettings(),
                    ),
                    const SizedBox(
                      height: 10,
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
                    const SizedBox(
                      height: 10,
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
                      children: getDangerSettings(),
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
