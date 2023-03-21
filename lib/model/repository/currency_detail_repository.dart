import 'package:currency_rate_app/model/database/database.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';

class CurrencyDetailRepository {
  static final _database = DatabaseProvider().database;

  Future<List<CurrencyDetailCombined>?> getLast30Values(String code) async {
    final currencyDetailDao = (await _database).currencyDetailDao;

    return currencyDetailDao.getLast30ValuesByCode(code);
  }
}
