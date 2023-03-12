import 'package:currency_rate_app/model/detail_currency/detail_currency_mid.dart';
import 'package:currency_rate_app/services/rest_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCurrencyCubit extends Cubit<DetailCurrencyMid> {
  DetailCurrencyCubit() : super(DetailCurrencyMid());

  final _restApiService = RestApiService();

  void getDetailCurrency(String code) async {
    final data = await _restApiService.getLast30MidValues(code);
    emit(data);
  }
}
