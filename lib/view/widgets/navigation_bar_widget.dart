import 'package:currency_rate_app/constants/custom_colors.dart';
import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/view/details/cubit/tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBarWidget extends StatelessWidget {
  final int index;
  final String code;
  final bool isTopBar;

  const NavigationBarWidget({
    Key? key,
    required this.index,
    this.code = "",
    this.isTopBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.blue1,
      child: GNav(
          rippleColor: CustomColors.blue3.withOpacity(0.3),
          hoverColor: CustomColors.blue3.withOpacity(0.1),
          gap: 8,
          activeColor: Colors.white,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 500),
          tabBackgroundColor: CustomColors.blue3.withOpacity(0.5),
          color: Colors.white,
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
