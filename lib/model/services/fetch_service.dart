import 'package:currency_rate_app/constants/supported_currencies.dart';
import 'package:currency_rate_app/model/database/database.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/model/services/rest_api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FetchService {
  static final _restApiService = RestApiService();
  static final _database = DatabaseProvider().database;

  static Future<void> fetchCurrencies() async {
    final currencyDao = (await _database).currencyDao;

    for (var code in SupportedCurrencies.currencies) {
      var currency = await _restApiService.getLastValue(code);
      var name = currency!.currency!;
      currencyDao.insertCurrency(
        Currency(
          name: name.replaceFirst(name[0], name[0].toUpperCase()),
          countryCode: code.substring(0, 2),
          code: code,
          value: currency.rates!.first.mid!,
          date: currency.rates!.first.effectiveDate!.toString(),
        ),
      );
    }
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
