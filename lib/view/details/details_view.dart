import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/model/currency_detail/currency_detail_combined.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/tab_cubit.dart';
import 'package:currency_rate_app/view/details/widgets/list_tab.dart';
import 'package:currency_rate_app/view/details/widgets/plot_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DetailsView extends StatelessWidget {
  final String code;
  final Currency currency;

  const DetailsView({
    Key? key,
    required this.code,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, int>(
      builder: (_, index) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              CustomTexts.details,
              style: CustomTypography.appbarStyle,
            ),
            leading: const BackButton(),
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
          bottomNavigationBar: _navigationBar(context, index),
        );
      },
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

  Widget _navigationBar(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 100),
          tabBackgroundColor: Colors.grey[100]!,
          color: Colors.black,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          tabs: const [
            GButton(icon: Icons.list, text: CustomTexts.list),
            GButton(icon: Icons.bar_chart, text: CustomTexts.plot),
          ],
          selectedIndex: index,
          onTabChange: (index) => context.read<TabCubit>().changeTab(index)),
    );
  }
}
