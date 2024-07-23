import 'package:flutter/material.dart';
import 'package:tokihakanenari/my_enums.dart';

class Income {
  final IconData? icon;
  final String id;
  final String? description;
  final double? amount;
  final double? interest;
  final double? revenue;
  final double? fullReturn;
  final double perDayIncome;
  final TimePeriod? timePeriod;
  final double? payment;
  final CardType? subIncomeCardType;

  Income(
    this.id,
    this.perDayIncome, {
    this.icon,
    this.description,
    this.amount,
    this.interest,
    this.revenue,
    this.fullReturn,
    this.timePeriod,
    this.payment,
    this.subIncomeCardType,
  });
}
