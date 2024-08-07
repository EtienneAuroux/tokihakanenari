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

  String get title {
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
        return 'Salaries';
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
