import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_types/content_creation.dart';
import 'package:tokihakanenari/card_types/index_funds.dart';
import 'package:tokihakanenari/card_types/private_funds.dart';
import 'package:tokihakanenari/card_types/real_estate.dart';
import 'package:tokihakanenari/card_types/salaries.dart';
import 'package:tokihakanenari/card_types/saving_accounts.dart';
import 'package:tokihakanenari/card_types/stock_accounts.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';

import 'dart:developer' as developer;

class MiniCard extends StatefulWidget {
  final CardType cardType;
  final void Function() onTapMiniCard;

  const MiniCard({
    super.key,
    required this.cardType,
    required this.onTapMiniCard,
  });

  @override
  State<MiniCard> createState() => _MiniCardState();
}

class _MiniCardState extends State<MiniCard> {
  Widget generateMiniCard(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to generate a mini AddCard.');
      case CardType.contentCreation:
        return const ContentCreation(
          cardSize: CardSize.mini,
        );
      case CardType.indexFunds:
        return const IndexFunds(
          cardSize: CardSize.mini,
        );
      case CardType.passiveIncome:
        throw ErrorDescription('It should not be possible to generate a mini PassiveIncome.');
      case CardType.privateFunds:
        return const PrivateFunds(
          cardSize: CardSize.mini,
        );
      case CardType.realEstate:
        return const RealEstate(
          cardSize: CardSize.mini,
        );
      case CardType.salaries:
        return const Salaries(
          cardSize: CardSize.mini,
        );
      case CardType.savingAccounts:
        return const SavingAccounts(
          cardSize: CardSize.mini,
        );
      case CardType.stockAccounts:
        return const StockAccounts(
          cardSize: CardSize.mini,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        splashColor: CardDecoration.getSplashColor(widget.cardType),
        onTap: () {
          widget.onTapMiniCard();
        },
        child: Ink(
          decoration: CardDecoration.getMiniDecoration(widget.cardType),
          child: generateMiniCard(widget.cardType),
        ),
      ),
    );
  }
}
