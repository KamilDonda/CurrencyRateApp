import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/repository/currency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyCubit extends Cubit<List<Currency>?> {
  CurrencyCubit() : super([]);

  final _repository = CurrencyRepository();

  void setCurrencies() async {
    emit(await _repository.getLastCurrenciesValue());
  }
}
