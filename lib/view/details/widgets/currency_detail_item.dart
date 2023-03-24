import 'package:collection/collection.dart';
import 'package:currency_rate_app/constants/custom_colors.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:flutter/material.dart';

class DetailCurrencyItem extends StatelessWidget {
  final CurrencyDetailCombined currency;
  final bool isEven;
  final bool isMinimum;
  final bool isMaximum;

  DetailCurrencyItem({
    Key? key,
    required this.currency,
    required this.isEven,
    required this.isMinimum,
    required this.isMaximum,
  }) : super(key: key);

  late var items = [
    currency.date,
    currency.bid.toStringAsFixed(2),
    currency.ask.toStringAsFixed(2),
    currency.mid.toStringAsFixed(2),
  ];

  TextStyle _textStyle(int index, int max) {
    TextStyle style = CustomTypography.currencyStyle;
    if (index == 0) style = CustomTypography.dateStyle;
    if (index == max) style = CustomTypography.currencyMeanStyle;

    if (isMinimum || isMaximum) {
      return style.copyWith(
        color: isMinimum ? CustomColors.minColor : CustomColors.maxColor,
      );
    }
    return style;
  }

  Color _bgColor() {
    if (isMinimum) return CustomColors.minRowColor;
    if (isMaximum) return CustomColors.maxRowColor;
    return isEven ? CustomColors.itemRowColor : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: _bgColor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
            .mapIndexed((index, item) => Expanded(
                  flex: index == 0 ? 4 : 3,
                  child: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: _textStyle(index, items.length - 1),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
