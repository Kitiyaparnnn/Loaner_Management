import 'package:loaner/src/services/SharedPreferencesService.dart';

class Urls{
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  // static String devUrl = "http://poseintelligence.dyndns.biz:8088/temperature_api/api";
  // static String productionUrl = "http://poseintelligence.dyndns.biz:8088/temperature_api/api";

  static String? baseUrl;

  init() async {
    baseUrl = await _sharedPreferencesService.preferenceGetBaseApiUrl();
  }


  //login
  static String loginUrl = "$baseUrl/login.php";


  //event
  static String eventEventsTypeUrl = "$baseUrl/event/events_type.php";
  static String eventEventDocumentUrl = "$baseUrl/event/event_document.php";

  //water
  static String waterUrl = "$baseUrl/water/water.php";

  // image
  static String eventImageUrl = "$baseUrl/images/";

  //setting
  static String settingUrl = "$baseUrl/setting/setting.php";

  //appointment
  static String appointmentUrl = "$baseUrl/appointment/appointment.php";

}
