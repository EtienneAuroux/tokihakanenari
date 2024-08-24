import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_generators/mini_card.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'dart:developer' as developer;

class AddCard extends StatefulWidget {
  final CardSize cardSize;
  final CardStatus cardStatus;
  final void Function(CardType) onRequestToAddCard;

  const AddCard({
    super.key,
    required this.cardSize,
    required this.cardStatus,
    required this.onRequestToAddCard,
  });

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  Ledger ledger = Ledger();
  List<MiniCard> remainingCards = <MiniCard>[];

  List<MiniCard> getRemainingCards() {
    List<MiniCard> remainingCards = <MiniCard>[];
    for (CardType cardType in CardType.values) {
      if (!ledger.carouselCards.contains(cardType) && cardType != CardType.settings) {
        remainingCards.add(
          MiniCard(
            cardType: cardType,
            onTapMiniCard: () {
              if (widget.cardStatus == CardStatus.inert) {
                ledger.startTapIndicator = false;
                widget.onRequestToAddCard(cardType);
              }
            },
          ),
        );
      }
    }
    return remainingCards;
  }

  Widget getCardContent(CardSize cardStatus) {
    switch (cardStatus) {
      case CardSize.big:
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20 * Dimensions.widthUnit,
            vertical: 30 * Dimensions.heightUnit,
          ),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.addCard,
                textAlign: TextAlign.center,
                style: TextStyles.cardTitle,
              ),
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10 * Dimensions.heightUnit,
                  crossAxisSpacing: 10 * Dimensions.widthUnit,
                  mainAxisExtent: 100 * Dimensions.heightUnit,
                ),
                children: remainingCards,
              )
            ],
          ),
        );
      case CardSize.mini:
        throw UnimplementedError('addCard should not be used as a mini card.');
      case CardSize.small:
        return Center(
          child: Icon(
            Icons.add_chart_rounded,
            size: 200 * Dimensions.heightUnit,
            color: Colors.black.withAlpha(150),
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();

    remainingCards = getRemainingCards();
  }

  @override
  Widget build(BuildContext context) {
    return getCardContent(widget.cardSize);
  }
}
