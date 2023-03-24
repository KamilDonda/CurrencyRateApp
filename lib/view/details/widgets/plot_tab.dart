import 'package:collection/collection.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/widgets/chart.dart';
import 'package:currency_rate_app/view/details/widgets/currency_header.dart';
import 'package:currency_rate_app/view/widgets/data_not_found.dart';
import 'package:flutter/material.dart';

class PlotTab extends StatelessWidget {
  final Currency currency;
  final List<CurrencyDetailCombined>? currencies;

  const PlotTab({
    Key? key,
    required this.currency,
    required this.currencies,
  }) : super(key: key);

  Widget _chart(List<CurrencyDetailCombined> currencies) {
    List<CurrencyDetailCombined> data = [];
    data.addAll(currencies);
    data.insert(0, currencies.first);
    data.add(currencies.last);
    return SingleChildScrollView(
      child: Column(
        children: [
          CurrencyHeader(currency: currency),
          const Divider(),
          Chart(
            currencies: data,
            min: currencies.map((e) => e.mid).min,
            max: currencies.map((e) => e.mid).max,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (currencies == null || currencies!.isEmpty)
        ? const DataNotFound()
        : _chart(currencies!);
  }
}
