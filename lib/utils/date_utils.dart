import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String PATTERN_DEFAULT = "dd/MM/yyyy, hh:mm";

  static String convertDateToStringDefault(int milliseconds) {
    return DateFormat(PATTERN_DEFAULT)
        .format(DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000));
  }
}
