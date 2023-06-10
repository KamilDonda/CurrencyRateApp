import 'package:currency_rate_app/model/currencies.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyDetailCubit extends Cubit<List<CurrencyDetailCombined>> {
  CurrencyDetailCubit() : super([]);

  void clear() => emit([]);

  void setCurrencyDetail(String code) async {
    emit([...CURRENCY_DETAILS.where((element) => element.code == code)]);
  }
}
