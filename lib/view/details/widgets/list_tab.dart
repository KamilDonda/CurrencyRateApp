import 'package:collection/collection.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/widgets/currency_detail_header.dart';
import 'package:currency_rate_app/view/details/widgets/currency_detail_item.dart';
import 'package:currency_rate_app/view/details/widgets/currency_header.dart';
import 'package:currency_rate_app/view/widgets/data_not_found.dart';
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

    var minimum = reversedList.map((e) => e.mid).min;
    var maximum = reversedList.map((e) => e.mid).max;

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: reversedList.length,
        itemBuilder: (_, index) => DetailCurrencyItem(
          currency: reversedList[index],
          isEven: index % 2 == 0,
          isMinimum: reversedList[index].mid == minimum,
          isMaximum: reversedList[index].mid == maximum,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrencyHeader(currency: currency),
        const SizedBox(height: 8),
        const DetailCurrencyHeader(),
        (currencies == null || currencies!.isEmpty)
            ? const DataNotFound()
            : _list(),
      ],
    );
  }
}
