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
        _realEstateData.locations.clear();
        _realEstateData.descriptions.clear();
        _realEstateData.capitals.clear();
        _realEstateData.payments.clear();
        _realEstateData.revenues.clear();
        _realEstateData.interests.clear();
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
        _realEstateData.locations.add(data[0]);
        _realEstateData.descriptions.add(data[1]);
        _realEstateData.capitals.add(double.parse(data[2]));
        _realEstateData.payments.add(double.parse(data[3]));
        _realEstateData.revenues.add(double.parse(data[4]));
        _realEstateData.interests.add(double.parse(data[5]));
        _realEstateData.ratesOfReturn.add(0);
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
        _realEstateData.locations.removeAt(index);
        _realEstateData.descriptions.removeAt(index);
        _realEstateData.capitals.removeAt(index);
        _realEstateData.payments.removeAt(index);
        _realEstateData.revenues.removeAt(index);
        _realEstateData.interests.removeAt(index);
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
    }

    _aggregateData(cardType);
    notifyListeners();
  }

  void _aggregateData(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to add data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.totalIncome = 0;
        _contentCreationData.totalPerDay = 0;
        for (int i = 0; i < _contentCreationData.platforms.length; i++) {
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
        double sumFullReturns = 0;
        for (int i = 0; i < _customIncomeData.names.length; i++) {
          _customIncomeData.totalInvested += _customIncomeData.amounts[i];
          double fullReturn;
          if (_customIncomeData.amounts[i] == 0) {
            fullReturn = 0;
            _customIncomeData.ratesOfReturn[i] += 0;
          } else {
            fullReturn = _customIncomeData.interests[i] + 100 * _customIncomeData.revenues[i] / _customIncomeData.amounts[i];
            _customIncomeData.ratesOfReturn[i] += fullReturn;
          }
          _customIncomeData.perDay[i] = fullReturn / 365.25;
          sumFullReturns += _customIncomeData.ratesOfReturn[i];
        }
        _customIncomeData.totalRateOfReturn = sumFullReturns / _customIncomeData.names.length;
        _customIncomeData.totalPerDay = _customIncomeData.totalInvested * _customIncomeData.totalRateOfReturn / 100 / 365.25;
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
            _realEstateData.ratesOfReturn[i] = _realEstateData.interests[i] + 100 * _realEstateData.revenues[i] / _realEstateData.capitals[i];
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
        throw ErrorDescription('It should not be possible to add data to TotalIncome manually.');
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
      }
    }
    totalIncomeData.totalRateOfReturn /= totalIncomeData.totalInvested;
    return totalIncomeData;
  }
}
