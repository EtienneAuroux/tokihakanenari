import 'dart:async';
import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tokihakanenari/card_generators/small_card.dart';
import 'package:tokihakanenari/my_enums.dart';

class Carousel extends StatefulWidget {
  final void Function(CardType cardType) onRequestToEnlargeCard;

  const Carousel({super.key, required this.onRequestToEnlargeCard});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late List<SmallCard> smallCards;

  Future<bool> ensureInitialization() {
    Completer<bool> completer = Completer<bool>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete(true);
    });

    return completer.future;
  }

  Alignment setAlignment(PageController controller, int index, Orientation orientation) {
    if (controller.position.haveDimensions && controller.page! <= index) {
      return orientation == Orientation.landscape ? Alignment.bottomLeft : Alignment.topRight;
    } else {
      return Alignment.bottomRight;
    }
  }

  @override
  void initState() {
    super.initState();

    smallCards = [
      SmallCard(
        cardType: CardType.addIncome,
        onTapSmallCard: () {
          widget.onRequestToEnlargeCard(CardType.addIncome);
        },
        onLongPressSmallCard: () {},
      ),
      SmallCard(
        cardType: CardType.passiveIncome,
        onTapSmallCard: () {
          widget.onRequestToEnlargeCard(CardType.passiveIncome);
        },
        onLongPressSmallCard: () {},
      ),
      SmallCard(
        cardType: CardType.addIncome,
        onTapSmallCard: () {
          widget.onRequestToEnlargeCard(CardType.addIncome);
        },
        onLongPressSmallCard: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Orientation screenOrientation = MediaQuery.of(context).orientation;
    final double viewportFraction = screenOrientation == Orientation.landscape ? 0.6 : 0.5;
    final pageController = PageController(viewportFraction: viewportFraction, initialPage: 1);

    return FutureBuilder(
        future: ensureInitialization(),
        builder: (BuildContext context, AsyncSnapshot<void> snap) {
          return LayoutBuilder(builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;
            return PageView.builder(
              scrollDirection: screenOrientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
              allowImplicitScrolling: true,
              controller: pageController,
              itemCount: smallCards.length,
              itemBuilder: ((context, index) {
                final card = smallCards[index];
                return AnimatedBuilder(
                  animation: pageController,
                  builder: ((context, widget) {
                    final ratioX = pageController.offset / maxWidth / viewportFraction - index;
                    final ratioY = pageController.offset / maxHeight / viewportFraction - index;
                    return Transform.rotate(
                      angle: screenOrientation == Orientation.landscape ? pi * -0.05 * ratioX : pi * 0.08 * ratioY,
                      alignment: setAlignment(pageController, index, screenOrientation),
                      origin: screenOrientation == Orientation.landscape ? Offset(0, -maxWidth / 2) : Offset(-maxHeight / 3, 0),
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
