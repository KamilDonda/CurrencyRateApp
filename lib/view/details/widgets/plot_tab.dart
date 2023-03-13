import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/widgets/chart.dart';
import 'package:currency_rate_app/view/details/widgets/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlotTab extends StatelessWidget {
  final Currency currency;

  const PlotTab({Key? key, required this.currency}) : super(key: key);

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
        const Divider(),
        BlocBuilder<CurrencyDetailCubit, List<CurrencyDetailCombined>>(
          builder: (_, currencies) {
            List<CurrencyDetailCombined> data = [];
            data.addAll(currencies);
            data.insert(0, currencies.first);
            data.add(currencies.last);
            return Chart(currencies: data);
          },
        ),
      ],
    );
  }
}
