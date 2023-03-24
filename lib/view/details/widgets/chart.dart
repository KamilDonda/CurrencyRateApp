import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:currency_rate_app/constants/custom_colors.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/utils/date_converter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<CurrencyDetailCombined> currencies;
  final double min;
  final double max;

  const Chart({
    super.key,
    required this.currencies,
    required this.min,
    required this.max,
  });

  static const List<Color> _gradientColors = [
    CustomColors.blue1,
    CustomColors.blue2,
    CustomColors.blue3,
    CustomColors.blue4,
  ];

  final _xAxisReservedSize = 30.0;
  final _textHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
    final systemNavigationBarHeight =
        MediaQueryData.fromWindow(window).padding.bottom;

    double containerHeight;

    Orientation currentOrientation = MediaQuery.of(context).orientation;
    if (currentOrientation == Orientation.portrait) {
      containerHeight = deviceHeight -
          statusBarHeight -
          appBarHeight -
          appBarHeight -
          systemNavigationBarHeight -
          100;
    } else {
      containerHeight = deviceHeight - appBarHeight - 10;
    }

    double dy = max - min;
    double yInterval = dy / 3;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                height: containerHeight,
                child: LineChart(_lineChartData(currencies, yInterval)),
              ),
            ),
            _yLabel(
                text: (max + yInterval / 3).toStringAsFixed(2),
                top: 0,
                textHeight: _textHeight),
            _yLabel(
                text: (max - dy / 4).toStringAsFixed(2),
                top: (containerHeight - _xAxisReservedSize) / 4 -
                    _textHeight / 2,
                textHeight: _textHeight),
            _yLabel(
                text: (max - dy / 2).toStringAsFixed(2),
                top: (containerHeight - _xAxisReservedSize - _textHeight) / 2,
                textHeight: _textHeight),
            _yLabel(
                text: (max - dy * 3 / 4).toStringAsFixed(2),
                top: (containerHeight - _xAxisReservedSize) * 3 / 4 -
                    _textHeight / 2,
                textHeight: _textHeight),
            _yLabel(
                text: (min - yInterval / 3).toStringAsFixed(2),
                bottom: _xAxisReservedSize / 2 + _textHeight / 2,
                textHeight: _textHeight),
          ],
        ),
      ),
    );
  }

  Color _textColor(bool isMin, bool isMax) {
    if (isMin) return CustomColors.minColor;
    if (isMax) return CustomColors.maxColor;
    return Colors.black;
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    if (value == 0 || value == currencies.length - 1) return Container();
    var isMin = currencies
        .where((e) => e.mid == min)
        .toList()
        .contains(currencies[value.toInt()]);
    var isMax = currencies
        .where((e) => e.mid == max)
        .toList()
        .contains(currencies[value.toInt()]);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(DateConverter.dd_MM(currencies[value.toInt()].date),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: _textColor(isMin, isMax),
          )),
    );
  }

  LineChartData _lineChartData(
      List<CurrencyDetailCombined> currencies, double yInterval) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black.withOpacity(0.05),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.black.withOpacity(0.05),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: _xAxisReservedSize,
            interval: 1,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: currencies.length.toDouble() - 1,
      minY: min - yInterval / 3,
      maxY: max + yInterval / 3,
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.grey.withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              if (barSpot.x.toInt() == 0 ||
                  barSpot.x.toInt() == currencies.length - 1) return null;
              return LineTooltipItem(
                currencies[barSpot.x.toInt()].mid.toString(),
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: currencies
              .mapIndexed((index, e) => FlSpot(index.toDouble(), e.mid))
              .toList(),
          isCurved: true,
          gradient: const LinearGradient(
            colors: _gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: _gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Positioned _yLabel({
    required String text,
    double? top,
    double? bottom,
    required double textHeight,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black12,
        ),
        alignment: Alignment.center,
        height: textHeight,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
