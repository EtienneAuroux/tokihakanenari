import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/icons_dialog.dart';
import 'package:tokihakanenari/customized_widgets/dialog_entry.dart';
import 'package:tokihakanenari/customized_widgets/dialog_field.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewIncomeDialog extends StatefulWidget {
  final CardType cardType;
  final void Function(List<dynamic>) onNewIncomeCallback;
  final int? modify;

  const NewIncomeDialog({
    super.key,
    required this.cardType,
    required this.onNewIncomeCallback,
    this.modify,
  });

  @override
  State<NewIncomeDialog> createState() => _NewIncomeDialogState();
}

class _NewIncomeDialogState extends State<NewIncomeDialog> {
  Ledger ledger = Ledger();
  late IconData icon;
  TimePeriod timePeriod = TimePeriod.month;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController capitalPaymentController = TextEditingController();
  TextEditingController revenueController = TextEditingController();

  IconData initializeIcon(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('AddCard does not require Icons.');
      case CardType.contentCreation:
        return FontAwesome5.contentCreationIcons.first;
      case CardType.customIncome:
        return FontAwesome5.customIncomesIcons.first;
      case CardType.indexFunds:
        return FontAwesome5.indexFundsIcons.first;
      case CardType.privateFunds:
        return FontAwesome5.privateFundsIcons.first;
      case CardType.realEstate:
        return FontAwesome5.realEstateIcons.first;
      case CardType.salaries:
        return FontAwesome5.salariesIcons.first;
      case CardType.savingAccounts:
        return FontAwesome5.savingAccountsIcons.first;
      case CardType.stockAccounts:
        return FontAwesome5.stockAccountsIcons.first;
      case CardType.totalIncome:
        throw ErrorDescription('TotalIncome does not require Icons.');
      case CardType.settings:
        throw ErrorDescription('Settings does not require Icons.');
    }
  }

  List<dynamic>? getUserInput(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from AddCard.');
      case CardType.contentCreation:
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
          return <dynamic>[
            icon,
            nameController.text,
            amountController.text.replaceAll(',', '.'),
            timePeriod,
          ];
        } else {
          return null;
        }
      case CardType.customIncome:
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty && revenueController.text.isNotEmpty && interestController.text.isNotEmpty) {
          return <dynamic>[
            icon,
            nameController.text,
            amountController.text.replaceAll(',', '.'),
            revenueController.text.replaceAll(',', '.'),
            interestController.text.replaceAll(',', '.'),
          ];
        } else {
          return null;
        }
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from TotalIncome.');
      case CardType.realEstate:
        if (nameController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty &&
            amountController.text.isNotEmpty &&
            capitalPaymentController.text.isNotEmpty &&
            revenueController.text.isNotEmpty &&
            interestController.text.isNotEmpty) {
          return <dynamic>[
            icon,
            nameController.text,
            descriptionController.text,
            amountController.text.replaceAll(',', '.'),
            capitalPaymentController.text.replaceAll(',', '.'),
            revenueController.text.replaceAll(',', '.'),
            interestController.text.replaceAll(',', '.'),
            DateTime.now(),
          ];
        } else {
          return null;
        }
      case CardType.salaries:
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
          return <dynamic>[
            icon,
            nameController.text,
            amountController.text.replaceAll(',', '.'),
            timePeriod,
          ];
        } else {
          return null;
        }
      case CardType.indexFunds:
      case CardType.privateFunds:
      case CardType.stockAccounts:
      case CardType.savingAccounts:
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty && interestController.text.isNotEmpty) {
          return <dynamic>[
            icon,
            nameController.text,
            amountController.text.replaceAll(',', '.'),
            interestController.text.replaceAll(',', '.'),
          ];
        } else {
          return null;
        }
      case CardType.settings:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from settings.');
    }
  }

  List<Widget> getDialogContent(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from AddCard.');
      case CardType.contentCreation:
        return [
          DialogEntry(entry: AppLocalizations.of(context)!.icon, hint: AppLocalizations.of(context)!.iconHint),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return IconsDialog(
                        cardType: cardType,
                        onIconChosenCallback: (newIcon) {
                          setState(() {
                            icon = newIcon;
                          });
                        },
                      );
                    });
              },
              icon: Icon(icon)),
          DialogEntry(entry: AppLocalizations.of(context)!.name, hint: AppLocalizations.of(context)!.nameHint),
          DialogField(controller: nameController),
          DialogEntry(entry: AppLocalizations.of(context)!.revenue, hint: AppLocalizations.of(context)!.revenueHint),
          DialogField(controller: amountController, inputType: TextInputType.number),
          DialogEntry(entry: AppLocalizations.of(context)!.period, hint: AppLocalizations.of(context)!.periodHint),
          DropdownButton<TimePeriod>(
            value: timePeriod,
            isExpanded: true,
            underline: const SizedBox(),
            items: TimePeriod.values.map((TimePeriod timePeriod) {
              return DropdownMenuItem<TimePeriod>(
                value: timePeriod,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    timePeriod.title(context),
                    style: TextStyles.dialogText,
                  ),
                ),
              );
            }).toList(),
            onChanged: (TimePeriod? newTimePeriod) {
              setState(() {
                timePeriod = newTimePeriod!;
              });
            },
          ),
        ];
      case CardType.customIncome:
        return [
          DialogEntry(entry: AppLocalizations.of(context)!.icon, hint: AppLocalizations.of(context)!.iconHint),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return IconsDialog(
                        cardType: cardType,
                        onIconChosenCallback: (newIcon) {
                          setState(() {
                            icon = newIcon;
                          });
                        },
                      );
                    });
              },
              icon: Icon(icon)),
          DialogEntry(entry: AppLocalizations.of(context)!.name, hint: AppLocalizations.of(context)!.nameHint),
          DialogField(controller: nameController),
          DialogEntry(entry: AppLocalizations.of(context)!.amount, hint: AppLocalizations.of(context)!.amountHint),
          DialogField(controller: amountController, inputType: TextInputType.number),
          DialogEntry(entry: AppLocalizations.of(context)!.revenue, hint: AppLocalizations.of(context)!.revenueHint), // TODO SHOULD BE PER PERIOD?
          DialogField(controller: revenueController, inputType: TextInputType.number),
          DialogEntry(entry: AppLocalizations.of(context)!.rateOfReturn, hint: AppLocalizations.of(context)!.returnHint),
          DialogField(controller: interestController, inputType: TextInputType.number),
        ];
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from TotalIncome.');
      case CardType.realEstate:
        return [
          DialogEntry(entry: AppLocalizations.of(context)!.icon, hint: AppLocalizations.of(context)!.iconHint),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return IconsDialog(
                        cardType: cardType,
                        onIconChosenCallback: (newIcon) {
                          setState(() {
                            icon = newIcon;
                          });
                        },
                      );
                    });
              },
              icon: Icon(icon)),
          DialogEntry(entry: AppLocalizations.of(context)!.name, hint: AppLocalizations.of(context)!.nameHint),
          DialogField(controller: nameController),
          DialogEntry(entry: AppLocalizations.of(context)!.description, hint: AppLocalizations.of(context)!.descriptionHint),
          DialogField(controller: descriptionController),
          DialogEntry(entry: AppLocalizations.of(context)!.capital, hint: AppLocalizations.of(context)!.capitalHint),
          DialogField(controller: amountController, inputType: TextInputType.number),
          DialogEntry(entry: AppLocalizations.of(context)!.payment, hint: AppLocalizations.of(context)!.paymentHint), //TODO SHOULD BE PER PERIOD?
          DialogField(controller: capitalPaymentController, inputType: TextInputType.number),
          DialogEntry(entry: AppLocalizations.of(context)!.revenue, hint: AppLocalizations.of(context)!.revenueHint), //TODO SHOULD BE PER PERIOD?
          DialogField(controller: revenueController, inputType: TextInputType.number),
          DialogEntry(entry: AppLocalizations.of(context)!.appreciation, hint: AppLocalizations.of(context)!.appreciationHint),
          DialogField(controller: interestController, inputType: TextInputType.number),
        ];
      case CardType.salaries:
        return [
          DialogEntry(entry: AppLocalizations.of(context)!.icon, hint: AppLocalizations.of(context)!.iconHint),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return IconsDialog(
                        cardType: cardType,
                        onIconChosenCallback: (newIcon) {
                          setState(() {
                            icon = newIcon;
                          });
                        },
                      );
                    });
              },
              icon: Icon(icon)),
          DialogEntry(entry: AppLocalizations.of(context)!.name, hint: AppLocalizations.of(context)!.nameHint),
          DialogField(controller: nameController),
          DialogEntry(entry: AppLocalizations.of(context)!.salary, hint: AppLocalizations.of(context)!.salaryHint),
          DialogField(controller: amountController, inputType: TextInputType.number),
          DialogEntry(entry: AppLocalizations.of(context)!.period, hint: AppLocalizations.of(context)!.periodHint),
          DropdownButton<TimePeriod>(
            value: timePeriod,
            isExpanded: true,
            underline: const SizedBox(),
            items: TimePeriod.values.map((TimePeriod timePeriod) {
              return DropdownMenuItem<TimePeriod>(
                value: timePeriod,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    timePeriod.title(context),
                  ),
                ),
              );
            }).toList(),
            onChanged: (TimePeriod? newTimePeriod) {
              setState(() {
                timePeriod = newTimePeriod!;
              });
            },
          )
        ];
      case CardType.indexFunds:
      case CardType.privateFunds:
      case CardType.savingAccounts:
      case CardType.stockAccounts:
        return [
          DialogEntry(entry: AppLocalizations.of(context)!.icon, hint: AppLocalizations.of(context)!.iconHint),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return IconsDialog(
                        cardType: cardType,
                        onIconChosenCallback: (newIcon) {
                          setState(() {
                            icon = newIcon;
                          });
                        },
                      );
                    });
              },
              icon: Icon(icon)),
          DialogEntry(entry: AppLocalizations.of(context)!.name, hint: AppLocalizations.of(context)!.nameHint),
          DialogField(controller: nameController),
          DialogEntry(entry: AppLocalizations.of(context)!.amount, hint: AppLocalizations.of(context)!.amountHint),
          DialogField(controller: amountController, inputType: TextInputType.number),
          DialogEntry(entry: AppLocalizations.of(context)!.rateOfReturn, hint: AppLocalizations.of(context)!.returnHint),
          DialogField(controller: interestController, inputType: TextInputType.number),
        ];
      case CardType.settings:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from settings.');
    }
  }

  void initializeControllers(CardType cardType, int index) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from AddCard.');
      case CardType.contentCreation:
        icon = ledger.contentCreationData.icons[index];
        nameController.text = ledger.contentCreationData.names[index];
        amountController.text = ledger.contentCreationData.revenues[index].toString();
        timePeriod = ledger.contentCreationData.timePeriods[index];
        break;
      case CardType.customIncome:
        icon = ledger.customIncomeData.icons[index];
        nameController.text = ledger.customIncomeData.names[index];
        amountController.text = ledger.customIncomeData.amounts[index].toString();
        revenueController.text = ledger.customIncomeData.revenues[index].toString();
        interestController.text = ledger.customIncomeData.ratesOfReturn[index].toStringAsFixed(2);
        break;
      case CardType.realEstate:
        icon = ledger.realEstateData.icons[index];
        nameController.text = ledger.realEstateData.locations[index];
        descriptionController.text = ledger.realEstateData.descriptions[index];
        amountController.text = ledger.realEstateData.capitals[index].toString();
        capitalPaymentController.text = ledger.realEstateData.payments[index].toString();
        revenueController.text = ledger.realEstateData.revenues[index].toString();
        interestController.text = ledger.realEstateData.appreciations[index].toStringAsFixed(2);
        break;
      case CardType.salaries:
        icon = ledger.salariesData.icons[index];
        nameController.text = ledger.salariesData.names[index];
        amountController.text = ledger.salariesData.salaries[index].toString();
        timePeriod = ledger.salariesData.timePeriods[index];
        break;
      case CardType.indexFunds:
        icon = ledger.indexFundsData.icons[index];
        nameController.text = ledger.indexFundsData.names[index];
        amountController.text = ledger.indexFundsData.amounts[index].toString();
        interestController.text = ledger.indexFundsData.ratesOfReturn[index].toStringAsFixed(2);
        break;
      case CardType.privateFunds:
        icon = ledger.privateFundsData.icons[index];
        nameController.text = ledger.privateFundsData.names[index];
        amountController.text = ledger.privateFundsData.amounts[index].toString();
        interestController.text = ledger.privateFundsData.ratesOfReturn[index].toStringAsFixed(2);
        break;
      case CardType.savingAccounts:
        icon = ledger.savingAccountsData.icons[index];
        nameController.text = ledger.savingAccountsData.names[index];
        amountController.text = ledger.savingAccountsData.amounts[index].toString();
        interestController.text = ledger.savingAccountsData.ratesOfReturn[index].toStringAsFixed(2);
        break;
      case CardType.stockAccounts:
        icon = ledger.stockAccountsData.icons[index];
        nameController.text = ledger.stockAccountsData.names[index];
        amountController.text = ledger.stockAccountsData.amounts[index].toString();
        interestController.text = ledger.stockAccountsData.ratesOfReturn[index].toStringAsFixed(2);
        break;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from TotalIncome.');
      case CardType.settings:
        throw ErrorDescription('It should not be possible to open NewIncomeDialog from settings.');
    }
  }

  @override
  void initState() {
    super.initState();

    icon = initializeIcon(widget.cardType);

    if (widget.modify != null) {
      initializeControllers(widget.cardType, widget.modify!);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    interestController.dispose();
    capitalPaymentController.dispose();
    revenueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size dialogSize = MediaQuery.of(context).size;

    return AlertDialog(
      content: DecoratedBox(
        decoration: CardDecoration.getMiniDecoration(widget.cardType),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dialogSize.width / 10,
            vertical: dialogSize.height / 50,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    widget.cardType.item(context),
                    style: TextStyles.dialogTitle,
                  ),
                ),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 40,
                  ),
                  children: getDialogContent(widget.cardType),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: IconButton(
                    icon: const Icon(FontAwesome5.check_1),
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    constraints: const BoxConstraints(),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      List<dynamic>? userInput = getUserInput(widget.cardType);
                      if (userInput != null) {
                        widget.onNewIncomeCallback(userInput);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
