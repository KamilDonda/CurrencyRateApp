import 'package:floor/floor.dart';

@entity
class Currency {
  @primaryKey
  final String code;
  final String name;
  final String countryCode;
  final double value;
  final String date;

  Currency({
    required this.name,
    required this.countryCode,
    required this.code,
    required this.value,
    required this.date,
  });
}
