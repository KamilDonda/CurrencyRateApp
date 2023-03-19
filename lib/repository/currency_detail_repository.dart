import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/services/rest_api_service.dart';
import 'package:flag/flag_enum.dart';

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
            date: data.effectiveDate!,
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
    try {
      return [
        Currency(
          name: "Dolar\nAmerykański",
          countryCode: FlagsCode.US,
          code: "USD",
          symbol: "\$",
          value: usd!.rates!.first.mid!,
          date: usd.rates!.first.effectiveDate!.toString(),
        ),
        Currency(
          name: "Euro",
          countryCode: FlagsCode.EU,
          code: "EUR",
          symbol: "€",
          value: eur!.rates!.first.mid!,
          date: eur.rates!.first.effectiveDate!.toString(),
        ),
      ];
    } catch (e) {
      return null;
    }
  }
}
