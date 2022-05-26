import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/services/Urls.dart';

class EmployeeService {
  Future<EmployeeDataModel> manageEmployee(
      {required EmployeeDataModel employee}) async {
    EmployeeDataModel _result = EmployeeDataModel();

    try {
      final _url = Uri.parse(Urls.employeeUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "MANAGE_EMPLOYEE",
        "employee": employee
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );
      logger.d(_response.body);
      if (_response.statusCode == 200) {
        final _jsonResponse = json.decode(_response.body);

        final EmployeeDataModel _resultData =
            EmployeeDataModel.fromJson(_jsonResponse);
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<List<EmployeeModel>> getAllEmployees() async {
    List<EmployeeModel> _result = [];

    try {
      final _url = Uri.parse(Urls.employeeUrl);
      var _response;
      final _sharedPreferencesService = SharedPreferencesService();
      String deptId = await _sharedPreferencesService.preferenceGetDepId();

      Map<String, dynamic> _body = {
        'function': "GET_ALL_EMPLOYEES",
        'deptId': deptId
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<EmployeeModel> _resultData =
            _jsonResponse.map((i) => EmployeeModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<List<EmployeeModel>> getEmployeeBySearch(
      {required String textSearch}) async {
    List<EmployeeModel> _result = [];

    try {
      final _url = Uri.parse(Urls.employeeUrl);
      var _response;
      final _sharedPreferencesService = SharedPreferencesService();
      String deptId = await _sharedPreferencesService.preferenceGetDepId();

      Map<String, dynamic> _body = {
        'function': "GET_EMPLOYEE_BY_SEARCH",
        "textSearch": textSearch,
        "deptId": deptId
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        List<EmployeeModel> _resultData =
            _jsonResponse.map((i) => EmployeeModel.fromJson(i)).toList();
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }

  Future<EmployeeDataModel> getEmployeeDetail({required String empId}) async {
    EmployeeDataModel _result = EmployeeDataModel();

    try {
      final _url = Uri.parse(Urls.employeeUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_EMPLOYEE_DETAIL",
        "empId": empId
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final _jsonResponse = json.decode(_response.body);

        final EmployeeDataModel _resultData =
            EmployeeDataModel.fromJson(_jsonResponse);
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }
}
