import 'package:flutter/cupertino.dart';
import 'package:tokihakanenari/card_types/total_income.dart';
import 'package:tokihakanenari/ledger_data/data.dart';
import 'package:tokihakanenari/my_enums.dart';

import 'dart:developer' as developer;

class Ledger extends ChangeNotifier {
  // Private constructor to prevent external instantiation.
  Ledger._();

  // The single instance of the class.
  static final Ledger _ledger = Ledger._();

  // Factory constructor to provide access to the singleton instance.
  factory Ledger() {
    return _ledger;
  }

  // Update
  void update() {
    notifyListeners();
  }

  // Carousel
  final List<CardType> _carouselCards = <CardType>[
    CardType.totalIncome,
    CardType.addCard,
  ];
  List<CardType> get carouselCards => _carouselCards;

  final defaultPage = 50 * 2; // Only 2 cards originally.
  int _pageInFocus = 0;
  int get pageInFocus => _pageInFocus;

  void addCarouselCard(CardType cardType) {
    bool oddNumberOfCard = _carouselCards.length.isOdd;
    int newCardEvenIndex = (_carouselCards.length / 2).floor();
    if (!_carouselCards.contains(cardType)) {
      _carouselCards.insert(oddNumberOfCard ? newCardEvenIndex - 1 : newCardEvenIndex, cardType);
      _pageInFocus = 50 * _carouselCards.length + (oddNumberOfCard ? newCardEvenIndex - 1 : newCardEvenIndex);
    }
    notifyListeners();
  }

  // Cards
  final ContentCreationData _contentCreationData = ContentCreationData();
  final IndexFundsData _indexFundsData = IndexFundsData();
  final PrivateFundsData _privateFundsData = PrivateFundsData();
  final RealEstateData _realEstateData = RealEstateData();
  final SalariesData _salariesData = SalariesData();
  final SavingAccountsData _savingAccountsData = SavingAccountsData();
  final StockAccountsData _stockAccountsData = StockAccountsData();

  ContentCreationData get contentCreationData => _contentCreationData;
  IndexFundsData get indexFundsData => _indexFundsData;
  PrivateFundsData get privateFundsData => _privateFundsData;
  RealEstateData get realEstateData => _realEstateData;
  SalariesData get salariesData => _salariesData;
  SavingAccountsData get savingAccountsData => _savingAccountsData;
  StockAccountsData get stockAccountsData => _stockAccountsData;
  TotalIncomeData get totalIncomeData {
    return _getTotalIncomeData(_carouselCards);
  }

