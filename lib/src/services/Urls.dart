import 'package:loaner/src/services/SharedPreferencesService.dart';

class Urls {
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  // static String devUrl = "http://poseintelligence.dyndns.biz:8088/temperature_api/api";
  // static String productionUrl = "http://poseintelligence.dyndns.biz:8088/temperature_api/api";

  static String? baseUrl;

  init() async {
    baseUrl = "http://192.168.1.104/Loaner_Management_api/api";
  }

  //login
  static String loginUrl = "$baseUrl/login.php";

  //appointment
  static String appointmentUrl = "$baseUrl/appointment/appointment.php";

  //loaner
  static String loanerUrl = "$baseUrl/loaner/loaner.php";

  //employee
  static String employeeUrl = "$baseUrl/employee/employee.php";
}
