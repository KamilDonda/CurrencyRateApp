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
    double deviceWidth = MediaQuery.of(context).size.width;
    double chartWidth = 1000;
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
    double yInterval = dy / 4;

    final minOffset = -yInterval;
    final maxOffset = yInterval;
    var margin = (containerHeight - _xAxisReservedSize) / 6;

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
                width: deviceWidth > chartWidth ? deviceWidth : chartWidth,
                height: containerHeight,
                child:
                    LineChart(_lineChartData(currencies, minOffset, maxOffset)),
              ),
            ),
            _yLabel(
              text: (max).toStringAsFixed(2),
              top: margin - _textHeight / 2,
            ),
            _yLabel(
              text: (min + dy / 2).toStringAsFixed(2),
              top: (containerHeight - _xAxisReservedSize - _textHeight) / 2,
            ),
            _yLabel(
              text: (min).toStringAsFixed(2),
              bottom: _xAxisReservedSize + margin - _textHeight / 2,
            ),
            _yLabel(
              text: (min + dy * 3 / 4).toStringAsFixed(2),
              top: margin -
                  _textHeight / 2 +
                  (containerHeight - _xAxisReservedSize - _textHeight) *
                      (3 / 16),
            ),
            _yLabel(
              text: (min + dy * 1 / 4).toStringAsFixed(2),
              top: margin -
                  _textHeight / 2 +
                  (containerHeight - _xAxisReservedSize - _textHeight) *
                      (9 / 16),
            ),
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

  Color _dotColor(int i) {
    if (currencies[i].mid == min) return CustomColors.minColor;
    if (currencies[i].mid == max) return CustomColors.maxColor;
    return Colors.white;
  }

  Color _lineColor(int i) {
    if (currencies[i].mid == min) return CustomColors.minColor.withOpacity(0.8);
    if (currencies[i].mid == max) return CustomColors.maxColor.withOpacity(0.8);
    return CustomColors.blue5.withOpacity(0.3);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    return Text(value.toStringAsFixed(3),
        style: style, textAlign: TextAlign.left);
  }

  LineChartData _lineChartData(List<CurrencyDetailCombined> currencies,
      double minOffset, double maxOffset) {
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
          sideTitles: SideTitles(
            showTitles: false,
            interval: 0.005,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 16,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: currencies.length.toDouble() - 1,
      minY: min + minOffset,
      maxY: max + maxOffset,
      lineTouchData: LineTouchData(
        enabled: true,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map(
            (index) {
              return TouchedSpotIndicatorData(
                FlLine(
                    color: _lineColor(index),
                    strokeWidth:
                        index == 0 || index == currencies.length - 1 ? 0 : 3),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: (spot.x.toInt() == 0 ||
                            spot.x.toInt() == currencies.length - 1)
                        ? 0
                        : 5.5,
                    color: _dotColor(spot.x.toInt()),
                    strokeWidth: 2,
                    strokeColor: Colors.black,
                  ),
                ),
              );
            },
          ).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.grey.withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              if (barSpot.x.toInt() == 0 ||
                  barSpot.x.toInt() == currencies.length - 1) return null;
              return LineTooltipItem(
                currencies[barSpot.x.toInt()].mid.toStringAsFixed(3),
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
          dotData: FlDotData(
            show: true,
            checkToShowDot: (spot, barData) {
              return currencies[spot.x.toInt()].mid == min ||
                  currencies[spot.x.toInt()].mid == max;
            },
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: (spot.x.toInt() == 0 ||
                        spot.x.toInt() == currencies.length - 1)
                    ? 0
                    : 6,
                color: currencies[spot.x.toInt()].mid == min
                    ? CustomColors.minColor
                    : CustomColors.maxColor,
                strokeWidth: 2,
                strokeColor: Colors.black,
              );
            },
          ),
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
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black45,
        ),
        alignment: Alignment.center,
        height: _textHeight,
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white)),
      ),
    );
  }
}
