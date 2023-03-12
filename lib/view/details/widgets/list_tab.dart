import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/widgets/currency_detail_header.dart';
import 'package:currency_rate_app/view/details/widgets/currency_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTab extends StatelessWidget {
  const ListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DetailCurrencyHeader(),
        Expanded(
          child: BlocBuilder<CurrencyDetailCubit, List<CurrencyDetailCombined>>(
            builder: (_, currencies) {
              return ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: currencies.length,
                itemBuilder: (_, index) => DetailCurrencyItem(
                  currency: CurrencyDetailCombined(
                    date: currencies[index].date,
                    bid: currencies[index].bid,
                    ask: currencies[index].ask,
                    mid: currencies[index].mid,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
