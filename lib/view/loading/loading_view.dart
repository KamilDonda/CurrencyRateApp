import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/services/fetch_service.dart';
import 'package:currency_rate_app/view/home/home_view.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FetchService.fetchCurrencies();
    FetchService.fetchLast30Values().then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeView(),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            CustomTexts.chooseCurrency,
            style: CustomTypography.appbarStyle,
          ),
        ),
        body: const SafeArea(
          child: Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
