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
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flag.fromCode(
            currency.countryCode,
            width: 50,
            height: 50,
            fit: BoxFit.fitWidth,
            flagSize: FlagSize.size_4x3,
          ),
          SizedBox(
            width: 50,
            child: Text(
              currency.code,
              textAlign: TextAlign.center,
              style: CustomTypography.codeStyle,
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              currency.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTypography.currencyNameStyle,
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              currency.value.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: CustomTypography.currencyValueStyle,
            ),
          ),
        ],
      ),
    );
  }
}
