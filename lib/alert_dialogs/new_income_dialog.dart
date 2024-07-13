import 'package:flutter/material.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController interestController = TextEditingController();

  List<dynamic>? getUserInput(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open AddNewDialog from AddCard.');
      case CardType.contentCreation:
        return null;
      case CardType.indexFunds:
        return null;
      case CardType.passiveIncome:
        throw ErrorDescription('It should not be possible to open AddNewDialog from PassiveIncome.');
      case CardType.privateFunds:
        return null;
      case CardType.realEstate:
        return null;
      case CardType.salaries:
        return null;
      case CardType.savingAccounts:
        if (nameController.text.isNotEmpty && amountController.text.isNotEmpty && interestController.text.isNotEmpty) {
          return <dynamic>[icon, nameController.text, amountController.text, interestController.text];
        } else {
          return null;
        }
      case CardType.stockAccounts:
        return null;
    }
  }

  List<Widget> getDialogContent(CardType cardType, Size size) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to open AddNewDialog from AddCard.');
      case CardType.contentCreation:
        return [
          const Text(
            'New content:', // Need better title.
            style: TextStyles.dialogTitle,
          ),
        ];
      case CardType.indexFunds:
        return [
          const Text(
            'New fund:',
            style: TextStyles.dialogTitle,
          ),
        ];
      case CardType.passiveIncome:
        throw ErrorDescription('It should not be possible to open AddNewDialog from PassiveIncome.');
      case CardType.privateFunds:
        return [
          const Text(
            'New fund:',
            style: TextStyles.dialogTitle,
          ),
        ];
      case CardType.realEstate:
        return [
          const Text(
            'New property:',
            style: TextStyles.dialogTitle,
          ),
        ];
      case CardType.salaries:
        return [
          const Text(
            'New salary:',
            style: TextStyles.dialogTitle,
          ),
        ];
      case CardType.savingAccounts:
        return [
          const Text(
            'New account:',
            style: TextStyles.dialogTitle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'icon:',
                style: TextStyles.dialogText,
              ),
              SizedBox(
                width: size.width / 4,
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'name:',
                style: TextStyles.dialogText,
              ),
              SizedBox(
                width: size.width / 3,
                child: TextField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'amount:',
                style: TextStyles.dialogText,
              ),
              SizedBox(
                width: size.width / 3,
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'interest (%):',
                style: TextStyles.dialogText,
              ),
              SizedBox(
                width: size.width / 3,
                child: TextField(
                  controller: interestController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          TextButton(
            child: const Icon(Icons.check),
            onPressed: () {
              List<dynamic>? userInput = getUserInput(cardType);
              if (userInput != null) {
                widget.onNewIncomeCallback(userInput);
              }
              Navigator.of(context).pop();
            },
          ),
        ];
      case CardType.stockAccounts:
        return [
          const Text(
            'New account:',
            style: TextStyles.dialogTitle,
          ),
        ];
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    interestController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size dialogSize = MediaQuery.of(context).size;

    return AlertDialog(
      content: DecoratedBox(
        decoration: CardDecoration.getMiniDecoration(CardType.savingAccounts),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dialogSize.width / 10,
            vertical: dialogSize.height / 50,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: getDialogContent(widget.cardType, dialogSize),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
