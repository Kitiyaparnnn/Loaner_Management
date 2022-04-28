import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/services/Urls.dart';

class AppointmentService {
  final _prefService = SharedPreferencesService();

  Future<List<AppointmentDataModel>> getAppointments(
      {required String status}) async {
    List<AppointmentDataModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

       Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENTS",
        "status" : status
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<AppointmentDataModel> _resultData = _jsonResponse.map((i) => AppointmentDataModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;

    } catch (e) {
      logger.e(e);
      return _result;
    }
  }
}
