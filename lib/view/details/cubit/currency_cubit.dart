import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/repository/currency_detail_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyCubit extends Cubit<List<Currency>> {
  CurrencyCubit() : super([]);

  final _repository = CurrencyDetailRepository();

  void setCurrencies() async {
    emit(await _repository.getLastCurrenciesValue());
  }
}
