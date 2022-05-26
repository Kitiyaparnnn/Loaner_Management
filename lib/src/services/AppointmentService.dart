import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loaner/src/models/DropdownModel.dart';
import 'package:loaner/src/models/MenuChoice.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/models/appointment/AppointmentModel.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/services/Urls.dart';

class AppointmentService {
  final _prefService = SharedPreferencesService();

  Future<List<AppointmentModel>> getAllAppointments(
      {required String limit}) async {
    List<AppointmentModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_ALL_APPOINTMENTS",
        'limit': limit
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<AppointmentModel> _resultData =
            _jsonResponse.map((i) => AppointmentModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByStatus(
      {required String status,required String limit}) async {
    List<AppointmentModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENT_BY_STATUS",
        "status": status,
        "limit":limit
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<AppointmentModel> _resultData =
            _jsonResponse.map((i) => AppointmentModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<AppointmentDataModel> getAppointmentDetail(
      {required String id}) async {
    AppointmentDataModel _result = AppointmentDataModel();

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENT_DETAIL",
        "id": id
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final _jsonResponse = json.decode(_response.body);

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

  Future<EmployeeModel> getAppointmentEmpDetail({required String id}) async {
    EmployeeModel _result = EmployeeModel();

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENT_EMP_DETAIL",
        "id": id
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final _jsonResponse = json.decode(_response.body);

        final EmployeeModel _resultData = EmployeeModel.fromJson(_jsonResponse);
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
      final _sharedPreferencesService = SharedPreferencesService();
      String empId = await _sharedPreferencesService.preferenceGetUserId();
      // logger.d(app.toJson());

      Map<String, dynamic> _body = {
        'function': "MANAGE_APPOINTMENT",
        "app": app,
        "emp_id": empId
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );
      logger.d(_response.body);
      if (_response.statusCode == 200) {
        final _jsonResponse = json.decode(_response.body);

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

  Future<List<AppointmentModel>> getAppointmentsBySearch(
      {required String status,
      required String date,
      required String hospital}) async {
    List<AppointmentModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENTS_BY_SEARCH",
        "status": status,
        "hospital": hospital,
        "date": date
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<AppointmentModel> _resultData =
            _jsonResponse.map((i) => AppointmentModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<List<DropdownModel>> getHospital() async {
    List<DropdownModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_HOSPITAL",
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

  Future<List<DropdownModel>> getSupplierEmp({required String depId}) async {
    List<DropdownModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_SUPPLIER_EMP",
        'depId': depId
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

  Future<List<DropdownModel>> getHosDept({required String hosId}) async {
    List<DropdownModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_HOS_DEPT",
        'hospitalId': hosId
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

  Future<List<DropdownModel>> getHosEmp({required String hosId}) async {
    List<DropdownModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_HOS_EMP",
        'hospitalId': hosId
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

  Future<List<DropdownModel>> getHosDoc({required String hosId}) async {
    List<DropdownModel> _result = [];

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_HOS_DOC",
        'hospitalId': hosId
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

  Future<AppointmentDataModel> setAppointmentStatus(
      {required String id, required String status}) async {
    AppointmentDataModel _result = AppointmentDataModel();

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "SET_APPOINTMENT_STATUS",
        'appId': id,
        'status': status
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final _jsonResponse = json.decode(_response.body);

        final AppointmentDataModel _resultData =
            AppointmentDataModel.fromJson(_jsonResponse);
        _result = _resultData;
      }
      logger.d(_response.body);

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<AppointmentModel> getEachAppointmentDetail(
      {required String id}) async {
    AppointmentModel _result = AppointmentModel();

    try {
      final _url = Uri.parse(Urls.appointmentUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_APPOINTMENT_EACH_DETAIL",
        "id": id
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final _jsonResponse = json.decode(_response.body);

        final AppointmentModel _resultData =
            AppointmentModel.fromJson(_jsonResponse);
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }
}
