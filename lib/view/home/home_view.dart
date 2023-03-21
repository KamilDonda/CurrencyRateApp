import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/view/details/cubit/currency_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/details_view.dart';
import 'package:currency_rate_app/view/details/widgets/currency_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: SafeArea(
          child: BlocBuilder<CurrencyCubit, List<Currency>?>(
            builder: (_, currencies) {
              if (currencies == null || currencies.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: currencies.length,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    var code = currencies[index].code;
                    context.read<CurrencyDetailCubit>().clear();
                    context.read<CurrencyDetailCubit>().setCurrencyDetail(
                          code.toLowerCase(),
                        );
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
              );
            },
          ),
        ),
      ),
    );
  }
}
