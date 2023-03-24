import 'package:currency_rate_app/constants/supported_currencies.dart';
import 'package:currency_rate_app/model/database/database.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/model/services/rest_api_service.dart';
import 'package:currency_rate_app/utils/date_converter.dart';
import 'package:currency_rate_app/utils/fetch_status.dart';

class FetchService {
  static final _restApiService = RestApiService();
  static final _database = DatabaseProvider().database;

  static Future<FetchStatus> fetchCurrencies() async {
    final currencyDao = (await _database).currencyDao;

    for (var code in SupportedCurrencies.currencies) {
      try {
        var currency = await _restApiService.getLastValue(code);
        var name = currency!.currency!;
        currencyDao.insertCurrency(
          Currency(
            name: name.replaceFirst(name[0], name[0].toUpperCase()),
            countryCode: code.substring(0, 2),
            code: code,
            value: currency.rates!.first.mid!,
            date: DateConverter.dd_MM_yyyy(
              currency.rates!.first.effectiveDate!.toString(),
            ),
          ),
        );
      } catch (e) {
        return FetchStatusFailure();
      }
    }
    return FetchStatusSuccess();
  }

  static Future<FetchStatus> fetchLast30Values() async {
    final currencyDetailDao = (await _database).currencyDetailDao;

    int id = 1;
    for (var code in SupportedCurrencies.currencies) {
      try {
        var detail = await _restApiService.getLast30Values(code);
        var detailMid = await _restApiService.getLast30MidValues(code);

        List<CurrencyDetailCombined> detailsList = [];

        for (var data in detailMid!.rates!) {
          if (detail!.rates!
              .any((e) => e.effectiveDate == data.effectiveDate)) {
            detailsList.add(
              CurrencyDetailCombined(
                id: id++,
                date: DateConverter.dd_MM_yyyy(data.effectiveDate!),
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
        currencyDetailDao.insertCurrencyDetail(detailsList);
      } catch (e) {
        return FetchStatusFailure();
      }
    }
    return FetchStatusSuccess();
  }
}
