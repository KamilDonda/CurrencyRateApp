import 'package:currency_rate_app/model/Currency.dart';
import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static final currencies = [
    Currency(
      name: "Dolar\nAmerykański",
      countryCode: FlagsCode.US,
      code: "USD",
      symbol: "\$",
      value: 4.3,
    ),
    Currency(
      name: "Euro",
      countryCode: FlagsCode.EU,
      code: "EU",
      symbol: "€",
      value: 5.64,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: currencies.length,
          itemBuilder: (_, index) => GestureDetector(
            onTap: () {
              if (kDebugMode) {
                print(currencies[index].name);
              }
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
