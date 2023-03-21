import 'package:currency_rate_app/model/currency.dart';
import 'package:floor/floor.dart';

@dao
abstract class CurrencyDao {
  @Query('SELECT * FROM Currency')
  Future<List<Currency>> getCurrencies();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCurrency(List<Currency> currencies);
}
