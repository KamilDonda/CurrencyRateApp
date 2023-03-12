import 'package:currency_rate_app/model/detail_currency/detail_currency.dart';
import 'package:currency_rate_app/model/detail_currency/detail_currency_mid.dart';
import 'package:dio/dio.dart';

class RestApiService {
  final Dio _dio = Dio();
  final String _url = 'https://api.nbp.pl/api/exchangerates/rates';

  Future<DetailCurrencyMid> getLast30MidValues(String code) async {
    try {
      Response response = await _dio.get("$_url/a/$code/last/30?format=json");
      return DetailCurrencyMid.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DetailCurrencyMid.withError("Data not found / Connection issue");
    }
  }

  Future<DetailCurrency> getLast30Values(String code) async {
    try {
      Response response = await _dio.get("$_url/c/$code/last/30?format=json");
      return DetailCurrency.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DetailCurrency.withError("Data not found / Connection issue");
    }
  }
}
