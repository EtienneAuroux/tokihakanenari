import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tokihakanenari/custom_card.dart';
import 'package:tokihakanenari/income_counter.dart';
import 'package:tokihakanenari/saving_accounts.dart';

import 'dart:developer' as developer;

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<CustomCard> customCards = [
    const CustomCard(
      previousCardPosition: CardPosition.previous,
      newCardPosition: CardPosition.previous,
      cardContent: IncomeCounter(),
    ),
    const CustomCard(
      previousCardPosition: CardPosition.current,
      newCardPosition: CardPosition.current,
      cardContent: SavingAccounts(),
    ),
    const CustomCard(
      previousCardPosition: CardPosition.next,
      newCardPosition: CardPosition.next,
      cardContent: IncomeCounter(),
    )
  ];
  int currentPageIndex = 1;

  double panValue = 0;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(viewportFraction: 0.7);

    return LayoutBuilder(builder: ((context, constraints) {
      final maxWidth = constraints.maxWidth;
      return PageView.builder(
        allowImplicitScrolling: true,
        controller: pageController,
        itemCount: customCards.length,
        itemBuilder: (context, index) {
          final child = customCards[index];
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, __) {
              final ratioX = pageController.offset / maxWidth / 0.7 - index;

              return Transform.rotate(
                angle: pi * -0.05 * ratioX,
                child: Transform.translate(
                  offset: Offset(ratioX * 10, ratioX.abs() * 70),
                  child: Transform.scale(
                    scale: 0.8,
                    child: child,
                  ),
                ),
              );
            },
          );
        },
      );
    }));

    // return PageView.builder(
    //   scrollDirection: Axis.vertical,
    //   controller: PageController(viewportFraction: 0.4, initialPage: 1),
    //   physics: const BouncingScrollPhysics(),
    //   itemCount: customCards.length,
    //   onPageChanged: (int newPageIndex) {
    //     for (int index = 0; index < customCards.length; index++) {
    //       CardPosition newCardPosition;
    //       if (index < newPageIndex - 1) {
    //         newCardPosition = CardPosition.goneUp;
    //       } else if (index == newPageIndex - 1) {
    //         newCardPosition = CardPosition.previous;
    //       } else if (index == newPageIndex) {
    //         newCardPosition = CardPosition.current;
    //       } else if (index == newPageIndex + 1) {
    //         newCardPosition = CardPosition.next;
    //       } else {
    //         newCardPosition = CardPosition.goneDown;
    //       }
    //       setState(() {
    //         customCards[index] = CustomCard(
    //           previousCardPosition: customCards[index].newCardPosition,
    //           newCardPosition: newCardPosition,
    //           cardContent: customCards[index].cardContent,
    //         );
    //       });
    //     }
    //     setState(() {
    //       currentPageIndex = newPageIndex;
    //     });
    //   },
    //   itemBuilder: ((context, index) {
    //     return customCards[index];
    //   }),
    // );
  }
}
