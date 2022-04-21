import 'package:date_format/date_format.dart';

class ConvertDateFormat{
  static String convertDateFormat({required DateTime date}) =>
      formatDate(date, [dd, '-', mm, '-', yyyy]).toString();

  static String convertTimeFormat({required DateTime date}) =>  formatDate(date, [HH, ':', nn]).toString();
}