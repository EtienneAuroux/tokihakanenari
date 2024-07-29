import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';

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
        return FontAwesome5.financeIcons;
      case CardType.indexFunds:
        return FontAwesome5.financeIcons;
      case CardType.privateFunds:
        return FontAwesome5.financeIcons;
      case CardType.realEstate:
        return FontAwesome5.financeIcons;
      case CardType.salaries:
        return FontAwesome5.financeIcons;
      case CardType.savingAccounts:
        return FontAwesome5.financeIcons;
      case CardType.stockAccounts:
        return FontAwesome5.financeIcons;
      case CardType.totalIncome:
        throw ErrorDescription('TotalIncome does not require Icons.');
    }
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
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: List.generate(
            icons.length,
            (index) => IconButton(
              onPressed: () {
                widget.onIconChosenCallback(icons[index]);
                Navigator.of(context).pop();
              },
              icon: Icon(icons[index]),
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
