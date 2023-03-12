import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/view/details/cubit/tab_cubit.dart';
import 'package:currency_rate_app/view/details/widgets/list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DetailsView extends StatelessWidget {
  final String code;

  const DetailsView({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, int>(
      builder: (_, index) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Szczegóły"),
            leading: const BackButton(),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 12),
                alignment: Alignment.center,
                child: Text(
                  code,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          body: SafeArea(child: _tab(index)),
          bottomNavigationBar: _navigationBar(context, index),
        );
      },
    );
  }

  Widget _tab(int index) {
    return Stack(
      children: [
        Offstage(
          offstage: index != 0,
          child: const ListTab(),
        ),
        Offstage(
          offstage: index != 1,
          child: const Text("2"),
        ),
      ],
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
            GButton(icon: Icons.list, text: list),
            GButton(icon: Icons.bar_chart, text: plot),
          ],
          selectedIndex: index,
          onTabChange: (index) => context.read<TabCubit>().changeTab(index)),
    );
  }
}
