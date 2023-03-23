import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/view/details/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CurrencyCubit>().setCurrencies();
    return Center(
      child: Text(
        CustomTexts.dataNotFound,
        style: CustomTypography.dataNotFoundStyle,
      ),
    );
  }
}
