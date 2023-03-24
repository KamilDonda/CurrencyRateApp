import 'package:collection/collection.dart';
import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:flutter/material.dart';

class DetailCurrencyHeader extends StatelessWidget {
  const DetailCurrencyHeader({Key? key}) : super(key: key);

  static List<String> headers = [
    CustomTexts.date,
    CustomTexts.buy,
    CustomTexts.sell,
    CustomTexts.mean,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: headers
            .mapIndexed((index, header) => Expanded(
                  flex: index == 0 ? 4 : 3,
                  child: Text(
                    header,
                    textAlign: TextAlign.center,
                    style: CustomTypography.headerStyle,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
