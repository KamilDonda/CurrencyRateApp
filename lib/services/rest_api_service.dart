import 'package:currency_rate_app/model/currency_detail/currency_detail.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_mid.dart';
import 'package:dio/dio.dart';

class RestApiService {
  final Dio _dio = Dio();
  final String _url = 'https://api.nbp.pl/api/exchangerates/rates';

  Future<CurrencyDetailMid> getLast30MidValues(String code) async {
    try {
      Response response = await _dio.get("$_url/a/$code/last/30?format=json");
      return CurrencyDetailMid.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CurrencyDetailMid.withError("Data not found / Connection issue");
    }
  }

  Future<CurrencyDetail> getLast30Values(String code) async {
    try {
      Response response = await _dio.get("$_url/c/$code/last/30?format=json");
      return CurrencyDetail.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CurrencyDetail.withError("Data not found / Connection issue");
    }
  }

  Future<CurrencyDetailMid> getLastValue(String code) async {
    try {
      Response response = await _dio.get("$_url/a/$code/?format=json");
      return CurrencyDetailMid.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CurrencyDetailMid.withError("Data not found / Connection issue");
    }
  }
}
