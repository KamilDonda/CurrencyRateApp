import 'package:currency_rate_app/model/currencies.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyCubit extends Cubit<List<Currency>?> {
  CurrencyCubit() : super([]);

  void setCurrencies() async {
    emit([...CURRENCIES]);
  }
}
