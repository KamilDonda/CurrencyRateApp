import 'package:floor/floor.dart';

@entity
class CurrencyDetailCombined {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String code;
  final String date;
  final double bid;
  final double ask;
  final double mid;

  CurrencyDetailCombined({
    required this.id,
    required this.code,
    required this.date,
    required this.bid,
    required this.ask,
    required this.mid,
  });
}
