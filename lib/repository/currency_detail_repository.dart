import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/services/rest_api_service.dart';
import 'package:flag/flag_enum.dart';
import 'package:intl/intl.dart';

class CurrencyDetailRepository {
  final _restApiService = RestApiService();

  Future<List<CurrencyDetailCombined>?> getLast30Values(String code) async {
    var detail = await _restApiService.getLast30Values(code);
    var detailMid = await _restApiService.getLast30MidValues(code);

    List<CurrencyDetailCombined> detailsList = [];
    try {
      for (var data in detailMid!.rates!) {
        if (detail!.rates!.any((e) => e.effectiveDate == data.effectiveDate)) {
          detailsList.add(CurrencyDetailCombined(
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
          ));
        }
      }
      return detailsList;
    } catch (e) {
      return null;
    }
  }

  Future<List<Currency>?> getLastCurrenciesValue() async {
    var usd = await _restApiService.getLastValue("usd");
    var eur = await _restApiService.getLastValue("eur");
    var gbp = await _restApiService.getLastValue("gbp");
    var chf = await _restApiService.getLastValue("chf");
    try {
      return [
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
      ];
    } catch (e) {
      return null;
    }
  }
}
