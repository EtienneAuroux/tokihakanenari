import 'package:flutter/material.dart';
import 'package:tokihakanenari/ledger_data/color_gradient.dart';
import 'package:tokihakanenari/my_enums.dart';
import 'package:tokihakanenari/visual_tools/color_palette.dart';

// import 'dart:developer' as developer;

class ContentCreationData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> revenues = <double>[];
  List<TimePeriod> timePeriods = <TimePeriod>[];
  List<double> perDay = <double>[];
  double totalIncome = 0;
  double totalPerDay = 0;
  ColorGradient gradient = ColorGradient(ColorPalette.sanguineRed, ColorPalette.sanguineOrange);

  ContentCreationData();

  ContentCreationData.fromJson(Map<String, dynamic> json) {
    names = List.from(json['names']);
    icons = List.generate(names.length, (index) => IconData(json['icons'][index], fontFamily: 'FontAwesome5'));
    revenues = List.from(json['revenues']);
    timePeriods = List.generate(names.length, (index) => TimePeriod.values[json['timePeriod'][index]]);
    perDay = List.from(json['perDay']);
    totalIncome = json['totalIncome'];
    totalPerDay = json['totalPerDay'];
    gradient = ColorGradient(Color(List.from(json['gradient']).first), Color(List.from(json['gradient']).last));
  }

  Map<String, dynamic> toJson() => {
        'icons': List.generate(icons.length, (index) => icons[index].codePoint),
        'names': names,
        'revenues': revenues,
        'timePeriod': List.generate(timePeriods.length, (index) => timePeriods[index].index),
        'perDay': perDay,
        'totalIncome': totalIncome,
        'totalPerDay': totalPerDay,
        'gradient': [gradient.bottom.value, gradient.topRight.value],
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
  ColorGradient gradient = ColorGradient(ColorPalette.sunOrange, ColorPalette.sunYellow);

  CustomIncomeData();

  CustomIncomeData.fromJson(Map<String, dynamic> json) {
    names = List.from(json['names']);
    icons = List.generate(names.length, (index) => IconData(json['icons'][index], fontFamily: 'FontAwesome5'));
    amounts = List.from(json['amounts']);
    interests = List.from(json['interests']);
    revenues = List.from(json['revenues']);
    ratesOfReturn = List.from(json['ratesOfReturn']);
    perDay = List.from(json['perDay']);
    totalInvested = json['totalInvested'];
    totalPerDay = json['totalPerDay'];
    totalRateOfReturn = json['totalRateOfReturn'];
    gradient = ColorGradient(Color(List.from(json['gradient']).first), Color(List.from(json['gradient']).last));
  }

  Map<String, dynamic> toJson() => {
        'icons': List.generate(icons.length, (index) => icons[index].codePoint),
        'names': names,
        'amounts': amounts,
        'interests': interests,
        'revenues': revenues,
        'ratesOfReturn': ratesOfReturn,
        'perDay': perDay,
        'totalInvested': totalInvested,
        'totalPerDay': totalPerDay,
        'totalRateOfReturn': totalRateOfReturn,
        'gradient': [gradient.bottom.value, gradient.topRight.value],
      };
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
  ColorGradient gradient = ColorGradient(ColorPalette.pigletPink, ColorPalette.pigletPale);

  IndexFundsData();

  IndexFundsData.fromJson(Map<String, dynamic> json) {
    names = List.from(json['names']);
    icons = List.generate(names.length, (index) => IconData(json['icons'][index], fontFamily: 'FontAwesome5'));
    amounts = List.from(json['amounts']);
    ratesOfReturn = List.from(json['ratesOfReturn']);
    perDay = List.from(json['perDay']);
    totalInvested = json['totalInvested'];
    totalPerDay = json['totalPerDay'];
    totalRateOfReturn = json['totalRateOfReturn'];
    gradient = ColorGradient(Color(List.from(json['gradient']).first), Color(List.from(json['gradient']).last));
  }

  Map<String, dynamic> toJson() => {
        'icons': List.generate(icons.length, (index) => icons[index].codePoint),
        'names': names,
        'amounts': amounts,
        'ratesOfReturn': ratesOfReturn,
        'perDay': perDay,
        'totalInvested': totalInvested,
        'totalPerDay': totalPerDay,
        'totalRateOfReturn': totalRateOfReturn,
        'gradient': [gradient.bottom.value, gradient.topRight.value],
      };
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
  ColorGradient gradient = ColorGradient(ColorPalette.lusciousGreen, ColorPalette.lusciousYellow);

  PrivateFundsData();

  PrivateFundsData.fromJson(Map<String, dynamic> json) {
    names = List.from(json['names']);
    icons = List.generate(names.length, (index) => IconData(json['icons'][index], fontFamily: 'FontAwesome5'));
    amounts = List.from(json['amounts']);
    ratesOfReturn = List.from(json['ratesOfReturn']);
    perDay = List.from(json['perDay']);
    totalInvested = json['totalInvested'];
    totalPerDay = json['totalPerDay'];
    totalRateOfReturn = json['totalRateOfReturn'];
    gradient = ColorGradient(Color(List.from(json['gradient']).first), Color(List.from(json['gradient']).last));
  }

  Map<String, dynamic> toJson() => {
        'icons': List.generate(icons.length, (index) => icons[index].codePoint),
        'names': names,
        'amounts': amounts,
        'ratesOfReturn': ratesOfReturn,
        'perDay': perDay,
        'totalInvested': totalInvested,
        'totalPerDay': totalPerDay,
        'totalRateOfReturn': totalRateOfReturn,
        'gradient': [gradient.bottom.value, gradient.topRight.value],
      };
}

