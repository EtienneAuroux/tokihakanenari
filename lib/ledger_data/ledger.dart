import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokihakanenari/ledger_data/color_gradient.dart';
import 'package:tokihakanenari/ledger_data/data.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'dart:developer' as developer;

class Ledger extends ChangeNotifier {
  // Private constructor to prevent external instantiation.
  Ledger._();

  // The single instance of the class.
  static final Ledger _ledger = Ledger._();

  // Factory constructor to provide access to the singleton instance.
  factory Ledger() {
    return _ledger;
  }

  // Loading preferences.
  late SharedPreferences _preferences;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    await _readLedger();
  }

  bool _startTapIndicator = false;
  set startTapIndicator(bool status) {
    notifyListeners();
    _startTapIndicator = status;
  }

  bool get startTapIndicator => _startTapIndicator;

  // Cards
  late ContentCreationData _contentCreationData;
  late CustomIncomeData _customIncomeData;
  late IndexFundsData _indexFundsData;
  late PrivateFundsData _privateFundsData;
  late RealEstateData _realEstateData;
  late SalariesData _salariesData;
  late SavingAccountsData _savingAccountsData;
  late StockAccountsData _stockAccountsData;

  ContentCreationData get contentCreationData => _contentCreationData;
  CustomIncomeData get customIncomeData => _customIncomeData;
  IndexFundsData get indexFundsData => _indexFundsData;
  PrivateFundsData get privateFundsData => _privateFundsData;
  RealEstateData get realEstateData => _realEstateData;
  SalariesData get salariesData => _salariesData;
  SavingAccountsData get savingAccountsData => _savingAccountsData;
  StockAccountsData get stockAccountsData => _stockAccountsData;
  TotalIncomeData get totalIncomeData {
    return _getTotalIncomeData(_carouselCards);
  }

  // Settings
  late Currency _currency;
  Currency get currency => _currency;
  set currency(Currency newCurrency) {
    _currency = newCurrency;
    _preferences.setInt('currency', _currency.index);
    notifyListeners();
  }

  late Background _background;
  Background get background => _background;
  set background(Background newBackground) {
    _background = newBackground;
    _preferences.setInt('backgroundType', background.index);
    notifyListeners();
  }

  // Formats
  String formatMonetaryAmounts(double amount, bool percent, BuildContext context) {
    String unit = percent ? '% / ${AppLocalizations.of(context)!.year}' : currency.word;
    if (amount >= 1e3 && amount < 1e6) {
      String roundedAmount = amount.round().toString();
      return '${roundedAmount.substring(0, roundedAmount.length - 3)} ${roundedAmount.substring(roundedAmount.length - 3)} $unit';
    } else if (amount >= 1e6 && amount < 1e9) {
      return '${(amount / 1e6).toStringAsFixed(2)} M$unit';
    } else if (amount >= 1e9 && amount < 1e12) {
      return '${(amount / 1e9).toStringAsFixed(2)} B$unit';
    } else if (amount >= 1e12 && amount < 1e15) {
      return '${(amount / 1e12).toStringAsFixed(2)} T$unit';
    } else if (amount >= 1e15) {
      return '${amount.toStringAsExponential(2)} $unit';
    } else {
      return '${amount.round()} $unit';
    }
  }

  // Carousel
  List<CardType> _carouselCards = <CardType>[
    CardType.totalIncome,
    CardType.addCard,
  ];
  List<CardType> get carouselCards => _carouselCards;

  int _pageInFocus = 50 * 2; // Only 2 cards originally.
  int get pageInFocus => _pageInFocus;

  void addCarouselCard(CardType cardType, {bool addCard = false}) {
    bool oddNumberOfCard = _carouselCards.length.isOdd;
    int newCardEvenIndex = (_carouselCards.length / 2).floor();
    if (!_carouselCards.contains(cardType) && !addCard) {
      _carouselCards.insert(oddNumberOfCard ? newCardEvenIndex - 1 : newCardEvenIndex, cardType);
      _pageInFocus = 50 * _carouselCards.length + (oddNumberOfCard ? newCardEvenIndex - 1 : newCardEvenIndex);
    } else if (addCard) {
      _carouselCards.insert(0, CardType.addCard);
    }
    notifyListeners();
    if (_carouselCards.length == CardType.values.length - 1 && !addCard) {
      deleteCarouselCard(CardType.addCard);
    }
  }

  void deleteCarouselCard(CardType cardType, {bool fullReset = false}) {
    switch (cardType) {
      case CardType.addCard:
        break;
      case CardType.contentCreation:
        _contentCreationData.icons.clear();
        _contentCreationData.names.clear();
        _contentCreationData.revenues.clear();
        _contentCreationData.timePeriods.clear();
        _contentCreationData.perDay.clear();
        _contentCreationData.totalIncome = 0;
        _contentCreationData.totalPerDay = 0;
        break;
      case CardType.customIncome:
        _customIncomeData.icons.clear();
        _customIncomeData.names.clear();
        _customIncomeData.amounts.clear();
        _customIncomeData.interests.clear();
        _customIncomeData.revenues.clear();
        _customIncomeData.ratesOfReturn.clear();
        _customIncomeData.perDay.clear();
        _customIncomeData.totalInvested = 0;
        _customIncomeData.totalPerDay = 0;
        _customIncomeData.totalRateOfReturn = 0;
        break;
      case CardType.indexFunds:
        _indexFundsData.icons.clear();
        _indexFundsData.names.clear();
        _indexFundsData.amounts.clear();
        _indexFundsData.ratesOfReturn.clear();
        _indexFundsData.perDay.clear();
        _indexFundsData.totalInvested = 0;
        _indexFundsData.totalPerDay = 0;
        _indexFundsData.totalRateOfReturn = 0;
        break;
      case CardType.privateFunds:
        _privateFundsData.icons.clear();
        _privateFundsData.names.clear();
        _privateFundsData.amounts.clear();
        _privateFundsData.ratesOfReturn.clear();
        _privateFundsData.perDay.clear();
        _privateFundsData.totalInvested = 0;
        _privateFundsData.totalPerDay = 0;
        _privateFundsData.totalRateOfReturn = 0;
        break;
      case CardType.realEstate:
        _realEstateData.icons.clear();
        _realEstateData.locations.clear();
        _realEstateData.descriptions.clear();
        _realEstateData.capitals.clear();
        _realEstateData.payments.clear();
        _realEstateData.revenues.clear();
        _realEstateData.appreciations.clear();
        _realEstateData.registeredDates.clear();
        _realEstateData.ratesOfReturn.clear();
        _realEstateData.perDay.clear();
        _realEstateData.totalInvested = 0;
        _realEstateData.totalPerDay = 0;
        _realEstateData.totalRateOfReturn = 0;
        break;
      case CardType.salaries:
        _salariesData.icons.clear();
        _salariesData.names.clear();
        _salariesData.salaries.clear();
        _salariesData.timePeriods.clear();
        _salariesData.perDay.clear();
        _salariesData.totalIncome = 0;
        _salariesData.totalPerDay = 0;
        break;
      case CardType.savingAccounts:
        _savingAccountsData.icons.clear();
        _savingAccountsData.names.clear();
        _savingAccountsData.amounts.clear();
        _savingAccountsData.ratesOfReturn.clear();
        _savingAccountsData.perDay.clear();
        _savingAccountsData.totalInvested = 0;
        _savingAccountsData.totalPerDay = 0;
        _savingAccountsData.totalRateOfReturn = 0;
      case CardType.stockAccounts:
        _stockAccountsData.icons.clear();
        _stockAccountsData.names.clear();
        _stockAccountsData.amounts.clear();
        _stockAccountsData.ratesOfReturn.clear();
        _stockAccountsData.perDay.clear();
        _stockAccountsData.totalInvested = 0;
        _stockAccountsData.totalPerDay = 0;
        _stockAccountsData.totalRateOfReturn = 0;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to remove TotalIncome.');
      case CardType.settings:
        throw ErrorDescription('It should not be possible to have a Settings card in the carousel.');
    }

    if (!_carouselCards.contains(CardType.addCard)) {
      addCarouselCard(CardType.addCard, addCard: true);
    }

    int deletedCardIndex = _carouselCards.indexOf(cardType);
    _carouselCards.remove(cardType);
    _pageInFocus = 50 * _carouselCards.length + deletedCardIndex;
    if (!fullReset) {
      notifyListeners();
      _saveLedger();
    }
  }

  void deleteAllData() {
    for (CardType cardType in CardType.values) {
      if (cardType != CardType.addCard && cardType != CardType.totalIncome && cardType != CardType.settings) {
        deleteCarouselCard(cardType, fullReset: true);
      }
    }
    notifyListeners();
    _saveLedger();
  }

  void addCardData(CardType cardType, List<dynamic> data) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to add data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.icons.add(data[0]);
        _contentCreationData.names.add(data[1]);
        _contentCreationData.revenues.add(double.parse(data[2]));
        _contentCreationData.timePeriods.add(data[3]);
        _contentCreationData.perDay.add(0);
        break;
      case CardType.customIncome:
        _customIncomeData.icons.add(data[0]);
        _customIncomeData.names.add(data[1]);
        _customIncomeData.amounts.add(double.parse(data[2]));
        _customIncomeData.revenues.add(double.parse(data[3]));
        _customIncomeData.interests.add(double.parse(data[4]));
        _customIncomeData.ratesOfReturn.add(0);
        _customIncomeData.perDay.add(0);
      case CardType.indexFunds:
        _indexFundsData.icons.add(data[0]);
        _indexFundsData.names.add(data[1]);
        _indexFundsData.amounts.add(double.parse(data[2]));
        _indexFundsData.ratesOfReturn.add(double.parse(data[3]));
        _indexFundsData.perDay.add(0);
        break;
      case CardType.privateFunds:
        _privateFundsData.icons.add(data[0]);
        _privateFundsData.names.add(data[1]);
        _privateFundsData.amounts.add(double.parse(data[2]));
        _privateFundsData.ratesOfReturn.add(double.parse(data[3]));
        _privateFundsData.perDay.add(0);
        break;
      case CardType.realEstate:
        _realEstateData.icons.add(data[0]);
        _realEstateData.locations.add(data[1]);
        _realEstateData.descriptions.add(data[2]);
        _realEstateData.capitals.add(double.parse(data[3]));
        _realEstateData.payments.add(double.parse(data[4]));
        _realEstateData.revenues.add(double.parse(data[5]));
        _realEstateData.appreciations.add(double.parse(data[6]));
        _realEstateData.ratesOfReturn.add(0);
        _realEstateData.registeredDates.add(data[7]);
        _realEstateData.perDay.add(0);
        break;
      case CardType.salaries:
        _salariesData.icons.add(data[0]);
        _salariesData.names.add(data[1]);
        _salariesData.salaries.add(double.parse(data[2]));
        _salariesData.timePeriods.add(data[3]);
        _salariesData.perDay.add(0);
        break;
      case CardType.savingAccounts:
        _savingAccountsData.icons.add(data[0]);
        _savingAccountsData.names.add(data[1]);
        _savingAccountsData.amounts.add(double.parse(data[2]));
        _savingAccountsData.ratesOfReturn.add(double.parse(data[3]));
        _savingAccountsData.perDay.add(0);
        break;
      case CardType.stockAccounts:
        _stockAccountsData.icons.add(data[0]);
        _stockAccountsData.names.add(data[1]);
        _stockAccountsData.amounts.add(double.parse(data[2]));
        _stockAccountsData.ratesOfReturn.add(double.parse(data[3]));
        _stockAccountsData.perDay.add(0);
        break;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to add data to TotalIncome.');
      case CardType.settings:
        throw ErrorDescription('It should not be possible to add data to Settings.');
    }

    _aggregateData(cardType);
    notifyListeners();
    _saveLedger();
  }

  void deleteCardData(CardType cardType, int index) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to delete data from AddCard.');
      case CardType.contentCreation:
        _contentCreationData.icons.removeAt(index);
        _contentCreationData.names.removeAt(index);
        _contentCreationData.revenues.removeAt(index);
        _contentCreationData.timePeriods.removeAt(index);
        _contentCreationData.perDay.removeAt(index);
        break;
      case CardType.customIncome:
        _customIncomeData.icons.removeAt(index);
        _customIncomeData.names.removeAt(index);
        _customIncomeData.amounts.removeAt(index);
        _customIncomeData.interests.removeAt(index);
        _customIncomeData.revenues.removeAt(index);
        _customIncomeData.ratesOfReturn.removeAt(index);
        _customIncomeData.perDay.removeAt(index);
        break;
      case CardType.indexFunds:
        _indexFundsData.icons.removeAt(index);
        _indexFundsData.names.removeAt(index);
        _indexFundsData.amounts.removeAt(index);
        _indexFundsData.ratesOfReturn.removeAt(index);
        _indexFundsData.perDay.removeAt(index);
        break;
      case CardType.privateFunds:
        _privateFundsData.icons.removeAt(index);
        _privateFundsData.names.removeAt(index);
        _privateFundsData.amounts.removeAt(index);
        _privateFundsData.ratesOfReturn.removeAt(index);
        _privateFundsData.perDay.removeAt(index);
        break;
      case CardType.realEstate:
        _realEstateData.icons.removeAt(index);
        _realEstateData.locations.removeAt(index);
        _realEstateData.descriptions.removeAt(index);
        _realEstateData.capitals.removeAt(index);
        _realEstateData.payments.removeAt(index);
        _realEstateData.revenues.removeAt(index);
        _realEstateData.appreciations.removeAt(index);
        _realEstateData.ratesOfReturn.removeAt(index);
        _realEstateData.registeredDates.removeAt(index);
        _realEstateData.perDay.removeAt(index);
        break;
      case CardType.salaries:
        _salariesData.icons.removeAt(index);
        _salariesData.names.removeAt(index);
        _salariesData.salaries.removeAt(index);
        _salariesData.timePeriods.removeAt(index);
        _salariesData.perDay.removeAt(index);
        break;
      case CardType.savingAccounts:
        _savingAccountsData.icons.removeAt(index);
        _savingAccountsData.names.removeAt(index);
        _savingAccountsData.amounts.removeAt(index);
        _savingAccountsData.ratesOfReturn.removeAt(index);
        _savingAccountsData.perDay.removeAt(index);
        break;
      case CardType.stockAccounts:
        _stockAccountsData.icons.removeAt(index);
        _stockAccountsData.names.removeAt(index);
        _stockAccountsData.amounts.removeAt(index);
        _stockAccountsData.ratesOfReturn.removeAt(index);
        _stockAccountsData.perDay.removeAt(index);
        break;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to delete data from TotalIncome.');
      case CardType.settings:
        throw ErrorDescription('It should not be possible to delete data from Settings.');
    }

    _aggregateData(cardType);
    notifyListeners();
    _saveLedger();
  }

  void updateCardData(CardType cardType, int index, List<dynamic> data) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to update data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.icons[index] = data[0];
        _contentCreationData.names[index] = data[1];
        _contentCreationData.revenues[index] = double.parse(data[2]);
        _contentCreationData.timePeriods[index] = data[3];
        break;
      case CardType.customIncome:
        _customIncomeData.icons[index] = data[0];
        _customIncomeData.names[index] = data[1];
        _customIncomeData.amounts[index] = double.parse(data[2]);
        _customIncomeData.revenues[index] = double.parse(data[3]);
        _customIncomeData.interests[index] = double.parse(data[4]);
      case CardType.indexFunds:
        _indexFundsData.icons[index] = data[0];
        _indexFundsData.names[index] = data[1];
        _indexFundsData.amounts[index] = double.parse(data[2]);
        _indexFundsData.ratesOfReturn[index] = double.parse(data[3]);
        break;
      case CardType.privateFunds:
        _privateFundsData.icons[index] = data[0];
        _privateFundsData.names[index] = data[1];
        _privateFundsData.amounts[index] = double.parse(data[2]);
        _privateFundsData.ratesOfReturn[index] = double.parse(data[3]);
        break;
      case CardType.realEstate:
        _realEstateData.icons[index] = data[0];
        _realEstateData.locations[index] = data[1];
        _realEstateData.descriptions[index] = data[2];
        _realEstateData.capitals[index] = double.parse(data[3]);
        _realEstateData.payments[index] = double.parse(data[4]);
        _realEstateData.revenues[index] = double.parse(data[5]);
        _realEstateData.appreciations[index] = double.parse(data[6]);
        // TODO REGISTERED DATE IS A PROBLEM HERE.
        break;
      case CardType.salaries:
        _salariesData.icons[index] = data[0];
        _salariesData.names[index] = data[1];
        _salariesData.salaries[index] = double.parse(data[2]);
        _salariesData.timePeriods[index] = data[3];
        break;
      case CardType.savingAccounts:
        _savingAccountsData.icons[index] = data[0];
        _savingAccountsData.names[index] = data[1];
        _savingAccountsData.amounts[index] = double.parse(data[2]);
        _savingAccountsData.ratesOfReturn[index] = double.parse(data[3]);
        break;
      case CardType.stockAccounts:
        _stockAccountsData.icons[index] = data[0];
        _stockAccountsData.names[index] = data[1];
        _stockAccountsData.amounts[index] = double.parse(data[2]);
        _stockAccountsData.ratesOfReturn[index] = double.parse(data[3]);
        break;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to update data to TotalIncome.');
      case CardType.settings:
        throw ErrorDescription('It should not be possible to update data to Settings.');
    }

    _aggregateData(cardType);
    notifyListeners();
    _saveLedger();
  }

  // Color gradients
  late ColorGradient _backgroundGradient;
  late ColorGradient _addCardGradient;
  late ColorGradient _totalIncomeGradient;

  ColorGradient get backgroundGradient => _backgroundGradient;
  ColorGradient get addCardGradient => _addCardGradient;
  ColorGradient get totalIncomeGradient => _totalIncomeGradient;

  ColorGradient getCardGradient(CardType? cardType) {
    if (cardType == null) {
      return _backgroundGradient;
    } else {
      switch (cardType) {
        case CardType.addCard:
          return _addCardGradient;
        case CardType.contentCreation:
          return _contentCreationData.gradient;
        case CardType.customIncome:
          return _customIncomeData.gradient;
        case CardType.indexFunds:
          return _indexFundsData.gradient;
        case CardType.privateFunds:
          return _privateFundsData.gradient;
        case CardType.realEstate:
          return _realEstateData.gradient;
        case CardType.salaries:
          return salariesData.gradient;
        case CardType.savingAccounts:
          return savingAccountsData.gradient;
        case CardType.stockAccounts:
          return stockAccountsData.gradient;
        case CardType.totalIncome:
          return _totalIncomeGradient;
        case CardType.settings:
          throw ErrorDescription('It is not be possible to change the color of the Settings card.');
      }
    }
  }

  void setCardGradient(CardType? cardType, Color newBottom, Color newTopRight) {
    if (cardType == null) {
      _backgroundGradient.bottom = newBottom;
      _backgroundGradient.topRight = newTopRight;
    } else {
      switch (cardType) {
        case CardType.addCard:
          _addCardGradient.bottom = newBottom;
          _addCardGradient.topRight = newTopRight;
          break;
        case CardType.contentCreation:
          _contentCreationData.gradient.bottom = newBottom;
          _contentCreationData.gradient.topRight = newTopRight;
          break;
        case CardType.customIncome:
          _customIncomeData.gradient.bottom = newBottom;
          _customIncomeData.gradient.topRight = newTopRight;
          break;
        case CardType.indexFunds:
          _indexFundsData.gradient.bottom = newBottom;
          _indexFundsData.gradient.topRight = newTopRight;
          break;
        case CardType.privateFunds:
          _privateFundsData.gradient.bottom = newBottom;
          _privateFundsData.gradient.topRight = newTopRight;
          break;
        case CardType.realEstate:
          _realEstateData.gradient.bottom = newBottom;
          _realEstateData.gradient.topRight = newTopRight;
          break;
        case CardType.salaries:
          salariesData.gradient.bottom = newBottom;
          salariesData.gradient.topRight = newTopRight;
          break;
        case CardType.savingAccounts:
          savingAccountsData.gradient.bottom = newBottom;
          savingAccountsData.gradient.topRight = newTopRight;
          break;
        case CardType.stockAccounts:
          stockAccountsData.gradient.bottom = newBottom;
          stockAccountsData.gradient.topRight = newTopRight;
          break;
        case CardType.totalIncome:
          _totalIncomeGradient.bottom = newBottom;
          _totalIncomeGradient.topRight = newTopRight;
          break;
        case CardType.settings:
          throw ErrorDescription('It is not be possible to change the color of the Settings card.');
      }
    }
    notifyListeners();
    _saveLedger();
  }

  void resetCardGradient(CardType? cardType, {bool fullReset = false}) {
    if (cardType == null) {
      _backgroundGradient = ColorGradient(ColorPalette.mirrorGrey, ColorPalette.mirrorYellow);
    } else {
      switch (cardType) {
        case CardType.addCard:
          _addCardGradient = ColorGradient(ColorPalette.silkBeige, ColorPalette.silkWhite);
          break;
        case CardType.contentCreation:
          _contentCreationData.gradient = ColorGradient(ColorPalette.sanguineRed, ColorPalette.sanguineOrange);
          break;
        case CardType.customIncome:
          _customIncomeData.gradient = ColorGradient(ColorPalette.sunOrange, ColorPalette.sunYellow);
          break;
        case CardType.indexFunds:
          _indexFundsData.gradient = ColorGradient(ColorPalette.pigletPink, ColorPalette.pigletPale);
          break;
        case CardType.privateFunds:
          _privateFundsData.gradient = ColorGradient(ColorPalette.lusciousGreen, ColorPalette.lusciousYellow);
          break;
        case CardType.realEstate:
          _realEstateData.gradient = ColorGradient(ColorPalette.bleachedGreen, ColorPalette.bleachedOrange);
          break;
        case CardType.salaries:
          salariesData.gradient = ColorGradient(ColorPalette.orbitPurple, ColorPalette.orbitGreen);
          break;
        case CardType.savingAccounts:
          savingAccountsData.gradient = ColorGradient(ColorPalette.exoticPink, ColorPalette.exoticOrange);
          break;
        case CardType.stockAccounts:
          stockAccountsData.gradient = ColorGradient(ColorPalette.toxicYellow, ColorPalette.toxicBlue);
          break;
        case CardType.totalIncome:
          _totalIncomeGradient = ColorGradient(ColorPalette.oceanBlue, ColorPalette.oceanOpal);
          break;
        case CardType.settings:
          throw ErrorDescription('It is not be possible to change the color of the Settings card.');
      }
    }
    if (!fullReset) {
      notifyListeners();
      _saveLedger();
    }
  }

  void resetAllGradients() {
    for (CardType cardType in CardType.values) {
      if (cardType == CardType.settings) {
        resetCardGradient(null, fullReset: true);
      } else {
        resetCardGradient(cardType, fullReset: true);
      }
    }
    notifyListeners();
    _saveLedger();
  }

  // Private methods
  void _aggregateData(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to aggregate data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.totalIncome = 0;
        _contentCreationData.totalPerDay = 0;
        for (int i = 0; i < _contentCreationData.names.length; i++) {
          switch (_contentCreationData.timePeriods[i]) {
            case TimePeriod.day:
              _contentCreationData.totalIncome += _contentCreationData.revenues[i] * 365.25;
              _contentCreationData.perDay[i] = _contentCreationData.revenues[i];
            case TimePeriod.week:
              _contentCreationData.totalIncome += _contentCreationData.revenues[i] * 52;
              _contentCreationData.perDay[i] = _contentCreationData.revenues[i] / 7;
            case TimePeriod.month:
              _contentCreationData.totalIncome += _contentCreationData.revenues[i] * 12;
              _contentCreationData.perDay[i] = _contentCreationData.revenues[i] / 30.437;
            case TimePeriod.year:
              _contentCreationData.totalIncome += _contentCreationData.revenues[i];
              _contentCreationData.perDay[i] = _contentCreationData.revenues[i] / 365.25;
          }
          _contentCreationData.totalPerDay += _contentCreationData.perDay[i];
        }
        break;
      case CardType.customIncome:
        _customIncomeData.totalInvested = 0;
        _customIncomeData.totalPerDay = 0;
        double sumFullReturns = 0;
        for (int i = 0; i < _customIncomeData.names.length; i++) {
          _customIncomeData.totalInvested += _customIncomeData.amounts[i];
          double fullReturn;
          if (_customIncomeData.amounts[i] == 0) {
            fullReturn = 0;
            _customIncomeData.ratesOfReturn[i] += 0;
          } else {
            fullReturn = _customIncomeData.interests[i] + _customIncomeData.revenues[i] / _customIncomeData.amounts[i];
            _customIncomeData.ratesOfReturn[i] += fullReturn;
          }
          _customIncomeData.perDay[i] = fullReturn / 365.25;
          _customIncomeData.totalPerDay += _customIncomeData.perDay[i];
          sumFullReturns += _customIncomeData.ratesOfReturn[i];
        }
        _customIncomeData.totalRateOfReturn = sumFullReturns / _customIncomeData.names.length;
        // _customIncomeData.totalPerDay = _customIncomeData.totalInvested * _customIncomeData.totalRateOfReturn / 100 / 365.25;
        break;
      case CardType.indexFunds:
        _indexFundsData.totalInvested = 0;
        double sumYearlyIncreases = 0;
        for (int i = 0; i < _indexFundsData.names.length; i++) {
          _indexFundsData.totalInvested += _indexFundsData.amounts[i];
          double yearlyIncrease = _indexFundsData.amounts[i] * _indexFundsData.ratesOfReturn[i] / 100;
          sumYearlyIncreases += yearlyIncrease;
          _indexFundsData.perDay[i] = yearlyIncrease / 365.25;
        }
        if (_indexFundsData.totalInvested == 0) {
          _indexFundsData.totalRateOfReturn = 0;
        } else {
          _indexFundsData.totalRateOfReturn = 100 * sumYearlyIncreases / _indexFundsData.totalInvested;
        }
        _indexFundsData.totalPerDay = _indexFundsData.totalInvested * _indexFundsData.totalRateOfReturn / 100 / 365.25;
        break;
      case CardType.privateFunds:
        _privateFundsData.totalInvested = 0;
        double sumYearlyIncreases = 0;
        for (int i = 0; i < _privateFundsData.names.length; i++) {
          _privateFundsData.totalInvested += _privateFundsData.amounts[i];
          double yearlyIncrease = _privateFundsData.amounts[i] * _privateFundsData.ratesOfReturn[i] / 100;
          sumYearlyIncreases += yearlyIncrease;
          _privateFundsData.perDay[i] = yearlyIncrease / 365.25;
        }
        if (_privateFundsData.totalInvested == 0) {
          _privateFundsData.totalRateOfReturn = 0;
        } else {
          _privateFundsData.totalRateOfReturn = 100 * sumYearlyIncreases / _privateFundsData.totalInvested;
        }
        _privateFundsData.totalPerDay = _privateFundsData.totalInvested * _privateFundsData.totalRateOfReturn / 100 / 365.25;
        break;
      case CardType.realEstate:
        _realEstateData.totalInvested = 0;
        _realEstateData.totalPerDay = 0;
        double sumFullReturns = 0;
        List<double> sumOfPayments = List.generate(_realEstateData.locations.length, (index) => 0);
        for (int i = 0; i < _realEstateData.locations.length; i++) {
          int monthElapsed = (DateTime.now().difference(_realEstateData.registeredDates[i]).inDays / 30.437).floor();
          sumOfPayments[i] = _realEstateData.payments[i] * monthElapsed;
          _realEstateData.capitals[i] += sumOfPayments[i];
          _realEstateData.totalInvested += _realEstateData.capitals[i];
          if (_realEstateData.capitals[i] == 0) {
            _realEstateData.ratesOfReturn[i] = 0;
          } else {
            _realEstateData.ratesOfReturn[i] = _realEstateData.appreciations[i] + _realEstateData.revenues[i] / _realEstateData.capitals[i];
          }
          _realEstateData.perDay[i] = _realEstateData.capitals[i] * _realEstateData.ratesOfReturn[i] / 100 / 365.25;
          _realEstateData.totalPerDay += _realEstateData.perDay[i];
          sumFullReturns += _realEstateData.ratesOfReturn[i];
        }
        _realEstateData.totalRateOfReturn = sumFullReturns / _realEstateData.locations.length;
        break;
      case CardType.salaries:
        _salariesData.totalIncome = 0;
        _salariesData.totalPerDay = 0;
        for (int i = 0; i < _salariesData.names.length; i++) {
          switch (_salariesData.timePeriods[i]) {
            case TimePeriod.day:
              _salariesData.totalIncome += _salariesData.salaries[i] * 365.25;
              _salariesData.perDay[i] = _salariesData.salaries[i];
            case TimePeriod.week:
              _salariesData.totalIncome += _salariesData.salaries[i] * 52;
              _salariesData.perDay[i] = _salariesData.salaries[i] / 7;
            case TimePeriod.month:
              _salariesData.totalIncome += _salariesData.salaries[i] * 12;
              _salariesData.perDay[i] = _salariesData.salaries[i] / 30.437;
            case TimePeriod.year:
              _salariesData.totalIncome += _salariesData.salaries[i];
              _salariesData.perDay[i] = _salariesData.salaries[i] / 365.25;
          }
          _salariesData.totalPerDay += _salariesData.perDay[i];
        }
        break;
      case CardType.savingAccounts:
        _savingAccountsData.totalInvested = 0;
        double sumYearlyIncreases = 0;
        for (int i = 0; i < _savingAccountsData.names.length; i++) {
          _savingAccountsData.totalInvested += _savingAccountsData.amounts[i];
          double yearlyIncrease = _savingAccountsData.amounts[i] * _savingAccountsData.ratesOfReturn[i] / 100;
          sumYearlyIncreases += yearlyIncrease;
          _savingAccountsData.perDay[i] = yearlyIncrease / 365.25;
        }
        if (_savingAccountsData.totalInvested == 0) {
          _savingAccountsData.totalRateOfReturn = 0;
        } else {
          _savingAccountsData.totalRateOfReturn = 100 * sumYearlyIncreases / _savingAccountsData.totalInvested;
        }
        _savingAccountsData.totalPerDay = _savingAccountsData.totalInvested * _savingAccountsData.totalRateOfReturn / 100 / 365.25;
        break;
      case CardType.stockAccounts:
        _stockAccountsData.totalInvested = 0;
        double sumYearlyIncreases = 0;
        for (int i = 0; i < _stockAccountsData.names.length; i++) {
          _stockAccountsData.totalInvested += _stockAccountsData.amounts[i];
          double yearlyIncrease = _stockAccountsData.amounts[i] * _stockAccountsData.ratesOfReturn[i] / 100;
          sumYearlyIncreases += yearlyIncrease;
          _stockAccountsData.perDay[i] = yearlyIncrease / 365.25;
        }
        if (_stockAccountsData.totalInvested == 0) {
          _stockAccountsData.totalRateOfReturn = 0;
        } else {
          _stockAccountsData.totalRateOfReturn = 100 * sumYearlyIncreases / _stockAccountsData.totalInvested;
        }
        _stockAccountsData.totalPerDay = _stockAccountsData.totalInvested * _stockAccountsData.totalRateOfReturn / 100 / 365.25;
        break;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to aggregate data to TotalIncome.');
      case CardType.settings:
        throw ErrorDescription('It should not be possible to aggregate data to Settings.');
    }
  }

  TotalIncomeData _getTotalIncomeData(List<CardType> cards) {
    TotalIncomeData totalIncomeData = TotalIncomeData();
    totalIncomeData.incomesPerDay.clear();
    for (CardType cardType in cards) {
      switch (cardType) {
        case CardType.addCard:
          break;
        case CardType.contentCreation:
          totalIncomeData.incomesType.add(CardType.contentCreation);
          totalIncomeData.incomesPerDay.add(_contentCreationData.totalPerDay);
          totalIncomeData.totalIncomePerDay += _contentCreationData.totalPerDay;
          break;
        case CardType.customIncome:
          totalIncomeData.incomesType.add(CardType.customIncome);
          totalIncomeData.incomesPerDay.add(_customIncomeData.totalPerDay);
          totalIncomeData.totalInvested += _customIncomeData.totalInvested;
          totalIncomeData.totalIncomePerDay += _customIncomeData.totalPerDay;
          totalIncomeData.totalRateOfReturn += (_customIncomeData.totalInvested * _customIncomeData.totalRateOfReturn / 100);
        case CardType.indexFunds:
          totalIncomeData.incomesType.add(CardType.indexFunds);
          totalIncomeData.incomesPerDay.add(_indexFundsData.totalPerDay);
          totalIncomeData.totalInvested += _indexFundsData.totalInvested;
          totalIncomeData.totalIncomePerDay += _indexFundsData.totalPerDay;
          totalIncomeData.totalRateOfReturn += (_indexFundsData.totalInvested * _indexFundsData.totalRateOfReturn / 100);
          break;
        case CardType.privateFunds:
          totalIncomeData.incomesType.add(CardType.privateFunds);
          totalIncomeData.incomesPerDay.add(_privateFundsData.totalPerDay);
          totalIncomeData.totalInvested += _privateFundsData.totalInvested;
          totalIncomeData.totalIncomePerDay += _privateFundsData.totalPerDay;
          totalIncomeData.totalRateOfReturn += (_privateFundsData.totalInvested * _privateFundsData.totalRateOfReturn / 100);
          break;
        case CardType.realEstate:
          totalIncomeData.incomesType.add(CardType.realEstate);
          totalIncomeData.incomesPerDay.add(_realEstateData.totalPerDay);
          totalIncomeData.totalInvested += _realEstateData.totalInvested;
          totalIncomeData.totalIncomePerDay += _realEstateData.totalPerDay;
          totalIncomeData.totalRateOfReturn += (_realEstateData.totalInvested * _realEstateData.totalRateOfReturn / 100);
          break;
        case CardType.salaries:
          totalIncomeData.incomesType.add(CardType.salaries);
          totalIncomeData.incomesPerDay.add(_salariesData.totalPerDay);
          totalIncomeData.totalIncomePerDay += _salariesData.totalPerDay;
          break;
        case CardType.savingAccounts:
          totalIncomeData.incomesType.add(CardType.savingAccounts);
          totalIncomeData.incomesPerDay.add(_savingAccountsData.totalPerDay);
          totalIncomeData.totalInvested += _savingAccountsData.totalInvested;
          totalIncomeData.totalIncomePerDay += _savingAccountsData.totalPerDay;
          totalIncomeData.totalRateOfReturn += (_savingAccountsData.totalInvested * _savingAccountsData.totalRateOfReturn / 100);
          break;
        case CardType.stockAccounts:
          totalIncomeData.incomesType.add(CardType.stockAccounts);
          totalIncomeData.incomesPerDay.add(_stockAccountsData.totalPerDay);
          totalIncomeData.totalInvested += _stockAccountsData.totalInvested;
          totalIncomeData.totalIncomePerDay += _stockAccountsData.totalPerDay;
          totalIncomeData.totalRateOfReturn += (_stockAccountsData.totalInvested * _stockAccountsData.totalRateOfReturn / 100);
          break;
        case CardType.totalIncome:
          break;
        case CardType.settings:
          break;
      }
    }
    totalIncomeData.totalRateOfReturn /= totalIncomeData.totalInvested;
    return totalIncomeData;
  }

  // Read and Save data.
  Future<void> _readLedger() async {
    int? currencyInt = _preferences.getInt('currency');
    if (currencyInt != null) {
      _currency = Currency.values[currencyInt];
    } else {
      _currency = Currency.none;
    }

    int? backgroundInt = _preferences.getInt('backgroundType');
    if (backgroundInt != null) {
      _background = Background.values[backgroundInt];
    } else {
      _background = Background.waves;
    }

    String? backgroundString = _preferences.getString('background');
    if (backgroundString != null) {
      dynamic backgroundSettings = json.decode(backgroundString);
      _backgroundGradient = ColorGradient(Color(List.from(backgroundSettings['gradient']).first), Color(List.from(backgroundSettings['gradient']).last));
    } else {
      _backgroundGradient = ColorGradient(ColorPalette.mirrorGrey, ColorPalette.mirrorYellow);
    }

    String? addCardString = _preferences.getString(CardType.addCard.name);
    if (addCardString != null) {
      dynamic addCardSettings = json.decode(addCardString);
      _addCardGradient = ColorGradient(Color(List.from(addCardSettings['gradient']).first), Color(List.from(addCardSettings['gradient']).last));
    } else {
      _addCardGradient = ColorGradient(ColorPalette.silkBeige, ColorPalette.silkWhite);
    }

    String? totalIncomeString = _preferences.getString(CardType.totalIncome.name);
    if (totalIncomeString != null) {
      dynamic totalIncomeSettings = json.decode(totalIncomeString);
      _totalIncomeGradient = ColorGradient(Color(List.from(totalIncomeSettings['gradient']).first), Color(List.from(totalIncomeSettings['gradient']).last));
    } else {
      _totalIncomeGradient = ColorGradient(ColorPalette.oceanBlue, ColorPalette.oceanOpal);
    }

    String? carouselString = _preferences.getString('carousel');
    if (carouselString != null) {
      List<dynamic> carouselIndexes = json.decode(carouselString);
      _carouselCards = List.generate(carouselIndexes.length, (index) => CardType.values[carouselIndexes[index]]);
      _pageInFocus = _carouselCards.length * 50 + _carouselCards.indexOf(CardType.totalIncome);
    }

    String? contentCreationString = _preferences.getString(CardType.contentCreation.name);
    if (contentCreationString != null) {
      _contentCreationData = ContentCreationData.fromJson(json.decode(contentCreationString));
    } else {
      _contentCreationData = ContentCreationData();
    }

    String? customIncomeString = _preferences.getString(CardType.customIncome.name);
    if (customIncomeString != null) {
      _customIncomeData = CustomIncomeData.fromJson(json.decode(customIncomeString));
    } else {
      _customIncomeData = CustomIncomeData();
    }

    String? indexFundsString = _preferences.getString(CardType.indexFunds.name);
    if (indexFundsString != null) {
      _indexFundsData = IndexFundsData.fromJson(json.decode(indexFundsString));
    } else {
      _indexFundsData = IndexFundsData();
    }

    String? privateFundsString = _preferences.getString(CardType.privateFunds.name);
    if (privateFundsString != null) {
      _privateFundsData = PrivateFundsData.fromJson(json.decode(privateFundsString));
    } else {
      _privateFundsData = PrivateFundsData();
    }

    String? realEstateString = _preferences.getString(CardType.realEstate.name);
    if (realEstateString != null) {
      _realEstateData = RealEstateData.fromJson(json.decode(realEstateString));
    } else {
      _realEstateData = RealEstateData();
    }

    String? salariesString = _preferences.getString(CardType.salaries.name);
    if (salariesString != null) {
      _salariesData = SalariesData.fromJson(json.decode(salariesString));
    } else {
      _salariesData = SalariesData();
    }

    String? savingAccountsString = _preferences.getString(CardType.savingAccounts.name);
    if (savingAccountsString != null) {
      _savingAccountsData = SavingAccountsData.fromJson(json.decode(savingAccountsString));
    } else {
      _savingAccountsData = SavingAccountsData();
    }

    String? stockAccountsString = _preferences.getString(CardType.stockAccounts.name);
    if (stockAccountsString != null) {
      _stockAccountsData = StockAccountsData.fromJson(json.decode(stockAccountsString));
    } else {
      _stockAccountsData = StockAccountsData();
    }
  }

  Future<void> _saveLedger() async {
    await _preferences.setString(
      'carousel',
      json.encode(List.generate(
        _carouselCards.length,
        (index) => _carouselCards[index].index,
      )),
    );

    await _preferences.setString(
      'background',
      json.encode({
        'gradient': [_backgroundGradient.bottom.value, _backgroundGradient.topRight.value]
      }),
    );

    _preferences.setString(
      CardType.addCard.name,
      json.encode({
        'gradient': [_addCardGradient.bottom.value, _addCardGradient.topRight.value]
      }),
    );

    _preferences.setString(
      CardType.totalIncome.name,
      json.encode({
        'gradient': [_totalIncomeGradient.bottom.value, _totalIncomeGradient.topRight.value]
      }),
    );

    await _preferences.setString(CardType.contentCreation.name, json.encode(_contentCreationData.toJson()));
    await _preferences.setString(CardType.customIncome.name, json.encode(_customIncomeData.toJson()));
    await _preferences.setString(CardType.indexFunds.name, json.encode(_indexFundsData.toJson()));
    await _preferences.setString(CardType.privateFunds.name, json.encode(_privateFundsData.toJson()));
    await _preferences.setString(CardType.realEstate.name, json.encode(_realEstateData.toJson()));
    await _preferences.setString(CardType.salaries.name, json.encode(_salariesData.toJson()));
    await _preferences.setString(CardType.savingAccounts.name, json.encode(_savingAccountsData.toJson()));
    await _preferences.setString(CardType.stockAccounts.name, json.encode(_stockAccountsData.toJson()));
  }
}
