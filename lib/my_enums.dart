import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum CardSize { big, mini, small }

enum CardStatus { inert, unroll, roll, drop }

enum CardType {
  addCard,
  contentCreation,
  customIncome,
  indexFunds,
  privateFunds,
  realEstate,
  salaries,
  savingAccounts,
  stockAccounts,
  totalIncome,
  settings;

  String title(BuildContext context) {
    switch (this) {
      case CardType.addCard:
        return 'New source of income';
      case CardType.contentCreation:
        return 'Content creation';
      case CardType.customIncome:
        return 'Custom incomes';
      case CardType.indexFunds:
        return 'Index funds';
      case CardType.privateFunds:
        return 'Private funds';
      case CardType.realEstate:
        return 'Real estate';
      case CardType.salaries:
        return AppLocalizations.of(context)!.salaries;
      case CardType.savingAccounts:
        return 'Saving accounts';
      case CardType.stockAccounts:
        return 'Stock accounts';
      case CardType.totalIncome:
        return 'Total income';
      case CardType.settings:
        return 'Settings';
    }
  }

  String item(BuildContext context) {
    switch (this) {
      case CardType.addCard:
        throw ErrorDescription('AddCard does not have a CardType.item.');
      case CardType.contentCreation:
        return 'Content:';
      case CardType.customIncome:
        return 'Income:';
      case CardType.indexFunds:
      case CardType.privateFunds:
        return 'Fund:';
      case CardType.realEstate:
        return 'Property:';
      case CardType.salaries:
        return 'Salary:';
      case CardType.savingAccounts:
      case CardType.stockAccounts:
        return 'Account:';
      case CardType.totalIncome:
        throw ErrorDescription('TotalIncome does not have a CardType.item.');
      case CardType.settings:
        throw ErrorDescription('Settings do not have a CardType.item.');
    }
  }
}

enum MainView { carousel, primaryBigCard, secondaryBigCard }

enum TimePeriod { day, week, month, year }

enum Setting { none, general, color, danger }

enum Currency {
  none,
  usd,
  eur,
  gbp,
  yen;

  String get word {
    switch (this) {
      case Currency.none:
        return '';
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
      case Currency.gbp:
        return '£';
      case Currency.yen:
        return '¥';
    }
  }
}

enum Language {
  english,
  french,
  japanese;

  String get word {
    switch (this) {
      case Language.english:
        return 'English';
      case Language.french:
        return 'Français';
      case Language.japanese:
        return '日本語';
    }
  }
}
