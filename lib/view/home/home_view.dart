import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/view/details/cubit/currency_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/details_view.dart';
import 'package:currency_rate_app/view/details/widgets/currency_item.dart';
import 'package:currency_rate_app/view/widgets/data_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Future<bool> _showExitPopup(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(CustomTexts.exit),
            content: const Text(CustomTexts.exitContent),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(CustomTexts.no),
              ),
              ElevatedButton(
                onPressed: () => FlutterExitApp.exitApp(),
                child: const Text(CustomTexts.yes),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            CustomTexts.chooseCurrency,
            style: CustomTypography.appbarStyle,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: BlocBuilder<CurrencyCubit, List<Currency>?>(
            builder: (_, currencies) {
              if (currencies == null || currencies.isEmpty) {
                return const DataNotFound();
              }
              return NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: currencies.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      var code = currencies[index].code;
                      context.read<CurrencyDetailCubit>().clear();
                      context
                          .read<CurrencyDetailCubit>()
                          .setCurrencyDetail(code);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsView(
                            code: code,
                            currency: currencies[index],
                          ),
                        ),
                      );
                    },
                    child: CurrencyItem(currency: currencies[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
