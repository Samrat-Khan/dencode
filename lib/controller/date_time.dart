import 'package:intl/intl.dart';

class DateTimeController {
  fullDate({required DateTime date}) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  fullTime({required DateTime time}) {
    return DateFormat('hh:mm a').format(time);
  }
}
