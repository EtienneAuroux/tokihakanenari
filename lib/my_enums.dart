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
        return AppLocalizations.of(context)!.addCard;
      case CardType.contentCreation:
        return AppLocalizations.of(context)!.contentCreation;
      case CardType.customIncome:
        return AppLocalizations.of(context)!.customIncomes;
      case CardType.indexFunds:
        return AppLocalizations.of(context)!.indexFunds;
      case CardType.privateFunds:
        return AppLocalizations.of(context)!.privateFunds;
      case CardType.realEstate:
        return AppLocalizations.of(context)!.realEstate;
      case CardType.salaries:
        return AppLocalizations.of(context)!.salaries;
      case CardType.savingAccounts:
        return AppLocalizations.of(context)!.savingAccounts;
      case CardType.stockAccounts:
        return AppLocalizations.of(context)!.stockAccounts;
      case CardType.totalIncome:
        return AppLocalizations.of(context)!.totalIncome;
      case CardType.settings:
        return AppLocalizations.of(context)!.settings;
    }
  }

  String item(BuildContext context) {
    switch (this) {
      case CardType.addCard:
        throw ErrorDescription('AddCard does not have a CardType.item.');
      case CardType.contentCreation:
        return AppLocalizations.of(context)!.content;
      case CardType.customIncome:
        return AppLocalizations.of(context)!.income;
      case CardType.indexFunds:
      case CardType.privateFunds:
        return AppLocalizations.of(context)!.fund;
      case CardType.realEstate:
        return AppLocalizations.of(context)!.property;
      case CardType.salaries:
        return AppLocalizations.of(context)!.salary;
      case CardType.savingAccounts:
      case CardType.stockAccounts:
        return AppLocalizations.of(context)!.account;
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
