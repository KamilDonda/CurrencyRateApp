import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/view/details/cubit/tab_cubit.dart';
import 'package:currency_rate_app/view/details/details_landscape.dart';
import 'package:currency_rate_app/view/details/details_portrait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return OrientationBuilder(
          builder: (_, orientation) {
            return orientation == Orientation.portrait
                ? DetailsPortrait(code: code, currency: currency, index: index)
                : DetailsLandscape(
                    code: code,
                    currency: currency,
                    index: index,
                  );
          },
        );
      },
    );
  }
}
