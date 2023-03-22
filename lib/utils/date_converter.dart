import 'package:intl/intl.dart';

class DateConverter {
  static String dd_MM_yyyy(String date) {
    return DateFormat("dd.MM.yyyy")
        .format(DateFormat("yyyy-MM-dd").parse(date));
  }

  static String dd_MM(String date) {
    return DateFormat("dd.MM").format(DateFormat("dd.MM.yyyy").parse(date));
  }
}
