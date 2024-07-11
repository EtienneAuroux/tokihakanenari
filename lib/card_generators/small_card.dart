import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/card_types/content_creation.dart';
import 'package:tokihakanenari/card_types/index_funds.dart';
import 'package:tokihakanenari/card_types/private_funds.dart';
import 'package:tokihakanenari/card_types/real_estate.dart';
import 'package:tokihakanenari/card_types/stocks.dart';
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
  Widget generateSmallCard(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        return AddCard(
          cardSize: CardSize.small,
          cardStatus: CardStatus.inert,
          onRequestToAddCard: (_) {
            throw ErrorDescription('It should not be possible to tap on a mini AddCard.');
          },
        );
      case CardType.contentCreation:
        return const ContentCreation(
          cardSize: CardSize.small,
        );
      case CardType.indexFunds:
        return const IndexFunds(
          cardSize: CardSize.small,
        );
      case CardType.passiveIncome:
        return const PassiveIncome(
          cardSize: CardSize.small,
        );
      case CardType.privateFunds:
        return const PrivateFunds(
          cardSize: CardSize.small,
        );
      case CardType.realEstate:
        return const RealEstate(
          cardSize: CardSize.small,
        );
      case CardType.savingAccounts:
        return const SavingAccounts(
          cardSize: CardSize.small,
        );
      case CardType.stocks:
        return const Stocks(
          cardSize: CardSize.small,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: deviceSize.width * 0.8,
          height: deviceSize.height * 0.6,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            splashColor: CardDecoration.getSplashColor(widget.cardType),
            onLongPress: () {
              widget.onLongPressSmallCard();
            },
            onTap: () {
              widget.onTapSmallCard();
            },
            child: Ink(
              decoration: CardDecoration.getSmallDecoration(widget.cardType),
              child: generateSmallCard(widget.cardType),
            ),
          ),
        ),
      ),
    );
  }
}
