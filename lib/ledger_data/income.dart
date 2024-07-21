import 'package:tokihakanenari/my_enums.dart';

class Income {
  final CardType cardType;
  final List<dynamic> ids;
  final List<dynamic> primary;
  final List<dynamic> secondary;

  Income(this.cardType, this.ids, this.primary, this.secondary);
}
