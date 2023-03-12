import 'package:currency_rate_app/model/detail_currency/detail_currency_combined.dart';
import 'package:currency_rate_app/view/details/cubit/detail_currency_cubit.dart';
import 'package:currency_rate_app/view/details/widgets/detail_currency_header.dart';
import 'package:currency_rate_app/view/details/widgets/detail_currency_item.dart';
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
          child: BlocBuilder<DetailCurrencyCubit, List<DetailCurrencyCombined>>(
            builder: (_, currencies) {
              return ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: currencies.length,
                itemBuilder: (_, index) => DetailCurrencyItem(
                  currency: DetailCurrencyCombined(
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
