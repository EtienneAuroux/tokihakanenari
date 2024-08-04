import 'package:flutter/material.dart';
import 'package:tokihakanenari/customized_widgets/gradient_selector.dart';
import 'package:tokihakanenari/customized_widgets/rotating_button.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class Settings extends StatefulWidget {
  const Settings({
    super.key,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> currencies = ['none', '\$', '€', '£'];
  late String currency;
  bool expanded = false;

  List<Widget> getSettingsGrid() {
    return [
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'currency:',
          style: TextStyles.settingsBody,
        ),
      ),
      DropdownButton<String>(
        value: currency,
        isExpanded: true,
        underline: const SizedBox(),
        items: currencies.map<DropdownMenuItem<String>>((String currencys) {
          return DropdownMenuItem<String>(
            value: currencys,
            child: Center(
              child: Text(
                currencys,
                style: TextStyles.cardBody,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newCurrency) {
          setState(() {
            currency = newCurrency!;
          });
        },
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'home page:',
          style: TextStyles.settingsBody,
        ),
      ),
      const GradientSelector(),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'content creation:',
          style: TextStyles.settingsBody,
        ),
      ),
      const GradientSelector(
        cardType: CardType.contentCreation,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('custom incomes:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.customIncome,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('index funds:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.indexFunds,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('private funds:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.privateFunds,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('real estate:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.realEstate,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('salaries:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.salaries,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('saving accounts:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.savingAccounts,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('stock accounts:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.stockAccounts,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('total income:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.totalIncome,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('add income:', style: TextStyles.settingsBody),
      ),
      const GradientSelector(
        cardType: CardType.addCard,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    currency = currencies.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesome5.tools_1,
                  color: Colors.black,
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Settings',
                  style: TextStyles.cardTitle,
                ),
              ],
            ),
            const Text(
              '(work in progress)',
              style: TextStyles.incomeExtraInformation,
            ),
            Row(
              children: [
                Text(
                  'Colors',
                  style: TextStyles.settingsBody,
                ),
                RotatingButton(
                    iconData: Icons.arrow_drop_down,
                    onPressed: (bool newExpanded) {
                      setState(() {
                        expanded = newExpanded;
                      });
                    })
              ],
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 10,
                mainAxisExtent: 50,
              ),
              children: getSettingsGrid(),
            ),
            const Divider(
              thickness: 3,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
