import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
// import 'dart:developer' as developer;

class IconsDialog extends StatefulWidget {
  final CardType cardType;
  final void Function(IconData) onIconChosenCallback;

  const IconsDialog({
    super.key,
    required this.cardType,
    required this.onIconChosenCallback,
  });

  @override
  State<IconsDialog> createState() => _IconsDialogState();
}

class _IconsDialogState extends State<IconsDialog> {
  late List<IconData> icons;

  List<IconData> getIcons(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('AddCard does not require Icons.');
      case CardType.contentCreation:
        return FontAwesome5.contentCreationIcons;
      case CardType.customIncome:
        return FontAwesome5.customIncomesIcons;
      case CardType.indexFunds:
        return FontAwesome5.indexFundsIcons;
      case CardType.privateFunds:
        return FontAwesome5.privateFundsIcons;
      case CardType.realEstate:
        return FontAwesome5.realEstateIcons;
      case CardType.salaries:
        return FontAwesome5.salariesIcons;
      case CardType.savingAccounts:
        return FontAwesome5.savingAccountsIcons;
      case CardType.stockAccounts:
        return FontAwesome5.stockAccountsIcons;
      case CardType.totalIncome:
        throw ErrorDescription('TotalIncome does not require Icons.');
      case CardType.settings:
        throw ErrorDescription('Settings do not require icons.');
    }
  }

  double getDialogHeight() {
    double dialogHeight;
    if (icons.length * Dimensions.iconSize / 4 > Dimensions.deviceSize.height * 0.8) {
      dialogHeight = Dimensions.deviceSize.height * 0.8;
    } else {
      dialogHeight = (icons.length + 1) * (Dimensions.iconSize / 4 + 10 * Dimensions.heightUnit);
    }
    return dialogHeight;
  }

  @override
  void initState() {
    super.initState();

    icons = getIcons(widget.cardType);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: DecoratedBox(
        decoration: CardDecoration.getMiniDecoration(widget.cardType),
        child: SizedBox(
          height: getDialogHeight(),
          width: 160 * Dimensions.widthUnit,
          child: GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10 * Dimensions.heightUnit,
              crossAxisSpacing: 10 * Dimensions.widthUnit,
            ),
            children: List.generate(
              icons.length,
              (index) => IconButton(
                onPressed: () {
                  widget.onIconChosenCallback(icons[index]);
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  icons[index],
                  size: Dimensions.iconSize,
                ),
              ),
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
