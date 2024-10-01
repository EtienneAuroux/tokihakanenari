import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/danger_dialog.dart';
import 'package:tokihakanenari/customized_widgets/gradient_selector.dart';
import 'package:tokihakanenari/customized_widgets/setting_container.dart';
import 'package:tokihakanenari/customized_widgets/setting_dropdown.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: AppLocalizations.of(context)!.currency,
          values: Currency.values,
          onNewValue: (dynamic newCurrency) {
            setState(() {
              ledger.currency = newCurrency;
            });
          }),
      SettingDropdown(
          title: 'Background',
          values: Background.values,
          onNewValue: (dynamic newBackground) {
            setState(() {
              ledger.background = newBackground;
            });
          }),
    ];
  }

  List<Widget> getColorSettings() {
    return [
      GradientSelector(
        title: AppLocalizations.of(context)!.background,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.totalIncome,
        cardType: CardType.totalIncome,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.addIncome,
        cardType: CardType.addCard,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.contentCreation,
        cardType: CardType.contentCreation,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.customIncomes,
        cardType: CardType.customIncome,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.indexFunds,
        cardType: CardType.indexFunds,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.privateFunds,
        cardType: CardType.privateFunds,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.realEstate,
        cardType: CardType.realEstate,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.salaries,
        cardType: CardType.salaries,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.savingAccounts,
        cardType: CardType.savingAccounts,
      ),
      GradientSelector(
        title: AppLocalizations.of(context)!.stockAccounts,
        cardType: CardType.stockAccounts,
      ),
    ];
  }

  List<Widget> getDangerSettings() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.resetColors,
            style: TextStyles.cardBody,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DangerDialog(
                      title: AppLocalizations.of(context)!.resetColors,
                      onActionValidated: () {
                        ledger.resetAllGradients();
                      },
                    );
                  });
            },
            icon: Icon(
              FontAwesome5.paint_roller,
              size: Dimensions.iconSize,
            ),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.eraseData,
            style: TextStyles.cardBody,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DangerDialog(
                      title: AppLocalizations.of(context)!.eraseData,
                      onActionValidated: () {
                        ledger.deleteAllData();
                      },
                    );
                  });
            },
            icon: Icon(
              FontAwesome5.trash_alt,
              size: Dimensions.iconSize,
            ),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.eraseEverything,
            style: TextStyles.cardBody,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DangerDialog(
                      title: AppLocalizations.of(context)!.eraseEverything,
                      onActionValidated: () {
                        ledger.currency = Currency.none;
                        ledger.resetAllGradients();
                        ledger.deleteAllData();
                      },
                    );
                  });
            },
            icon: Icon(
              FontAwesome5.skull_crossbones,
              size: Dimensions.iconSize,
            ),
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
          padding: EdgeInsets.symmetric(horizontal: 10 * Dimensions.widthUnit),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesome5.tools_1,
                    color: Colors.black,
                    size: Dimensions.iconSize * 40 / 25,
                  ),
                  SizedBox(
                    width: 20 * Dimensions.widthUnit,
                  ),
                  Text(
                    AppLocalizations.of(context)!.settings,
                    style: TextStyles.cardTitle,
                  ),
                ],
              ),
              SizedBox(
                height: 20 * Dimensions.heightUnit,
              ),
              SizedBox(
                height: size.height * 0.85 * Dimensions.heightUnit,
                child: ListView(
                  children: [
                    SettingContainer(
                      title: AppLocalizations.of(context)!.general,
                      milliseconds: 300,
                      open: setting == Setting.general,
                      onOpen: (bool open) {
                        setState(() {
                          setting = open ? Setting.general : Setting.none;
                        });
                      },
                      children: getGeneralSettings(),
                    ),
                    SizedBox(
                      height: 10 * Dimensions.heightUnit,
                    ),
                    SettingContainer(
                      title: AppLocalizations.of(context)!.color,
                      milliseconds: 500,
                      open: setting == Setting.color,
                      onOpen: (bool open) {
                        setState(() {
                          setting = open ? Setting.color : Setting.none;
                        });
                      },
                      children: getColorSettings(),
                    ),
                    SizedBox(
                      height: 10 * Dimensions.heightUnit,
                    ),
                    SettingContainer(
                      title: AppLocalizations.of(context)!.danger,
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
