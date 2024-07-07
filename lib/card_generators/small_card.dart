import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/card_types/passive_income.dart';
import 'package:tokihakanenari/card_types/saving_accounts.dart';
import 'package:tokihakanenari/my_enums.dart';

class SmallCard extends StatefulWidget {
  final CardType cardType;
  final void Function() onTapSmallCard;
  final void Function() onLongPressSmallCard;

  const SmallCard({
    super.key,
    required this.cardType,
    required this.onTapSmallCard,
    required this.onLongPressSmallCard,
  });

  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
  Size cardSize(Size deviceSize, Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.landscape) {
      return Size(deviceSize.width * 0.6, deviceSize.height * 0.8);
    } else {
      return Size(deviceSize.width * 0.8, deviceSize.height * 0.6);
    }
  }

  Widget generateSmallCard(CardType cardType) {
    switch (cardType) {
      case CardType.passiveIncome:
        return const PassiveIncome(
          cardStatus: CardStatus.small,
        );
      case CardType.addIncome:
        return const AddCard(
          cardStatus: CardStatus.small,
        );
      case CardType.savingAccounts:
        return const SavingAccounts(
          cardStatus: CardStatus.small,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    Size deviceSize = queryData.size;
    Orientation deviceOrientation = queryData.orientation;

    return Container(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: CardDecoration.getDecoration(widget.cardType),
          width: cardSize(deviceSize, deviceOrientation).width,
          height: cardSize(deviceSize, deviceOrientation).height,
          child: InkWell(
            splashColor: CardDecoration.getSplashColor(widget.cardType),
            onLongPress: () {
              widget.onLongPressSmallCard();
            },
            onTap: () {
              widget.onTapSmallCard();
            },
            child: generateSmallCard(widget.cardType),
          ),
        ),
      ),
    );
  }
}
