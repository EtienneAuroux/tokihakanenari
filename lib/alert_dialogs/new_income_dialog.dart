import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tokihakanenari/alert_dialogs/icons_dialog.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/card_decoration.dart';
import 'package:tokihakanenari/visual_tools/text_styles.dart';

class NewIncomeDialog extends StatefulWidget {
  final CardType cardType;
  final void Function(List<dynamic>) onNewIncomeCallback;

  const NewIncomeDialog({
    super.key,
    required this.cardType,
    required this.onNewIncomeCallback,
  });

  @override
  State<NewIncomeDialog> createState() => _NewIncomeDialogState();
}

class _NewIncomeDialogState extends State<NewIncomeDialog> {
  IconData icon = Icons.abc;
  TimePeriod timePeriod = TimePeriod.month;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController capitalPaymentController = TextEditingController();
  TextEditingController rentController = TextEditingController();

  List<dynamic>? getUserInput(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open AddNewDialog from AddCard.');
      case CardType.contentCreation:
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
          return <dynamic>[nameController.text, amountController.text, timePeriod];
        } else {
          return null;
        }
      case CardType.passiveIncome:
        throw ErrorDescription('It should not be possible to open AddNewDialog from PassiveIncome.');
      case CardType.realEstate:
        if (nameController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty &&
            amountController.text.isNotEmpty &&
            capitalPaymentController.text.isNotEmpty &&
            rentController.text.isNotEmpty &&
            interestController.text.isNotEmpty) {
          return <dynamic>[
            nameController.text,
            descriptionController.text,
            amountController.text,
            capitalPaymentController.text,
            rentController.text,
            interestController.text.replaceAll(',', '.'),
            DateTime.now(),
          ];
        } else {
          return null;
        }
      case CardType.salaries:
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
          return <dynamic>[icon, nameController.text, amountController.text, timePeriod];
        } else {
          return null;
        }
      case CardType.indexFunds:
      case CardType.privateFunds:
      case CardType.stockAccounts:
      case CardType.savingAccounts:
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty && interestController.text.isNotEmpty) {
          return <dynamic>[icon, nameController.text, amountController.text, interestController.text.replaceAll(',', '.')];
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
      case CardType.indexFunds:
        return 'New fund:';
      case CardType.passiveIncome:
        throw ErrorDescription('It should not be possible to open AddNewDialog from PassiveIncome.');
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
      case CardType.passiveIncome:
        throw ErrorDescription('It should not be possible to open AddNewDialog from PassiveIncome.');
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
          ), // TODO SHOULD BE POSSIBLE TO CHOOSE PERIOD?
          TextField(
            controller: rentController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'the average yearly increase in property value',
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
                        cardType: widget.cardType,
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
              'name:', // TODO SHOULD BE COMPANIES OR EMPLOYERS?
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
                        cardType: widget.cardType,
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

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    interestController.dispose();
    capitalPaymentController.dispose();
    rentController.dispose();

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
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
