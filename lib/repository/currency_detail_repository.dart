import 'package:currency_rate_app/database/database.dart';
import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';

class CurrencyDetailRepository {
  static final _database = DatabaseProvider().database;

  Future<List<CurrencyDetailCombined>?> getLast30Values(String code) async {
    final currencyDetailDao = (await _database).currencyDetailDao;

    return currencyDetailDao.getLast30ValuesByCode(code);
  }

  Future<List<Currency>?> getLastCurrenciesValue() async {
    final currencyDao = (await _database).currencyDao;

    return currencyDao.getCurrencies();
  }
}
