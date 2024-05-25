import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String toKiloMeter(double distance) {
  final km = (distance / 1000).toStringAsFixed(2);

  return km.replaceAll('.', ',');
}

String toMinute(double duration) {
  final minute = (duration / 60).ceil().toStringAsFixed(0);

  return minute;
}

String toDateTime(DateTime date) {
  return DateFormat('hh:mm\ndd-MM-yyyy').format(date.toLocal()).toString();
}

String convertDateTimeToIndo(DateTime dateTime) {
  initializeDateFormatting();
  final DateFormat formatter = DateFormat('d MMMM y', 'id');
  final String now = formatter.format(dateTime);

  return now;
}

String toThousand(int number) {
  // Format the number with thousand separators
  final format = NumberFormat.decimalPattern('id');
  return format.format(number);
}

String getImageNameFromFirebase(String link) {
  String fileName = link;

  fileName = fileName.split("/")[7];
  fileName = fileName.replaceAll("%2F", " ");
  fileName = fileName.split(' ')[3];
  fileName = fileName.split('?')[0];

  return fileName;
}
