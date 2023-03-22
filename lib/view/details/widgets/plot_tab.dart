import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/widgets/chart.dart';
import 'package:currency_rate_app/view/details/widgets/currency_header.dart';
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
    return Chart(currencies: data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrencyHeader(currency: currency),
        const Divider(),
        (currencies == null || currencies!.isEmpty)
            ? const Expanded(child: Center(child: CircularProgressIndicator()))
            : _chart(currencies!),
      ],
    );
  }
}
