import 'dart:async';
import 'dart:math';
// import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tokihakanenari/card_generators/small_card.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';

class Carousel extends StatefulWidget {
  final CardStatus cardStatus;
  final void Function(CardType cardType) onRequestBigCard;

  const Carousel({
    super.key,
    required this.cardStatus,
    required this.onRequestBigCard,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  Ledger ledger = Ledger();
  late List<SmallCard> smallCards;
  final double viewportFraction = 0.5;
  late PageController pageController;
  bool longPress = false;

  Future<bool> ensureInitialization() {
    Completer<bool> completer = Completer<bool>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete(true);
    });

    return completer.future;
  }

  List<SmallCard> getSmallCards() {
    List<SmallCard> carouselCards = <SmallCard>[];
    for (CardType cardType in ledger.carouselCards) {
      carouselCards.add(
        SmallCard(
          cardType: cardType,
          onTapSmallCard: () {
            if (widget.cardStatus == CardStatus.inert) {
              widget.onRequestBigCard(cardType);
            }
          },
          onLongPressSmallCard: () {
            longPress = true;
          },
        ),
      );
    }
    return carouselCards;
  }

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      viewportFraction: viewportFraction,
      initialPage: ledger.pageInFocus,
    );

    smallCards = getSmallCards();

    ledger.addListener(() {
      smallCards = getSmallCards();
      if (mounted) {
        setState(() {});
      }
      if (!longPress && pageController.hasClients) {
        pageController.jumpToPage(ledger.pageInFocus);
      } else {
        longPress = false;
      }
    });
  }

  @override
  void dispose() {
    ledger.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ensureInitialization(),
        builder: (BuildContext context, AsyncSnapshot<void> snap) {
          return LayoutBuilder(builder: (context, constraints) {
            final double maxHeight = constraints.maxHeight;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              allowImplicitScrolling: true,
              pageSnapping: false,
              controller: pageController,
              itemBuilder: ((context, index) {
                final SmallCard card = smallCards[index % smallCards.length];
                return AnimatedBuilder(
                  animation: pageController,
                  builder: ((context, widget) {
                    final double ratioY = pageController.offset / maxHeight / viewportFraction - index;
                    return Transform.rotate(
                      angle: pi * ratioY * 0.08,
                      alignment: Alignment(0, ratioY),
                      child: Transform.scale(
                        scale: 0.8,
                        child: card,
                      ),
                    );
                  }),
                );
              }),
            );
          });
        });
  }
}
