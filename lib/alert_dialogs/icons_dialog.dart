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
  final List<IconData> icons = [FontAwesome5.question];

  void getIcons(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('AddCard does not require Icons.');
      case CardType.contentCreation:
        icons.addAll([
          FontAwesome5.youtube,
          FontAwesome5.film,
          FontAwesome5.instagram_1,
          FontAwesome5.twitch,
          FontAwesome5.patreon,
          FontAwesome5.linkedin_1,
          FontAwesome5.snapchat,
          FontAwesome5.pinterest_1,
          FontAwesome5.vk,
          FontAwesome5.vimeo_1
        ]);
      case CardType.customIncome:
      // TODO: Handle this case.
      case CardType.indexFunds:
      // TODO: Handle this case.
      case CardType.privateFunds:
      // TODO: Handle this case.
      case CardType.realEstate:
        throw ErrorDescription('RealEstate does not require Icons.');
      case CardType.salaries:
      // TODO: Handle this case.
      case CardType.savingAccounts:
      // TODO: Handle this case.
      case CardType.stockAccounts:
      // TODO: Handle this case.
      case CardType.totalIncome:
        throw ErrorDescription('TotalIncome does not require Icons.');
    }
  }

  @override
  void initState() {
    super.initState();

    getIcons(widget.cardType);
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
