import 'package:collection/collection.dart';
import 'package:currency_rate_app/constants/custom_colors.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/utils/date_converter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<CurrencyDetailCombined> currencies;

  const Chart({super.key, required this.currencies});

  static const List<Color> _gradientColors = [
    CustomColors.blue1,
    CustomColors.blue2,
    CustomColors.blue3,
    CustomColors.blue4,
  ];

  static const _xAxisReservedSize = 30.0;
  static const _containerHeight = 550.0;
  static const _textHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    double yMin = currencies.map((e) => e.mid).min;
    double yMax = currencies.map((e) => e.mid).max;
    double dy = yMax - yMin;
    double yInterval = dy / 3;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 1000,
                  height: _containerHeight,
                  padding: const EdgeInsets.only(
                      // right: 16,
                      // left: 10,
                      // top: 10,
                      ),
                  child: LineChart(
                      _lineChartData(currencies, yMin, yMax, yInterval)),
                ),
              ),
              _yLabel(
                  text: (yMax + yInterval / 3).toStringAsFixed(2),
                  top: 0,
                  textHeight: _textHeight),
              _yLabel(
                  text: (yMax - dy / 4).toStringAsFixed(2),
                  top: (_containerHeight - _xAxisReservedSize) / 4 -
                      _textHeight / 2,
                  textHeight: _textHeight),
              _yLabel(
                  text: (yMax - dy / 2).toStringAsFixed(2),
                  top:
                      (_containerHeight - _xAxisReservedSize - _textHeight) / 2,
                  textHeight: _textHeight),
              _yLabel(
                  text: (yMax - dy * 3 / 4).toStringAsFixed(2),
                  top: (_containerHeight - _xAxisReservedSize) * 3 / 4 -
                      _textHeight / 2,
                  textHeight: _textHeight),
              _yLabel(
                  text: (yMin - yInterval / 3).toStringAsFixed(2),
                  bottom: _xAxisReservedSize / 2 + _textHeight / 2,
                  textHeight: _textHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    if (value == 0 || value == currencies.length - 1) return Container();

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(DateConverter.dd_MM(currencies[value.toInt()].date),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          )),
    );
  }

  LineChartData _lineChartData(List<CurrencyDetailCombined> currencies,
      double yMin, double yMax, double yInterval) {
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
      minY: yMin - yInterval / 3,
      maxY: yMax + yInterval / 3,
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
          dotData: FlDotData(
            show: false,
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
