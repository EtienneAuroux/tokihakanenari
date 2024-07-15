import 'package:flutter/cupertino.dart';
import 'package:tokihakanenari/ledger_data/data.dart';
import 'package:tokihakanenari/my_enums.dart';

class Ledger extends ChangeNotifier {
  // Private constructor to prevent external instantiation.
  Ledger._();

  // The single instance of the class.
  static final Ledger _ledger = Ledger._();

  // Factory constructor to provide access to the singleton instance.
  factory Ledger() {
    return _ledger;
  }

  // Carousel
  final List<CardType> _carouselCards = <CardType>[
    CardType.addCard,
    CardType.passiveIncome,
    CardType.addCard,
  ];

  List<CardType> get carouselCards => _carouselCards;

  void addCarouselCard(CardType cardType) {
    if (!_carouselCards.contains(cardType)) {
      int index = _carouselCards.length.isOdd ? 2 : 1;
      _carouselCards.insert(index, cardType);
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

  void addCardData(CardType cardType, List<dynamic> data) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to add data to AddCard.');
      case CardType.contentCreation:
        _contentCreationData.platforms.add(data[0]);
        _contentCreationData.revenues.add(data[1]);
        _contentCreationData.timePeriods.add(data[2]);
      case CardType.indexFunds:
        _indexFundsData.icons.add(data[0]);
        _indexFundsData.names.add(data[1]);
        _indexFundsData.amounts.add(data[2]);
        _indexFundsData.interests.add(data[3]);
      case CardType.passiveIncome:
      // TODO: Handle this case.
      case CardType.privateFunds:
        _privateFundsData.icons.add(data[0]);
        _privateFundsData.names.add(data[1]);
        _privateFundsData.amounts.add(data[2]);
        _privateFundsData.interests.add(data[3]);
      case CardType.realEstate:
        _realEstateData.locations.add(data[0]);
        _realEstateData.descriptions.add(data[1]);
        _realEstateData.capitals.add(data[2]);
        _realEstateData.payments.add(data[3]);
        _realEstateData.revenues.add(data[4]);
        _realEstateData.interests.add(data[5]);
      case CardType.salaries:
        _salariesData.icons.add(data[0]);
        _salariesData.names.add(data[1]);
        _salariesData.salaries.add(data[2]);
        _salariesData.timePeriods.add(data[3]);
      case CardType.savingAccounts:
        _savingAccountsData.icons.add(data[0]);
        _savingAccountsData.names.add(data[1]);
        _savingAccountsData.amounts.add(data[2]);
        _savingAccountsData.interests.add(data[3]);
      case CardType.stockAccounts:
        _stockAccountsData.icons.add(data[0]);
        _stockAccountsData.names.add(data[1]);
        _stockAccountsData.amounts.add(data[2]);
        _stockAccountsData.interests.add(data[3]);
    }

    notifyListeners();
  }

  void aggregateData(CardType cardType) {
    switch (cardType) {
      case CardType.addCard:
        throw ErrorDescription('It should not be possible to add data to AddCard.');
      case CardType.contentCreation:
        for (int i = 0; i < _contentCreationData.revenues.length; i++) {
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
      case CardType.indexFunds:
        double yearlyIncrease = 0;
        for (int i = 0; i < _indexFundsData.amounts.length; i++) {
          _indexFundsData.totalInvested += _indexFundsData.amounts[i];
          yearlyIncrease += _indexFundsData.amounts[i] * _indexFundsData.interests[i] / 100;
        }
        _indexFundsData.averageInterest = 100 * yearlyIncrease / _indexFundsData.totalInvested;
        _indexFundsData.earnedPerDay = _indexFundsData.totalInvested * _indexFundsData.averageInterest / 100 / 365.25;
      case CardType.passiveIncome:
      // TODO: Handle this case.
      case CardType.privateFunds:
        double yearlyIncrease = 0;
        for (int i = 0; i < _privateFundsData.amounts.length; i++) {
          _privateFundsData.totalInvested += _privateFundsData.amounts[i];
          yearlyIncrease += _privateFundsData.amounts[i] * _privateFundsData.interests[i] / 100;
        }
        _privateFundsData.averageInterest = 100 * yearlyIncrease / _privateFundsData.totalInvested;
        _privateFundsData.earnedPerDay = _privateFundsData.totalInvested * _privateFundsData.averageInterest / 100 / 365.25;
      case CardType.realEstate:
      // TODO: Handle this case.
      case CardType.salaries:
      // TODO: Handle this case.
      case CardType.savingAccounts:
        double yearlyIncrease = 0;
        for (int i = 0; i < _savingAccountsData.amounts.length; i++) {
          _savingAccountsData.totalInvested += _savingAccountsData.amounts[i];
          yearlyIncrease += _savingAccountsData.amounts[i] * _savingAccountsData.interests[i] / 100;
        }
        _savingAccountsData.averageInterest = 100 * yearlyIncrease / _savingAccountsData.totalInvested;
        _savingAccountsData.earnedPerDay = _savingAccountsData.totalInvested * _savingAccountsData.averageInterest / 100 / 365.25;
      case CardType.stockAccounts:
        double yearlyIncrease = 0;
        for (int i = 0; i < _stockAccountsData.amounts.length; i++) {
          _stockAccountsData.totalInvested += _stockAccountsData.amounts[i];
          yearlyIncrease += _stockAccountsData.amounts[i] * _stockAccountsData.interests[i] / 100;
        }
        _stockAccountsData.averageInterest = 100 * yearlyIncrease / _stockAccountsData.totalInvested;
        _stockAccountsData.earnedPerDay = _stockAccountsData.totalInvested * _stockAccountsData.averageInterest / 100 / 365.25;
    }
  }
}
