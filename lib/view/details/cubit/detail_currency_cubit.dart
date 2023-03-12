import 'package:currency_rate_app/model/detail_currency/detail_currency_combined.dart';
import 'package:currency_rate_app/repository/currency_detail_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCurrencyCubit extends Cubit<List<DetailCurrencyCombined>> {
  DetailCurrencyCubit() : super([]);

  final _repository = CurrencyDetailRepository();

  void getDetailCurrency(String code) async {
    emit((await _repository.getDetailCurrency(code)).reversed.toList());
  }
}
