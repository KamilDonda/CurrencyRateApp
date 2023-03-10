import 'package:currency_rate_app/model/detail_currency/detail_currency_combined.dart';
import 'package:currency_rate_app/widgets/detail_currency_header.dart';
import 'package:currency_rate_app/widgets/detail_currency_item.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key}) : super(key: key);

  static final currencies = [
    DetailCurrencyCombined(
        date: "2023.03.10", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.09", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.08", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.07", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.10", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.09", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.08", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.07", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.10", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.09", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.08", bid: 4.3840, ask: 4.4726, mid: 4.4266),
    DetailCurrencyCombined(
        date: "2023.03.07", bid: 4.3840, ask: 4.4726, mid: 4.4266),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DetailCurrencyHeader(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: currencies.length,
                itemBuilder: (_, index) =>
                    DetailCurrencyItem(currency: currencies[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
