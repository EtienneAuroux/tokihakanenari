import 'package:flutter/material.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SmallCardContainer extends StatefulWidget {
  final String cardTitle;
  final double perDay;
  final double? investedAmount;

  const SmallCardContainer({super.key, required this.cardTitle, required this.perDay, this.investedAmount});

  @override
  State<SmallCardContainer> createState() => _SmallCardContainerState();
}

class _SmallCardContainerState extends State<SmallCardContainer> {
  Ledger ledger = Ledger();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.cardTitle,
            style: TextStyles.cardTitle,
          ),
          Text(
            '${ledger.formatMonetaryAmounts(widget.perDay, false, context)} / ${AppLocalizations.of(context)!.day}',
            style: TextStyles.cardBody,
          ),
          widget.investedAmount != null
              ? Text(
                  '${ledger.formatMonetaryAmounts(widget.investedAmount!, false, context)} ${AppLocalizations.of(context)!.invested}',
                  style: TextStyles.cardBody,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
