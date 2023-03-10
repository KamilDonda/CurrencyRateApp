import 'package:collection/collection.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/detail_currency/detail_currency_combined.dart';
import 'package:flutter/material.dart';

class DetailCurrencyItem extends StatelessWidget {
  final DetailCurrencyCombined currency;

  DetailCurrencyItem({
    Key? key,
    required this.currency,
  }) : super(key: key);

  late var items = [
    currency.date,
    currency.bid.toStringAsFixed(2),
    currency.ask.toStringAsFixed(2),
    currency.mid.toStringAsFixed(2),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items
              .mapIndexed((index, item) => Expanded(
                    flex: index == 0 ? 4 : 3,
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                      style: index == 0
                          ? CustomTypography.dateStyle
                          : CustomTypography.currencyStyle,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
