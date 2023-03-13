import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/repository/currency_detail_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyDetailCubit extends Cubit<List<CurrencyDetailCombined>> {
  CurrencyDetailCubit() : super([]);

  final _repository = CurrencyDetailRepository();

  void setCurrencyDetail(String code) async {
    emit(await _repository.getLast30Values(code));
  }
}
