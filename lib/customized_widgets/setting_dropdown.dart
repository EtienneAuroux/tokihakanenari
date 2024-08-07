import 'package:flutter/material.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

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
  dynamic value;

  @override
  void initState() {
    super.initState();

    if (widget.values.first is Currency) {
      value = ledger.currency;
    } else if (widget.values.first is Language) {
      value = ledger.language;
    } else {
      throw ErrorDescription('${widget.values.first.runtimeType} was provided to a SettingDropdown');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.title}:',
            style: TextStyles.cardBody,
          ),
          DropdownButton<dynamic>(
              underline: const SizedBox(),
              value: value,
              items: widget.values.map<DropdownMenuItem<dynamic>>((dynamic item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      item.word.isEmpty ? 'none' : item.word,
                      style: TextStyles.cardBody,
                    ),
                  ),
                );
              }).toList(),
              selectedItemBuilder: (BuildContext context) {
                return widget.values.map((dynamic item) {
                  return Container(
                    width: 120,
                    alignment: Alignment.centerRight,
                    child: Text(
                      item.word.isEmpty ? 'none' : item.word,
                      style: TextStyles.cardBody,
                    ),
                  );
                }).toList();
              },
              onChanged: (dynamic newValue) {
                widget.onNewValue(newValue);
                value = newValue;
              })
        ],
      ),
    );
  }
}
