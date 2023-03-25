import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/entities/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/widgets/list_tab.dart';
import 'package:currency_rate_app/view/details/widgets/plot_tab.dart';
import 'package:currency_rate_app/view/widgets/navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPortrait extends StatelessWidget {
  final String code;
  final Currency currency;
  final int index;

  const DetailsPortrait({
    Key? key,
    required this.code,
    required this.currency,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          CustomTexts.details,
          style: CustomTypography.appbarStyle,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 12),
            alignment: Alignment.center,
            child: Text(
              code,
              style: CustomTypography.appbarStyle,
            ),
          ),
        ],
      ),
      body: SafeArea(child: _tab(index, currency)),
      bottomNavigationBar: NavigationBarWidget(index: index),
    );
  }

  Widget _tab(int index, Currency currency) {
    return BlocBuilder<CurrencyDetailCubit, List<CurrencyDetailCombined>?>(
      builder: (_, currencies) {
        return Stack(
          children: [
            Offstage(
              offstage: index != 0,
              child: ListTab(currency: currency, currencies: currencies),
            ),
            Offstage(
              offstage: index != 1,
              child: PlotTab(currency: currency, currencies: currencies),
            ),
          ],
        );
      },
    );
  }
}
