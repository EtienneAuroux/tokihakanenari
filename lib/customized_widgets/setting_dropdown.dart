import 'package:flutter/material.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/dimensions.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingDropdown extends StatefulWidget {
  final String title;
  final List<dynamic> values;
  final void Function(dynamic) onNewValue;

  const SettingDropdown({
    super.key,
    required this.title,
    required this.values,
    required this.onNewValue,
  });

  @override
  State<SettingDropdown> createState() => _SettingDropdownState();
}

class _SettingDropdownState extends State<SettingDropdown> {
  Ledger ledger = Ledger();

  dynamic getValue() {
    if (widget.values.first is Currency) {
      return ledger.currency;
    } else if (widget.values.first is Language) {
      return ledger.language;
    } else {
      throw ErrorDescription('${widget.values.first.runtimeType} was provided to a SettingDropdown');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5 * Dimensions.heightUnit),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.title}:',
            style: TextStyles.cardBody,
          ),
          DropdownButton<dynamic>(
              underline: const SizedBox(),
              iconSize: Dimensions.iconSize,
              value: getValue(),
              items: widget.values.map<DropdownMenuItem<dynamic>>((dynamic item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      item.word.isEmpty ? AppLocalizations.of(context)!.none : item.word,
                      style: TextStyles.cardBody,
                    ),
                  ),
                );
              }).toList(),
              selectedItemBuilder: (BuildContext context) {
                return widget.values.map((dynamic item) {
                  return Container(
                    width: 120 * Dimensions.widthUnit,
                    alignment: Alignment.centerRight,
                    child: Text(
                      item.word.isEmpty ? AppLocalizations.of(context)!.none : item.word,
                      style: TextStyles.cardBody,
                    ),
                  );
                }).toList();
              },
              onChanged: (dynamic newValue) {
                widget.onNewValue(newValue);
              })
        ],
      ),
    );
  }
}
