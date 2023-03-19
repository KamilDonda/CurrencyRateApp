import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/widgets/currency_detail_header.dart';
import 'package:currency_rate_app/view/details/widgets/currency_detail_item.dart';
import 'package:currency_rate_app/view/details/widgets/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTab extends StatelessWidget {
  final Currency currency;

  const ListTab({Key? key, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Text(
            CustomTexts.update(currency),
            style: CustomTypography.updateStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CurrencyItem(currency: currency),
        ),
        const SizedBox(height: 8),
        const DetailCurrencyHeader(),
        Expanded(
          child:
              BlocBuilder<CurrencyDetailCubit, List<CurrencyDetailCombined>?>(
            builder: (_, currencies) {
              if (currencies == null || currencies.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              currencies = currencies.reversed.toList();
              return ListView.separated(
                padding: const EdgeInsets.all(4),
                itemCount: currencies.length,
                itemBuilder: (_, index) => DetailCurrencyItem(
                  currency: CurrencyDetailCombined(
                    date: currencies![index].date,
                    bid: currencies[index].bid,
                    ask: currencies[index].ask,
                    mid: currencies[index].mid,
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              );
            },
          ),
        ),
      ],
    );
  }
}