  void addCardData(CardType cardType, List<dynamic> data) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to add data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.platforms.add(data[0]);
        _contentCreationData.revenues.add(double.parse(data[1]));
        _contentCreationData.timePeriods.add(data[2]);
      case CardType.indexFunds:
        _indexFundsData.icons.add(data[0]);
        _indexFundsData.names.add(data[1]);
        _indexFundsData.amounts.add(double.parse(data[2]));
        _indexFundsData.interests.add(double.parse(data[3]));
      case CardType.totalIncome:
      // TODO: Handle this case.
      case CardType.privateFunds:
        _privateFundsData.icons.add(data[0]);
        _privateFundsData.names.add(data[1]);
        _privateFundsData.amounts.add(double.parse(data[2]));
        _privateFundsData.interests.add(double.parse(data[3]));
      case CardType.realEstate:
        _realEstateData.locations.add(data[0]);
        _realEstateData.descriptions.add(data[1]);
        _realEstateData.capitals.add(double.parse(data[2]));
        _realEstateData.payments.add(double.parse(data[3]));
        _realEstateData.revenues.add(double.parse(data[4]));
        _realEstateData.interests.add(double.parse(data[5]));
        _realEstateData.fullReturns.add(0);
        _realEstateData.registeredDates.add(data[6]);
      case CardType.salaries:
        _salariesData.icons.add(data[0]);
        _salariesData.names.add(data[1]);
        _salariesData.salaries.add(double.parse(data[2]));
        _salariesData.timePeriods.add(data[3]);
      case CardType.savingAccounts:
        _savingAccountsData.icons.add(data[0]);
        _savingAccountsData.names.add(data[1]);
        _savingAccountsData.amounts.add(double.parse(data[2]));
        _savingAccountsData.interests.add(double.parse(data[3]));
      case CardType.stockAccounts:
        _stockAccountsData.icons.add(data[0]);
        _stockAccountsData.names.add(data[1]);
        _stockAccountsData.amounts.add(double.parse(data[2]));
        _stockAccountsData.interests.add(double.parse(data[3]));
    }

    _aggregateData(cardType);
    notifyListeners();
  }

  void _aggregateData(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to add data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.earnedPerDay = 0;
        for (int i = 0; i < _contentCreationData.platforms.length; i++) {
          switch (_contentCreationData.timePeriods[i]) {
            case TimePeriod.day:
              _contentCreationData.earnedPerDay += _contentCreationData.revenues[i];
            case TimePeriod.week:
              _contentCreationData.earnedPerDay += _contentCreationData.revenues[i] / 7;
            case TimePeriod.month:
              _contentCreationData.earnedPerDay += _contentCreationData.revenues[i] / 30.437;
            case TimePeriod.year:
              _contentCreationData.earnedPerDay += _contentCreationData.revenues[i] / 365.25;
          }
        }
        break;
      case CardType.indexFunds:
        _indexFundsData.totalInvested = 0;
        double yearlyIncrease = 0;
        for (int i = 0; i < _indexFundsData.names.length; i++) {
          _indexFundsData.totalInvested += _indexFundsData.amounts[i];
          yearlyIncrease += _indexFundsData.amounts[i] * _indexFundsData.interests[i] / 100;
        }
        _indexFundsData.averageInterest = 100 * yearlyIncrease / _indexFundsData.totalInvested;
        _indexFundsData.earnedPerDay = _indexFundsData.totalInvested * _indexFundsData.averageInterest / 100 / 365.25;
        break;
      case CardType.totalIncome:
        break; // TODO: Handle this case.
      case CardType.privateFunds:
        _privateFundsData.totalInvested = 0;
        double yearlyIncrease = 0;
        for (int i = 0; i < _privateFundsData.names.length; i++) {
          _privateFundsData.totalInvested += _privateFundsData.amounts[i];
          yearlyIncrease += _privateFundsData.amounts[i] * _privateFundsData.interests[i] / 100;
        }
        _privateFundsData.averageInterest = 100 * yearlyIncrease / _privateFundsData.totalInvested;
        _privateFundsData.earnedPerDay = _privateFundsData.totalInvested * _privateFundsData.averageInterest / 100 / 365.25;
        break;
      case CardType.realEstate:
        _realEstateData.totalInvested = 0;
        List<double> sumOfPayments = List.from(_realEstateData.capitals);
        double sumFullReturns = 0;
        for (int i = 0; i < _realEstateData.locations.length; i++) {
          int monthElapsed = (DateTime.now().difference(_realEstateData.registeredDates[i]).inDays / 30.437).floor();
          sumOfPayments[i] += _realEstateData.payments[i] * monthElapsed;
          _realEstateData.totalInvested += sumOfPayments[i];

          double capitalIncrease = sumOfPayments[i] * (1 + _realEstateData.interests[i] / 100) + _realEstateData.revenues[i];
          _realEstateData.fullReturns[i] = 100 * (capitalIncrease - sumOfPayments[i]) / sumOfPayments[i];
          sumFullReturns += _realEstateData.fullReturns[i];
        }
        _realEstateData.averageFullReturn = sumFullReturns / _realEstateData.locations.length;
        _realEstateData.earnedPerDay = _realEstateData.totalInvested * _realEstateData.averageFullReturn / 100 / 365.25;
        break;
      case CardType.salaries:
        _salariesData.earnedPerDay = 0;
        for (int i = 0; i < _salariesData.names.length; i++) {
          switch (_salariesData.timePeriods[i]) {
            case TimePeriod.day:
              _salariesData.earnedPerDay += _salariesData.salaries[i];
            case TimePeriod.week:
              _salariesData.earnedPerDay += _salariesData.salaries[i] / 7;
            case TimePeriod.month:
              _salariesData.earnedPerDay += _salariesData.salaries[i] / 30.437;
            case TimePeriod.year:
              _salariesData.earnedPerDay += _salariesData.salaries[i] / 365.25;
          }
        }
        break;
      case CardType.savingAccounts:
        _savingAccountsData.totalInvested = 0;
        double yearlyIncrease = 0;
        for (int i = 0; i < _savingAccountsData.names.length; i++) {
          _savingAccountsData.totalInvested += _savingAccountsData.amounts[i];
          yearlyIncrease += _savingAccountsData.amounts[i] * _savingAccountsData.interests[i] / 100;
        }
        _savingAccountsData.averageInterest = 100 * yearlyIncrease / _savingAccountsData.totalInvested;
        _savingAccountsData.earnedPerDay = _savingAccountsData.totalInvested * _savingAccountsData.averageInterest / 100 / 365.25;
        break;
      case CardType.stockAccounts:
        _stockAccountsData.totalInvested = 0;
        double yearlyIncrease = 0;
        for (int i = 0; i < _stockAccountsData.names.length; i++) {
          _stockAccountsData.totalInvested += _stockAccountsData.amounts[i];
          yearlyIncrease += _stockAccountsData.amounts[i] * _stockAccountsData.interests[i] / 100;
        }
        _stockAccountsData.averageInterest = 100 * yearlyIncrease / _stockAccountsData.totalInvested;
        _stockAccountsData.earnedPerDay = _stockAccountsData.totalInvested * _stockAccountsData.averageInterest / 100 / 365.25;
        break;
    }
  }

  TotalIncomeData _getTotalIncomeData(List<CardType> cards) {
    TotalIncomeData totalIncomeData = TotalIncomeData();
    for (CardType cardType in cards) {
      switch (cardType) {
        case CardType.addCard:
          break;
        case CardType.contentCreation:
          totalIncomeData.earnedPerDay += _contentCreationData.earnedPerDay;
          break;
        case CardType.indexFunds:
          totalIncomeData.totalInvested += _indexFundsData.totalInvested;
          totalIncomeData.earnedPerDay += _indexFundsData.earnedPerDay;
          totalIncomeData.averageInterest += (_indexFundsData.totalInvested * _indexFundsData.averageInterest / 100);
          break;
        case CardType.privateFunds:
          totalIncomeData.totalInvested += _privateFundsData.totalInvested;
          totalIncomeData.earnedPerDay += _privateFundsData.earnedPerDay;
          totalIncomeData.averageInterest += (_privateFundsData.totalInvested * _privateFundsData.averageInterest / 100);
          break;
        case CardType.realEstate:
          totalIncomeData.totalInvested += _realEstateData.totalInvested;
          totalIncomeData.earnedPerDay += _realEstateData.earnedPerDay;
          totalIncomeData.averageInterest += (_realEstateData.totalInvested * _realEstateData.averageFullReturn / 100);

          break;
        case CardType.salaries:
          totalIncomeData.earnedPerDay += _salariesData.earnedPerDay;
          break;
        case CardType.savingAccounts:
          totalIncomeData.totalInvested += _savingAccountsData.totalInvested;
          totalIncomeData.earnedPerDay += _savingAccountsData.earnedPerDay;
          totalIncomeData.averageInterest += (_savingAccountsData.totalInvested * _savingAccountsData.averageInterest / 100);
          break;
        case CardType.stockAccounts:
          totalIncomeData.totalInvested += _stockAccountsData.totalInvested;
          totalIncomeData.earnedPerDay += _stockAccountsData.earnedPerDay;
          totalIncomeData.averageInterest += (_stockAccountsData.totalInvested * _stockAccountsData.averageInterest / 100);
          break;
        case CardType.totalIncome:
          break;
      }
    }
    totalIncomeData.averageInterest /= totalIncomeData.totalInvested;
    return totalIncomeData;
  }
}
