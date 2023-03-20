import 'package:currency_rate_app/view/details/cubit/currency_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/tab_cubit.dart';
import 'package:currency_rate_app/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TabCubit()),
        BlocProvider(create: (_) => CurrencyCubit()..setCurrencies()),
        BlocProvider(create: (_) => CurrencyDetailCubit()),
      ],
      child: MaterialApp(
        title: 'Currency Rate App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: CustomColors.blue1,
          ),
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        ),
        home: const HomeView(),
      ),
    );
  }
}
