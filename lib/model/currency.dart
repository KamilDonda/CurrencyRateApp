import 'package:flag/flag_enum.dart';

class Currency {
  final String name;
  final FlagsCode countryCode;
  final String code;
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
