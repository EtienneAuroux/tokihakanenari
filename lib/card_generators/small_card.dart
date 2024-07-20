import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/card_types/content_creation.dart';
import 'package:tokihakanenari/card_types/custom_income.dart';
import 'package:tokihakanenari/card_types/index_funds.dart';
import 'package:tokihakanenari/card_types/private_funds.dart';
import 'package:tokihakanenari/card_types/real_estate.dart';
import 'package:tokihakanenari/card_types/salaries.dart';
import 'package:tokihakanenari/card_types/stock_accounts.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/card_types/total_income.dart';
import 'package:tokihakanenari/card_types/saving_accounts.dart';
import 'package:tokihakanenari/my_enums.dart';

import 'dart:developer' as developer;

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
  Ledger ledger = Ledger();
  bool longPress = false;
  double gradientOffset = 0;

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
        // ignore: prefer_const_constructors
        return ContentCreation(
          cardSize: CardSize.small,
        );
      case CardType.customIncome:
        // ignore: prefer_const_constructors
        return CustomIncome(
          cardSize: CardSize.small,
        );
      case CardType.indexFunds:
        // ignore: prefer_const_constructors
        return IndexFunds(
          cardSize: CardSize.small,
        );
      case CardType.totalIncome:
        return const TotalIncome(
          cardSize: CardSize.small,
        );
      case CardType.privateFunds:
        // ignore: prefer_const_constructors
        return PrivateFunds(
          cardSize: CardSize.small,
        );
      case CardType.realEstate:
        // ignore: prefer_const_constructors
        return RealEstate(
          cardSize: CardSize.small,
        );
      case CardType.salaries:
        // ignore: prefer_const_constructors
        return Salaries(
          cardSize: CardSize.small,
        );
      case CardType.savingAccounts:
        // ignore: prefer_const_constructors
        return SavingAccounts(
          cardSize: CardSize.small,
        );
      case CardType.stockAccounts:
        // ignore: prefer_const_constructors
        return StockAccounts(
          cardSize: CardSize.small,
        );
    }
  }

  Future<void> updateGradient(CardType cardType) async {
    if (cardType == CardType.addCard || cardType == CardType.totalIncome) {
      return;
    }
    int counter = 0;
    while (longPress) {
      setState(() {
        gradientOffset += 0.01;
      });
      await Future.delayed(const Duration(milliseconds: 1));
      counter += 1;
      if (counter == 600) {
        longPress = false;
        widget.onLongPressSmallCard();
        ledger.deleteCarouselCard(cardType);
      }
    }
    if (!longPress) {
      setState(() {
        gradientOffset = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: deviceSize.width * 0.8,
          height: deviceSize.height * 0.6,
          decoration: CardDecoration.getSmallDecoration(widget.cardType),
          child: generateSmallCard(widget.cardType),
        ),
        Material(
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
                longPress = true;
                updateGradient(widget.cardType);
              },
              onTap: () {
                widget.onTapSmallCard();
              },
              onTapUp: (details) {
                longPress = false;
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.red.withAlpha(0)],
                    begin: Alignment(-1, 5 - gradientOffset),
                    end: Alignment(-1, 1 - gradientOffset),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
