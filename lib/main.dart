import 'package:currency_rate_app/view/details/cubit/currency_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/tab_cubit.dart';
import 'package:currency_rate_app/view/loading/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: CustomColors.blue5,
    ));
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
          scaffoldBackgroundColor: CustomColors.bgColor,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: CustomColors.blue5),
        ),
        home: const LoadingView(),
      ),
    );
  }
}
