import 'package:currency_rate_app/model/detail_currency/detail_currency_combined.dart';
import 'package:currency_rate_app/view/details/widgets/detail_currency_header.dart';
import 'package:currency_rate_app/view/details/widgets/detail_currency_item.dart';
import 'package:flutter/material.dart';

class ListTab extends StatelessWidget {
  final List<DetailCurrencyCombined> currencies;

  const ListTab({
    Key? key,
    required this.currencies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DetailCurrencyHeader(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: currencies.length,
            itemBuilder: (_, index) =>
                DetailCurrencyItem(currency: currencies[index]),
          ),
        ),
      ],
    );
  }
}
