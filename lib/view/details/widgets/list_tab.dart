import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/widgets/currency_detail_header.dart';
import 'package:currency_rate_app/view/details/widgets/currency_detail_item.dart';
import 'package:currency_rate_app/view/details/widgets/currency_header.dart';
import 'package:flutter/material.dart';

class ListTab extends StatelessWidget {
  final Currency currency;
  final List<CurrencyDetailCombined>? currencies;

  const ListTab({
    Key? key,
    required this.currency,
    required this.currencies,
  }) : super(key: key);

  Widget _list() {
    var reversedList = currencies!.reversed.toList();

    return ListView.separated(
      padding: const EdgeInsets.all(4),
      itemCount: reversedList.length,
      itemBuilder: (_, index) => DetailCurrencyItem(
        currency: CurrencyDetailCombined(
          date: reversedList[index].date,
          bid: reversedList[index].bid,
          ask: reversedList[index].ask,
          mid: reversedList[index].mid,
        ),
      ),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrencyHeader(currency: currency),
        const SizedBox(height: 8),
        const DetailCurrencyHeader(),
        Expanded(
          child: (currencies == null || currencies!.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : _list(),
        ),
      ],
    );
  }
}
