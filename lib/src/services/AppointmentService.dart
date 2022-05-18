import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loaner/src/models/DropdownModel.dart';
import 'package:loaner/src/models/MenuChoice.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/services/Urls.dart';

class AppointmentService {
  final _prefService = SharedPreferencesService();

   Future<List<AppointmentDataModel>> getAllAppointments(
      ) async {
    List<AppointmentDataModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_ALL_APPOINTMENTS",
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<AppointmentDataModel> _resultData =
            _jsonResponse.map((i) => AppointmentDataModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<List<AppointmentDataModel>> getAppointmentsByStatus(
      {required String status}) async {
    List<AppointmentDataModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENT_BY_STATUS",
        "status": status
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<AppointmentDataModel> _resultData =
            _jsonResponse.map((i) => AppointmentDataModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<AppointmentDataModel> getAppointmentDetail(
      {required String appNo}) async {
    AppointmentDataModel _result = AppointmentDataModel();

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENT_DETAIL",
        "appNo": appNo
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        final AppointmentDataModel _resultData =
            AppointmentDataModel.fromJson(_jsonResponse);
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<AppointmentDataModel> manageAppointment(
      {required AppointmentDataModel app}) async {
    AppointmentDataModel _result = AppointmentDataModel();

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "MANAGE_APPOINTMENT",
        "app": app
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        final AppointmentDataModel _resultData =
            AppointmentDataModel.fromJson(_jsonResponse);
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

    Future<List<AppointmentDataModel>> getAppointmentsBySearch(
      {required String status,required String date,required String hospital}) async {
    List<AppointmentDataModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENTS_BY_SEARCH",
        "status": status,
        "hospital" :hospital,
        "date" : date
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<AppointmentDataModel> _resultData =
            _jsonResponse.map((i) => AppointmentDataModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

   Future<List<DropdownModel>> getHospitalList(
      ) async {
    List<DropdownModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_HOSPITAL_LIST",
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<DropdownModel> _resultData =
            _jsonResponse.map((i) => DropdownModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

   Future<List<DropdownModel>> getEmployeeByDepId({required String depId}
      ) async {
    List<DropdownModel> _result = [];

    try {
      final _url = Uri.parse(Urls.employeeUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_EMPLOYEE_BY_DEPID",
        'depId' : depId
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<DropdownModel> _resultData =
            _jsonResponse.map((i) => DropdownModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }
}
