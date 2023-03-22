import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:floor/floor.dart';

@dao
abstract class CurrencyDetailDao {
  @Query('SELECT * FROM CurrencyDetailCombined WHERE code = :code')
  Future<List<CurrencyDetailCombined>> getLast30ValuesByCode(String code);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCurrencyDetail(List<CurrencyDetailCombined> values);
}
