import 'package:currency_rate_app/model/currency.dart';

class CustomTexts {
  static const String list = "Lista";
  static const String plot = "Wykres";
  static const String details = "Szczegóły";
  static const String chooseCurrency = "Wybierz walutę";

  static String update(Currency currency) =>
      "Aktualizacja:     ${currency.date}";
}
