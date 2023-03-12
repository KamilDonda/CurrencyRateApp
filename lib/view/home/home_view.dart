import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/currency.dart';
import 'package:currency_rate_app/view/details/cubit/currency_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/details_view.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Wybierz walutę",
          style: CustomTypography.appbarStyle,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CurrencyCubit, List<Currency>>(
            builder: (_, currencies) {
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: currencies.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                var code = currencies[index].code;
                context.read<CurrencyDetailCubit>().setCurrencyDetail(
                      code.toLowerCase(),
                    );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailsView(code: code)),
                );
              },
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flag.fromCode(
                        currencies[index].countryCode,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fitWidth,
                        flagSize: FlagSize.size_4x3,
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          currencies[index].code,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          currencies[index].name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          currencies[index].value.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
