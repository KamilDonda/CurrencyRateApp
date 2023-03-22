import 'package:currency_rate_app/model/database/database.dart';
import 'package:currency_rate_app/model/entities/currency.dart';

class CurrencyRepository {
  static final _database = DatabaseProvider().database;

  Future<List<Currency>?> getLastCurrenciesValue() async {
    final currencyDao = (await _database).currencyDao;

    return currencyDao.getCurrencies();
  }
}
