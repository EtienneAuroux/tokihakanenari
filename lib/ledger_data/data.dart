import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

import 'dart:developer' as developer;

// TODO LOOK INTO SEALED CLASS.
// TODO IMPROVE OBJECT NAMES.
class ContentCreationData {
  List<String> platforms = <String>[];
  List<double> revenues = <double>[];
  List<TimePeriod> timePeriods = <TimePeriod>[];
  List<double> perDay = <double>[];
  double totalIncome = 0;
  double totalPerDay = 0;

  ContentCreationData();

  ContentCreationData.fromJson(Map<String, dynamic> json) {
    platforms = List.from(json['platforms']);
    revenues = List.from(json['revenues']);
    timePeriods = List.generate(platforms.length, (index) => TimePeriod.values[json['timePeriod'][index]]);
    perDay = List.from(json['perDay']);
    totalIncome = json['totalIncome'];
    totalPerDay = json['totalPerDay'];
  }

  Map<String, dynamic> toJson() => {
        'platforms': platforms,
        'revenues': revenues,
        'timePeriod': List.generate(timePeriods.length, (index) => timePeriods[index].index),
        'perDay': perDay,
        'totalIncome': totalIncome,
        'totalPerDay': totalPerDay,
      };
}

class CustomIncomeData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> interests = <double>[];
  List<double> revenues = <double>[];
  List<double> ratesOfReturn = <double>[]; // in %
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double totalRateOfReturn = 0;
}

class IndexFundsData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> ratesOfReturn = <double>[];
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double totalRateOfReturn = 0;
}

class PrivateFundsData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> ratesOfReturn = <double>[];
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double totalRateOfReturn = 0;
}

class RealEstateData {
  List<String> locations = <String>[];
  List<String> descriptions = <String>[];
  List<double> capitals = <double>[];
  List<double> payments = <double>[];
  List<double> revenues = <double>[]; //TODO REVENUES ARE ASSUMED PER YEAR?
  List<double> appreciations = <double>[];
  List<DateTime> registeredDates = <DateTime>[];
  List<double> ratesOfReturn = <double>[]; // in %
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double totalRateOfReturn = 0;
}

class SalariesData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> salaries = <double>[];
  List<TimePeriod> timePeriods = <TimePeriod>[];
  List<double> perDay = <double>[];
  double totalIncome = 0;
  double totalPerDay = 0;
}

class SavingAccountsData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> ratesOfReturn = <double>[];
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double totalRateOfReturn = 0;
}

class StockAccountsData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> ratesOfReturn = <double>[];
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double totalRateOfReturn = 0;
}

class TotalIncomeData {
  List<CardType> incomesType = <CardType>[];
  List<double> incomesPerDay = <double>[];
  double totalInvested = 0;
  double totalIncomePerDay = 0;
  double totalRateOfReturn = 0;
}
