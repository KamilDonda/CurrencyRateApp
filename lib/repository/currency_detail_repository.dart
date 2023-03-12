import 'package:currency_rate_app/model/detail_currency/detail_currency_combined.dart';
import 'package:currency_rate_app/services/rest_api_service.dart';

class CurrencyDetailRepository {
  final _restApiService = RestApiService();

  Future<List<DetailCurrencyCombined>> getDetailCurrency(String code) async {
    var detail = await _restApiService.getLast30Values(code);
    var detailMid = await _restApiService.getLast30MidValues(code);

    if (detailMid.rates == null || detail.rates == null) return [];

    List<DetailCurrencyCombined> detailsList = [];

    for (var data in detailMid.rates!) {
      if (detail.rates!.any((e) => e.effectiveDate == data.effectiveDate)) {
        detailsList.add(DetailCurrencyCombined(
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
  }
}