class RealEstateData {
  List<IconData> icons = <IconData>[];
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
  ColorGradient gradient = ColorGradient(ColorPalette.bleachedGreen, ColorPalette.bleachedOrange);

  RealEstateData();

  RealEstateData.fromJson(Map<String, dynamic> json) {
    locations = List.from(json['locations']);
    icons = List.generate(locations.length, (index) => IconData(json['icons'][index], fontFamily: 'FontAwesome5'));
    descriptions = List.from(json['descriptions']);
    capitals = List.from(json['capitals']);
    payments = List.from(json['payments']);
    revenues = List.from(json['revenues']);
    appreciations = List.from(json['appreciations']);
    registeredDates = List.generate(
      locations.length,
      (index) => DateTime.fromMillisecondsSinceEpoch(json['registeredDates'][index]),
    );
    ratesOfReturn = List.from(json['ratesOfReturn']);
    perDay = List.from(json['perDay']);
    totalInvested = json['totalInvested'];
    totalPerDay = json['totalPerDay'];
    totalRateOfReturn = json['totalRateOfReturn'];
    gradient = ColorGradient(Color(List.from(json['gradient']).first), Color(List.from(json['gradient']).last));
  }

  Map<String, dynamic> toJson() => {
        'icons': List.generate(icons.length, (index) => icons[index].codePoint),
        'locations': locations,
        'descriptions': descriptions,
        'capitals': capitals,
        'payments': payments,
        'revenues': revenues,
        'appreciations': appreciations,
        'registeredDates': List.generate(
          locations.length,
          (index) => registeredDates[index].millisecondsSinceEpoch,
        ),
        'ratesOfReturn': ratesOfReturn,
        'perDay': perDay,
        'totalInvested': totalInvested,
        'totalPerDay': totalPerDay,
        'totalRateOfReturn': totalRateOfReturn,
        'gradient': [gradient.bottom.value, gradient.topRight.value],
      };
}

class SalariesData {
  List<IconData> icons = <IconData>[];
  List<String> names = <String>[];
  List<double> salaries = <double>[];
  List<TimePeriod> timePeriods = <TimePeriod>[];
  List<double> perDay = <double>[];
  double totalIncome = 0;
  double totalPerDay = 0;
  ColorGradient gradient = ColorGradient(ColorPalette.orbitPurple, ColorPalette.orbitGreen);

