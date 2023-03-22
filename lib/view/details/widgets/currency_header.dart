import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
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
          padding: const EdgeInsets.only(right: 12, top: 12),
          child: Text(
            CustomTexts.update(currency.date),
            style: CustomTypography.updateStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flag.fromString(
                  currency.countryCode,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fitWidth,
                  flagSize: FlagSize.size_4x3,
                ),
                Text(
                  currency.code,
                  textAlign: TextAlign.center,
                  style: CustomTypography.codeStyle,
                ),
                Text(
                  currency.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTypography.currencyNameHeaderStyle,
                ),
                Text(
                  currency.value.toStringAsFixed(2),
                  textAlign: TextAlign.center,
                  style: CustomTypography.currencyValueHeaderStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
