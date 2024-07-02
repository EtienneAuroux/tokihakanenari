import 'package:flutter/material.dart';
import 'package:tokihakanenari/custom_card.dart';
import 'package:tokihakanenari/income_counter.dart';
import 'package:tokihakanenari/saving_accounts.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<CustomCard> customCards = [CustomCard(cardContent: IncomeCounter()), CustomCard(cardContent: SavingAccounts())];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: customCards.length,
      itemBuilder: ((context, index) {
        return customCards[index];
      }),
    );
  }
}
