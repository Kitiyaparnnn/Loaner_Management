import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loaner/src/models/employee/EmployeeDataModel.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/Urls.dart';

class EmployeeService {
  Future<EmployeeDataModel> createEmployee(
      {required EmployeeDataModel employee}) async {
    EmployeeDataModel _result = EmployeeDataModel();

    try {
      final _url = Uri.parse(Urls.employeeUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "CREATE_EMPLOYEE",
        "data": employee
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

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

  Future<List<EmployeeModel>> getAllEmployees(
      ) async {
    List<EmployeeModel> _result = [];

    try {
      final _url = Uri.parse(Urls.employeeUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_ALL_EMPLOYEES",
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

  Future<List<EmployeeModel>> getEmployeeBySearch({
    required  String textSearch
  }
      ) async {
    List<EmployeeModel> _result = [];

    try {
      final _url = Uri.parse(Urls.employeeUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "GET_SEARCH_EMPLOYEES",
        "textSearch": textSearch
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
}
