import 'package:flutter/cupertino.dart';
import 'package:tokihakanenari/ledger_data/data.dart';
import 'package:tokihakanenari/my_enums.dart';

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

  // Update
  void update() {
    notifyListeners();
  }

  // Cards
  final ContentCreationData _contentCreationData = ContentCreationData();
  final CustomIncomeData _customIncomeData = CustomIncomeData();
  final IndexFundsData _indexFundsData = IndexFundsData();
  final PrivateFundsData _privateFundsData = PrivateFundsData();
  final RealEstateData _realEstateData = RealEstateData();
  final SalariesData _salariesData = SalariesData();
  final SavingAccountsData _savingAccountsData = SavingAccountsData();
  final StockAccountsData _stockAccountsData = StockAccountsData();

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

  void deleteCarouselCard(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        break;
      case CardType.contentCreation:
        _contentCreationData.platforms.clear();
        _contentCreationData.revenues.clear();
        _contentCreationData.timePeriods.clear();
        _contentCreationData.perDay.clear();
        _contentCreationData.totalPerDay = 0;
        break;
      case CardType.customIncome:
        _customIncomeData.icons.clear();
        _customIncomeData.names.clear();
        _customIncomeData.amounts.clear();
        _customIncomeData.interests.clear();
        _customIncomeData.revenues.clear();
        _customIncomeData.fullReturns.clear();
        _customIncomeData.perDay.clear();
        _customIncomeData.totalInvested = 0;
        _customIncomeData.totalPerDay = 0;
        _customIncomeData.averageFullReturn = 0;
        break;
      case CardType.indexFunds:
        _indexFundsData.icons.clear();
        _indexFundsData.names.clear();
        _indexFundsData.amounts.clear();
        _indexFundsData.interests.clear();
        _indexFundsData.perDay.clear();
        _indexFundsData.totalInvested = 0;
        _indexFundsData.totalPerDay = 0;
        _indexFundsData.averageInterest = 0;
        break;
      case CardType.privateFunds:
        _privateFundsData.icons.clear();
        _privateFundsData.names.clear();
        _privateFundsData.amounts.clear();
        _privateFundsData.interests.clear();
        _privateFundsData.perDay.clear();
        _privateFundsData.totalInvested = 0;
        _privateFundsData.totalPerDay = 0;
        _privateFundsData.averageInterest = 0;
        break;
      case CardType.realEstate:
        _realEstateData.locations.clear();
        _realEstateData.descriptions.clear();
        _realEstateData.capitals.clear();
        _realEstateData.payments.clear();
        _realEstateData.revenues.clear();
        _realEstateData.interests.clear();
        _realEstateData.registeredDates.clear();
        _realEstateData.fullReturns.clear();
        _realEstateData.perDay.clear();
        _realEstateData.totalInvested = 0;
        _realEstateData.totalPerDay = 0;
        _realEstateData.averageFullReturn = 0;
        break;
      case CardType.salaries:
        _salariesData.icons.clear();
        _salariesData.names.clear();
        _salariesData.salaries.clear();
        _salariesData.timePeriods.clear();
        _salariesData.perDay.clear();
        _salariesData.totalPerDay = 0;
        break;
      case CardType.savingAccounts:
        _savingAccountsData.icons.clear();
        _savingAccountsData.names.clear();
        _savingAccountsData.amounts.clear();
        _savingAccountsData.interests.clear();
        _savingAccountsData.perDay.clear();
        _savingAccountsData.totalInvested = 0;
        _savingAccountsData.totalPerDay = 0;
        _savingAccountsData.averageInterest = 0;
      case CardType.stockAccounts:
        _stockAccountsData.icons.clear();
        _stockAccountsData.names.clear();
        _stockAccountsData.amounts.clear();
        _stockAccountsData.interests.clear();
        _stockAccountsData.perDay.clear();
        _stockAccountsData.totalInvested = 0;
        _stockAccountsData.totalPerDay = 0;
        _stockAccountsData.averageInterest = 0;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to remove TotalIncome.');
    }

    int deletedCardIndex = _carouselCards.indexOf(cardType);
    _carouselCards.remove(cardType);
    _pageInFocus = 50 * _carouselCards.length + deletedCardIndex;
    notifyListeners();
  }

  void addCardData(CardType cardType, List<dynamic> data) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to add data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.platforms.add(data[0]);
        _contentCreationData.revenues.add(double.parse(data[1]));
        _contentCreationData.timePeriods.add(data[2]);
        _contentCreationData.perDay.add(0);
        break;
      case CardType.customIncome:
        _customIncomeData.icons.add(data[0]);
        _customIncomeData.names.add(data[1]);
        _customIncomeData.amounts.add(double.parse(data[2]));
        _customIncomeData.interests.add(double.parse(data[3]));
        _customIncomeData.revenues.add(double.parse(data[4]));
        _customIncomeData.fullReturns.add(0);
        _customIncomeData.perDay.add(0);
      case CardType.indexFunds:
        _indexFundsData.icons.add(data[0]);
        _indexFundsData.names.add(data[1]);
        _indexFundsData.amounts.add(double.parse(data[2]));
        _indexFundsData.interests.add(double.parse(data[3]));
        _indexFundsData.perDay.add(0);
        break;
      case CardType.privateFunds:
        _privateFundsData.icons.add(data[0]);
        _privateFundsData.names.add(data[1]);
        _privateFundsData.amounts.add(double.parse(data[2]));
        _privateFundsData.interests.add(double.parse(data[3]));
        _privateFundsData.perDay.add(0);
        break;
      case CardType.realEstate:
        _realEstateData.locations.add(data[0]);
        _realEstateData.descriptions.add(data[1]);
        _realEstateData.capitals.add(double.parse(data[2]));
        _realEstateData.payments.add(double.parse(data[3]));
        _realEstateData.revenues.add(double.parse(data[4]));
        _realEstateData.interests.add(double.parse(data[5]));
        _realEstateData.fullReturns.add(0);
        _realEstateData.registeredDates.add(data[6]);
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
        _savingAccountsData.interests.add(double.parse(data[3]));
        _savingAccountsData.perDay.add(0);
        break;
      case CardType.stockAccounts:
        _stockAccountsData.icons.add(data[0]);
        _stockAccountsData.names.add(data[1]);
        _stockAccountsData.amounts.add(double.parse(data[2]));
        _stockAccountsData.interests.add(double.parse(data[3]));
        _stockAccountsData.perDay.add(0);
        break;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to add data to TotalIncome.');
    }

    _aggregateData(cardType);
    notifyListeners();
  }

  void deleteCardData(CardType cardType, int index) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to delete data from AddCard.');
      case CardType.contentCreation:
        _contentCreationData.platforms.removeAt(index);
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
        _customIncomeData.fullReturns.removeAt(index);
        _customIncomeData.perDay.removeAt(index);
        break;
      case CardType.indexFunds:
        _indexFundsData.icons.removeAt(index);
        _indexFundsData.names.removeAt(index);
        _indexFundsData.amounts.removeAt(index);
        _indexFundsData.interests.removeAt(index);
        _indexFundsData.perDay.removeAt(index);
        break;
      case CardType.privateFunds:
        _privateFundsData.icons.removeAt(index);
        _privateFundsData.names.removeAt(index);
        _privateFundsData.amounts.removeAt(index);
        _privateFundsData.interests.removeAt(index);
        _privateFundsData.perDay.removeAt(index);
        break;
      case CardType.realEstate:
        _realEstateData.locations.removeAt(index);
        _realEstateData.descriptions.removeAt(index);
        _realEstateData.capitals.removeAt(index);
        _realEstateData.payments.removeAt(index);
        _realEstateData.revenues.removeAt(index);
        _realEstateData.interests.removeAt(index);
        _realEstateData.fullReturns.removeAt(index);
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
        _savingAccountsData.interests.removeAt(index);
        _savingAccountsData.perDay.removeAt(index);
        break;
      case CardType.stockAccounts:
        _stockAccountsData.icons.removeAt(index);
        _stockAccountsData.names.removeAt(index);
        _stockAccountsData.amounts.removeAt(index);
        _stockAccountsData.interests.removeAt(index);
        _stockAccountsData.perDay.removeAt(index);
        break;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to delete data from TotalIncome.');
    }

    _aggregateData(cardType);
    notifyListeners();
  }

  void _aggregateData(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to add data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.totalPerDay = 0;
        for (int i = 0; i < _contentCreationData.platforms.length; i++) {
          switch (_contentCreationData.timePeriods[i]) {
            case TimePeriod.day:
              _contentCreationData.perDay[i] = _contentCreationData.revenues[i];
            case TimePeriod.week:
              _contentCreationData.perDay[i] = _contentCreationData.revenues[i] / 7;
            case TimePeriod.month:
              _contentCreationData.perDay[i] = _contentCreationData.revenues[i] / 30.437;
            case TimePeriod.year:
              _contentCreationData.perDay[i] = _contentCreationData.revenues[i] / 365.25;
          }
          _contentCreationData.totalPerDay += _contentCreationData.perDay[i];
        }
        break;
      case CardType.customIncome:
        _customIncomeData.totalInvested = 0;
        double sumFullReturns = 0;
        for (int i = 0; i < _customIncomeData.names.length; i++) {
          _customIncomeData.totalInvested += _customIncomeData.amounts[i];
          if (_customIncomeData.amounts[i] == 0) {
            _customIncomeData.fullReturns[i] = 0;
          } else {
            _customIncomeData.fullReturns[i] += _customIncomeData.interests[i] + 100 * _customIncomeData.revenues[i] / _customIncomeData.amounts[i];
          }
          _customIncomeData.perDay[i] = _customIncomeData.fullReturns[i] / 365.25;
          sumFullReturns += _customIncomeData.fullReturns[i];
        }
        _customIncomeData.averageFullReturn = sumFullReturns / _customIncomeData.names.length;
        _customIncomeData.totalPerDay = _customIncomeData.totalInvested * _customIncomeData.averageFullReturn / 100 / 365.25;
        break;
      case CardType.indexFunds:
        _indexFundsData.totalInvested = 0;
        double yearlyIncrease = 0;
        for (int i = 0; i < _indexFundsData.names.length; i++) {
          _indexFundsData.totalInvested += _indexFundsData.amounts[i];
          yearlyIncrease += _indexFundsData.amounts[i] * _indexFundsData.interests[i] / 100;
          _indexFundsData.perDay[i] = yearlyIncrease / 365.25;
        }
        if (_indexFundsData.totalInvested == 0) {
          _indexFundsData.averageInterest = 0;
        } else {
          _indexFundsData.averageInterest = 100 * yearlyIncrease / _indexFundsData.totalInvested;
        }
        _indexFundsData.totalPerDay = _indexFundsData.totalInvested * _indexFundsData.averageInterest / 100 / 365.25;
        break;
      case CardType.totalIncome:
        throw ErrorDescription('It should not be possible to add data to TotalIncome manually.');
      case CardType.privateFunds:
        _privateFundsData.totalInvested = 0;
        double yearlyIncrease = 0;
        for (int i = 0; i < _privateFundsData.names.length; i++) {
          _privateFundsData.totalInvested += _privateFundsData.amounts[i];
          yearlyIncrease += _privateFundsData.amounts[i] * _privateFundsData.interests[i] / 100;
          _privateFundsData.perDay[i] = yearlyIncrease / 365.25;
        }
        if (_privateFundsData.totalInvested == 0) {
          _privateFundsData.averageInterest = 0;
        } else {
          _privateFundsData.averageInterest = 100 * yearlyIncrease / _privateFundsData.totalInvested;
        }
        _privateFundsData.totalPerDay = _privateFundsData.totalInvested * _privateFundsData.averageInterest / 100 / 365.25;
        break;
      case CardType.realEstate:
        _realEstateData.totalInvested = 0;
        List<double> sumOfPayments = List.from(_realEstateData.capitals);
        double sumFullReturns = 0;
        for (int i = 0; i < _realEstateData.locations.length; i++) {
          int monthElapsed = (DateTime.now().difference(_realEstateData.registeredDates[i]).inDays / 30.437).floor();
          sumOfPayments[i] += _realEstateData.payments[i] * monthElapsed;
          _realEstateData.capitals[i] += sumOfPayments[i];
          _realEstateData.totalInvested += _realEstateData.capitals[i];
          if (_realEstateData.capitals[i] == 0) {
            _realEstateData.fullReturns[i] = 0;
          } else {
            _realEstateData.fullReturns[i] += _realEstateData.interests[i] + 100 * _realEstateData.revenues[i] / _realEstateData.capitals[i];
          }
          _realEstateData.perDay[i] = _realEstateData.fullReturns[i] / 365.25;
          sumFullReturns += _realEstateData.fullReturns[i];
        }
        _realEstateData.averageFullReturn = sumFullReturns / _realEstateData.locations.length;
        _realEstateData.totalPerDay = _realEstateData.totalInvested * _realEstateData.averageFullReturn / 100 / 365.25;
        break;
      case CardType.salaries:
        _salariesData.totalPerDay = 0;
        for (int i = 0; i < _salariesData.names.length; i++) {
          switch (_salariesData.timePeriods[i]) {
            case TimePeriod.day:
              _salariesData.perDay[i] = _salariesData.salaries[i];
            case TimePeriod.week:
              _salariesData.perDay[i] = _salariesData.salaries[i] / 7;
            case TimePeriod.month:
              _salariesData.perDay[i] = _salariesData.salaries[i] / 30.437;
            case TimePeriod.year:
              _salariesData.perDay[i] = _salariesData.salaries[i] / 365.25;
          }
          _salariesData.totalPerDay += _salariesData.perDay[i];
        }
        break;
      case CardType.savingAccounts:
        _savingAccountsData.totalInvested = 0;
        double yearlyIncrease = 0;
        for (int i = 0; i < _savingAccountsData.names.length; i++) {
          _savingAccountsData.totalInvested += _savingAccountsData.amounts[i];
          yearlyIncrease += _savingAccountsData.amounts[i] * _savingAccountsData.interests[i] / 100;
          _savingAccountsData.perDay[i] = yearlyIncrease / 365.25;
        }
        if (_savingAccountsData.totalInvested == 0) {
          _savingAccountsData.averageInterest = 0;
        } else {
          _savingAccountsData.averageInterest = 100 * yearlyIncrease / _savingAccountsData.totalInvested;
        }
        _savingAccountsData.totalPerDay = _savingAccountsData.totalInvested * _savingAccountsData.averageInterest / 100 / 365.25;
        break;
      case CardType.stockAccounts:
        _stockAccountsData.totalInvested = 0;
        double yearlyIncrease = 0;
        for (int i = 0; i < _stockAccountsData.names.length; i++) {
          _stockAccountsData.totalInvested += _stockAccountsData.amounts[i];
          yearlyIncrease += _stockAccountsData.amounts[i] * _stockAccountsData.interests[i] / 100;
          _stockAccountsData.perDay[i] = yearlyIncrease / 365.25;
        }
        if (_stockAccountsData.totalInvested == 0) {
          _stockAccountsData.averageInterest = 0;
        } else {
          _stockAccountsData.averageInterest = 100 * yearlyIncrease / _stockAccountsData.totalInvested;
        }
        _stockAccountsData.totalPerDay = _stockAccountsData.totalInvested * _stockAccountsData.averageInterest / 100 / 365.25;
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
          totalIncomeData.totalIncomePerDay += _contentCreationData.totalPerDay;
          break;
        case CardType.customIncome:
          totalIncomeData.totalInvested += _customIncomeData.totalInvested;
          totalIncomeData.totalIncomePerDay += _customIncomeData.totalPerDay;
          totalIncomeData.averageInterest += (_customIncomeData.totalInvested * _customIncomeData.averageFullReturn / 100);
        case CardType.indexFunds:
          totalIncomeData.totalInvested += _indexFundsData.totalInvested;
          totalIncomeData.totalIncomePerDay += _indexFundsData.totalPerDay;
          totalIncomeData.averageInterest += (_indexFundsData.totalInvested * _indexFundsData.averageInterest / 100);
          break;
        case CardType.privateFunds:
          totalIncomeData.totalInvested += _privateFundsData.totalInvested;
          totalIncomeData.totalIncomePerDay += _privateFundsData.totalPerDay;
          totalIncomeData.averageInterest += (_privateFundsData.totalInvested * _privateFundsData.averageInterest / 100);
          break;
        case CardType.realEstate:
          totalIncomeData.totalInvested += _realEstateData.totalInvested;
          totalIncomeData.totalIncomePerDay += _realEstateData.totalPerDay;
          totalIncomeData.averageInterest += (_realEstateData.totalInvested * _realEstateData.averageFullReturn / 100);
          break;
        case CardType.salaries:
          totalIncomeData.totalIncomePerDay += _salariesData.totalPerDay;
          break;
        case CardType.savingAccounts:
          totalIncomeData.totalInvested += _savingAccountsData.totalInvested;
          totalIncomeData.totalIncomePerDay += _savingAccountsData.totalPerDay;
          totalIncomeData.averageInterest += (_savingAccountsData.totalInvested * _savingAccountsData.averageInterest / 100);
          break;
        case CardType.stockAccounts:
          totalIncomeData.totalInvested += _stockAccountsData.totalInvested;
          totalIncomeData.totalIncomePerDay += _stockAccountsData.totalPerDay;
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
