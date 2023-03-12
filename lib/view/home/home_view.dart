import 'package:currency_rate_app/model/Currency.dart';
import 'package:currency_rate_app/view/details/cubit/detail_currency_cubit.dart';
import 'package:currency_rate_app/view/details/details_view.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static final currencies = [
    Currency(
      name: "Dolar\nAmerykański",
      countryCode: FlagsCode.US,
      code: "USD",
      symbol: "\$",
      value: 4.4726,
    ),
    Currency(
      name: "Euro",
      countryCode: FlagsCode.EU,
      code: "EUR",
      symbol: "€",
      value: 4.3840,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Wybierz walutę"),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: currencies.length,
          itemBuilder: (_, index) => GestureDetector(
            onTap: () {
              var code = currencies[index].code;
              context.read<DetailCurrencyCubit>().getDetailCurrency(
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
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
