import 'package:currency_rate_app/view/details/cubit/tab_cubit.dart';
import 'package:currency_rate_app/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabCubit(),
      child: MaterialApp(
        title: 'Currency Rate App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (_) => TabCubit(),
          child: const HomeView(),
        ),
      ),
    );
  }
}
