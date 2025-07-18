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
import 'package:tokihakanenari/visual_tools/dimensions.dart';

// import 'dart:developer' as developer;

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
      case CardType.totalIncome:
        return const TotalIncome(
          cardSize: CardSize.small,
        );
      case CardType.settings:
        throw ErrorDescription('It should not be possible to have a small Settings card.');
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
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 360 * 0.8 * Dimensions.widthUnit,
          height: 732 * 0.6 * Dimensions.heightUnit,
          decoration: CardDecoration.getSmallDecoration(widget.cardType),
          child: generateSmallCard(widget.cardType),
        ),
        Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 360 * 0.8 * Dimensions.widthUnit,
            height: 732 * 0.6 * Dimensions.heightUnit,
            child: GestureDetector(
              onTap: () {
                widget.onTapSmallCard();
              },
              onLongPress: () {
                longPress = true;
                updateGradient(widget.cardType);
              },
              onLongPressUp: () {
                longPress = false;
              },
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20 * Dimensions.heightUnit),
                ),
                splashColor: CardDecoration.getSplashColor(widget.cardType),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.red.withAlpha(0)],
                      begin: Alignment(-1, 5 - gradientOffset),
                      end: Alignment(-1, 1 - gradientOffset),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20 * Dimensions.heightUnit)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
