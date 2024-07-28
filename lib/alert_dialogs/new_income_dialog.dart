import 'package:flutter/material.dart';
import 'package:tokihakanenari/alert_dialogs/icons_dialog.dart';
import 'package:tokihakanenari/ledger_data/ledger.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';
import 'package:tokihakanenari/visual_tools/font_awesome5_icons.dart';

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
  IconData icon = FontAwesome5.question;
  TimePeriod timePeriod = TimePeriod.month;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController capitalPaymentController = TextEditingController();
  TextEditingController revenueController = TextEditingController();

  List<dynamic>? getUserInput(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open AddNewDialog from AddCard.');
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
        throw ErrorDescription('It should not be possible to open AddNewDialog from TotalIncome.');
      case CardType.realEstate:
        if (nameController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty &&
            amountController.text.isNotEmpty &&
            capitalPaymentController.text.isNotEmpty &&
            revenueController.text.isNotEmpty &&
            interestController.text.isNotEmpty) {
          return <dynamic>[
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
    }
  }

  String getDialogTitle(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open AddNewDialog from AddCard.');
      case CardType.contentCreation:
        return 'New content:';
      case CardType.customIncome:
        return 'New income:';
      case CardType.indexFunds:
        return 'New fund:';
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to open AddNewDialog from TotalIncome.');
      case CardType.privateFunds:
        return 'New fund:';
      case CardType.realEstate:
        return 'New property:';
      case CardType.salaries:
        return 'New salary:';
      case CardType.savingAccounts:
        return 'New account:';
      case CardType.stockAccounts:
        return 'New account:';
    }
  }

  List<Widget> getDialogContent(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open AddNewDialog from AddCard.');
      case CardType.contentCreation:
        return [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'icon:',
              style: TextStyles.dialogText,
            ),
          ),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'platform:',
              style: TextStyles.dialogText,
            ),
          ),
          TextField(
            controller: nameController,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'average revenue per period',
              child: Text(
                'revenue:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: amountController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'period:',
              style: TextStyles.dialogText,
            ),
          ),
          DropdownButton<TimePeriod>(
            value: timePeriod,
            isExpanded: true,
            underline: const SizedBox(),
            items: TimePeriod.values.map((TimePeriod timePeriod) {
              return DropdownMenuItem<TimePeriod>(
                value: timePeriod,
                child: Text(
                  timePeriod.name,
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'icon:',
              style: TextStyles.dialogText,
            ),
          ),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the name of the income',
              child: Text(
                'name:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: nameController,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the money invested',
              child: Text(
                'amount:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the revenues you receive from the income per month',
              child: Text(
                'revenue:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: revenueController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'average return per year',
              child: Text(
                'interest (%):',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: interestController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ];
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to open AddNewDialog from TotalIncome.');
      case CardType.realEstate:
        return [
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the name or location of the property',
              child: Text(
                'location:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: nameController,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'surface, number of units, ...',
              child: Text(
                'description:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: descriptionController,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the capital you own in the property',
              child: Text(
                'capital:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the monthly increase in capital',
              child: Text(
                'payment:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: capitalPaymentController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the revenues you receive from the property per month',
              child: Text(
                'revenue:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: revenueController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the average yearly increase in property value',
              child: Text(
                'appreciation (%):',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: interestController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ];
      case CardType.salaries:
        return [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'icon:',
              style: TextStyles.dialogText,
            ),
          ),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'name:',
              style: TextStyles.dialogText,
            ),
          ),
          TextField(
            controller: nameController,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'salary per period',
              child: Text(
                'salary:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'period:',
              style: TextStyles.dialogText,
            ),
          ),
          DropdownButton<TimePeriod>(
            value: timePeriod,
            isExpanded: true,
            underline: const SizedBox(),
            items: TimePeriod.values.map((TimePeriod timePeriod) {
              return DropdownMenuItem<TimePeriod>(
                value: timePeriod,
                child: Text(
                  timePeriod.name,
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'icon:',
              style: TextStyles.dialogText,
            ),
          ),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'name:',
              style: TextStyles.dialogText,
            ),
          ),
          TextField(
            controller: nameController,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the money invested',
              child: Text(
                'amount:',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'average return per year',
              child: Text(
                'interest (%):',
                style: TextStyles.dialogText,
              ),
            ),
          ),
          TextField(
            controller: interestController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ];
    }
  }

  void initializeControllers(CardType cardType, int index) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open AddNewDialog from AddCard.');
      case CardType.contentCreation:
        nameController.text = ledger.contentCreationData.platforms[index];
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
        throw ErrorDescription('It should not be possible to open AddNewDialog from TotalIncome.');
    }
  }

  @override
  void initState() {
    super.initState();

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
                    getDialogTitle(widget.cardType),
                    style: TextStyles.dialogTitle,
                  ),
                ),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 45,
                  ),
                  children: getDialogContent(widget.cardType),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextButton(
                    child: const Icon(Icons.check),
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
