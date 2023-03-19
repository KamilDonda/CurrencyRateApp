import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/view/details/widgets/currency_item.dart';
import 'package:flutter/material.dart';

class CurrencyHeader extends StatelessWidget {
  final Currency currency;

  const CurrencyHeader({Key? key, required this.currency}) : super(key: key);

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
      ],
    );
  }
}
