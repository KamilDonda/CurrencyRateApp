import 'package:currency_rate_app/constants/supported_currencies.dart';
import 'package:currency_rate_app/database/database.dart';
import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/services/rest_api_service.dart';
import 'package:flag/flag_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FetchService {
  static final _restApiService = RestApiService();
  static final _database = DatabaseProvider().database;

  static Future<void> fetchCurrencies() async {
    final currencyDao = (await _database).currencyDao;

    var usd = await _restApiService.getLastValue(SupportedCurrencies.usd);
    var eur = await _restApiService.getLastValue(SupportedCurrencies.eur);
    var gbp = await _restApiService.getLastValue(SupportedCurrencies.gbp);
    var chf = await _restApiService.getLastValue(SupportedCurrencies.chf);

    currencyDao.insertCurrency([
      Currency(
        name: "Dolar amerykański",
        countryCode: FlagsCode.US,
        code: "USD",
        value: usd!.rates!.first.mid!,
        date: usd.rates!.first.effectiveDate!.toString(),
      ),
      Currency(
        name: "Euro",
        countryCode: FlagsCode.EU,
        code: "EUR",
        value: eur!.rates!.first.mid!,
        date: eur.rates!.first.effectiveDate!.toString(),
      ),
      Currency(
        name: "Funt szterling",
        countryCode: FlagsCode.GB,
        code: "GBP",
        value: gbp!.rates!.first.mid!,
        date: gbp.rates!.first.effectiveDate!.toString(),
      ),
      Currency(
        name: "Frank szwajcarski",
        countryCode: FlagsCode.CH,
        code: "CHF",
        value: chf!.rates!.first.mid!,
        date: chf.rates!.first.effectiveDate!.toString(),
      ),
    ]);
  }

  static Future<void> fetchLast30Values() async {
    final currencyDetailDao = (await _database).currencyDetailDao;

    int id = 1;
    for (var code in SupportedCurrencies.currencies) {
      var detail = await _restApiService.getLast30Values(code);
      var detailMid = await _restApiService.getLast30MidValues(code);

      List<CurrencyDetailCombined> detailsList = [];

      for (var data in detailMid!.rates!) {
        if (detail!.rates!.any((e) => e.effectiveDate == data.effectiveDate)) {
          detailsList.add(
            CurrencyDetailCombined(
              id: id++,
              date: DateFormat("dd.MM.yyyy").format(
                DateFormat("yyyy-MM-dd").parse(data.effectiveDate!),
              ),
              bid: detail.rates!
                  .firstWhere((e) => e.effectiveDate == data.effectiveDate)
                  .bid!,
              ask: detail.rates!
                  .firstWhere((e) => e.effectiveDate == data.effectiveDate)
                  .ask!,
              mid: data.mid!,
              code: code,
            ),
          );
        }
      }
      debugPrint("List size: ${detailsList.length}");
      currencyDetailDao.insertCurrencyDetail(detailsList);
      debugPrint("Inserted $code values");
    }
  }
}
