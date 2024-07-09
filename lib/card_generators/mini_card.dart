import 'package:flutter/material.dart';
import 'package:tokihakanenari/card_types/add_card.dart';
import 'package:tokihakanenari/card_types/content_creation.dart';
import 'package:tokihakanenari/card_types/index_funds.dart';
import 'package:tokihakanenari/card_types/passive_income.dart';
import 'package:tokihakanenari/card_types/private_funds.dart';
import 'package:tokihakanenari/card_types/saving_accounts.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';

class MiniCard extends StatefulWidget {
  final CardType cardType;

  const MiniCard({
    super.key,
    required this.cardType,
  });

  @override
  State<MiniCard> createState() => _MiniCardState();
}

class _MiniCardState extends State<MiniCard> {
  Widget generateMiniCard(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        return const AddCard(
          cardStatus: CardStatus.mini,
        );
      case CardType.contentCreation:
        return const ContentCreation(
          cardStatus: CardStatus.mini,
        );
      case CardType.indexFunds:
        return const IndexFunds(
          cardStatus: CardStatus.mini,
        );
      case CardType.passiveIncome:
        return const PassiveIncome(
          cardStatus: CardStatus.mini,
        );
      case CardType.privateFunds:
        return const PrivateFunds(
          cardStatus: CardStatus.mini,
        );
      case CardType.savingAccounts:
        return const SavingAccounts(
          cardStatus: CardStatus.mini,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CardDecoration.getMiniDecoration(widget.cardType),
      child: generateMiniCard(widget.cardType),
    );
  }
}
