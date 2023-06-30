import 'package:intl/intl.dart';

class DateHelper {
  static DateTime formatDate(String date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.parse(date);
  }

  static String parseDate(DateTime? date) {
    DateFormat formatter = DateFormat('dd MMM, yyyy');
    if (date == null) {
      return '';
    } else {
      return formatter.format(date);
    }
  }
}