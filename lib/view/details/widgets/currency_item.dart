import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/currency.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';

class CurrencyItem extends StatelessWidget {
  final Currency currency;

  const CurrencyItem({Key? key, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Flag.fromCode(
                  currency.countryCode,
                  width: 55,
                  height: 55,
                  fit: BoxFit.fitWidth,
                  flagSize: FlagSize.size_4x3,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currency.code,
                      style: CustomTypography.codeStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      currency.name,
                      style: CustomTypography.currencyNameStyle,
                    ),
                  ],
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                text: "${currency.value.toInt()},",
                style: CustomTypography.currencyValueStyle,
                children: [
                  TextSpan(
                    text: currency.value.toStringAsFixed(2).split('.')[1],
                    style: CustomTypography.currencyValueStyle2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
