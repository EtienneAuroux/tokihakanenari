import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

// TODO LOOK INTO SEALED CLASS.
// TODO IMPROVE OBJECT NAMES.
class ContentCreationData {
  List<String> platforms = <String>[];
  List<double> revenues = <double>[];
  List<TimePeriod> timePeriods = <TimePeriod>[];
  List<double> perDay = <double>[];
  double totalPerDay = 0;
}

class CustomIncomeData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> interests = <double>[];
  List<double> revenues = <double>[];
  List<double> fullReturns = <double>[]; // in %
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double averageFullReturn = 0;
}

class IndexFundsData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> interests = <double>[];
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double averageInterest = 0;
}

class PrivateFundsData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> interests = <double>[];
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double averageInterest = 0;
}

class RealEstateData {
  List<String> locations = <String>[];
  List<String> descriptions = <String>[];
  List<double> capitals = <double>[];
  List<double> payments = <double>[];
  List<double> revenues = <double>[]; //TODO REVENUES ARE ASSUMED PER YEAR?
  List<double> interests = <double>[];
  List<DateTime> registeredDates = <DateTime>[];
  List<double> fullReturns = <double>[]; // in %
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double averageFullReturn = 0;
}

class SalariesData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> salaries = <double>[];
  List<TimePeriod> timePeriods = <TimePeriod>[];
  List<double> perDay = <double>[];
  double totalPerDay = 0;
}

class SavingAccountsData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> interests = <double>[];
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double averageInterest = 0;
}

class StockAccountsData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> amounts = <double>[];
  List<double> interests = <double>[];
  List<double> perDay = <double>[];
  double totalInvested = 0;
  double totalPerDay = 0;
  double averageInterest = 0;
}

class TotalIncomeData {
  double totalInvested = 0;
  double totalIncomePerDay = 0;
  double averageInterest = 0;
}