  SalariesData();

  SalariesData.fromJson(Map<String, dynamic> json) {
    names = List.from(json['names']);
    icons = List.generate(names.length, (index) => IconData(json['icons'][index], fontFamily: 'FontAwesome5'));
    salaries = List.from(json['salaries']);
    timePeriods = List.generate(names.length, (index) => TimePeriod.values[json['timePeriod'][index]]);
    perDay = List.from(json['perDay']);
    totalIncome = json['totalIncome'];
    totalPerDay = json['totalPerDay'];
    gradient = ColorGradient(Color(List.from(json['gradient']).first), Color(List.from(json['gradient']).last));
  }

  Map<String, dynamic> toJson() => {
        'icons': List.generate(icons.length, (index) => icons[index].codePoint),
        'names': names,
        'salaries': salaries,
        'timePeriod': List.generate(timePeriods.length, (index) => timePeriods[index].index),
        'perDay': perDay,
        'totalIncome': totalIncome,
        'totalPerDay': totalPerDay,
        'gradient': [gradient.bottom.value, gradient.topRight.value],
      };
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
  ColorGradient gradient = ColorGradient(ColorPalette.exoticPink, ColorPalette.exoticOrange);

  SavingAccountsData();

  SavingAccountsData.fromJson(Map<String, dynamic> json) {
    names = List.from(json['names']);
    icons = List.generate(names.length, (index) => IconData(json['icons'][index], fontFamily: 'FontAwesome5'));
    amounts = List.from(json['amounts']);
    ratesOfReturn = List.from(json['ratesOfReturn']);
    perDay = List.from(json['perDay']);
    totalInvested = json['totalInvested'];
    totalPerDay = json['totalPerDay'];
    totalRateOfReturn = json['totalRateOfReturn'];
    gradient = ColorGradient(Color(List.from(json['gradient']).first), Color(List.from(json['gradient']).last));
  }

  Map<String, dynamic> toJson() => {
        'icons': List.generate(icons.length, (index) => icons[index].codePoint),
        'names': names,
        'amounts': amounts,
        'ratesOfReturn': ratesOfReturn,
        'perDay': perDay,
        'totalInvested': totalInvested,
        'totalPerDay': totalPerDay,
        'totalRateOfReturn': totalRateOfReturn,
        'gradient': [gradient.bottom.value, gradient.topRight.value],
      };
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
  ColorGradient gradient = ColorGradient(ColorPalette.toxicYellow, ColorPalette.toxicBlue);

  StockAccountsData();

  StockAccountsData.fromJson(Map<String, dynamic> json) {
    names = List.from(json['names']);
    icons = List.generate(names.length, (index) => IconData(json['icons'][index], fontFamily: 'FontAwesome5'));
    amounts = List.from(json['amounts']);
    ratesOfReturn = List.from(json['ratesOfReturn']);
    perDay = List.from(json['perDay']);
    totalInvested = json['totalInvested'];
    totalPerDay = json['totalPerDay'];
    totalRateOfReturn = json['totalRateOfReturn'];
    gradient = ColorGradient(Color(List.from(json['gradient']).first), Color(List.from(json['gradient']).last));
  }

  Map<String, dynamic> toJson() => {
        'icons': List.generate(icons.length, (index) => icons[index].codePoint),
        'names': names,
        'amounts': amounts,
        'ratesOfReturn': ratesOfReturn,
        'perDay': perDay,
        'totalInvested': totalInvested,
        'totalPerDay': totalPerDay,
        'totalRateOfReturn': totalRateOfReturn,
        'gradient': [gradient.bottom.value, gradient.topRight.value],
      };
}

class TotalIncomeData {
  List<CardType> incomesType = <CardType>[];
  List<double> incomesPerDay = <double>[];
  double totalInvested = 0;
  double totalIncomePerDay = 0;
  double totalRateOfReturn = 0;
  ColorGradient gradient = ColorGradient(ColorPalette.oceanBlue, ColorPalette.oceanOpal);
}
