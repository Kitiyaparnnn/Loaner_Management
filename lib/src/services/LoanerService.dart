import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loaner/src/models/loaner/LoanerDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/services/Urls.dart';

class LoanerService {
  Future<LoanerDataModel> createLoaner(
      {required LoanerDataModel loaner}) async {
    LoanerDataModel _result = LoanerDataModel();

    try {
      final _url = Uri.parse(Urls.loanerUrl);
      var _response;

      Map<String, dynamic> _body = {
        'function': "CREATE_LOANER",
        "data": loaner
      };

      logger.i(_body);

      _response = await http.post(
        _url,
        body: jsonEncode(_body),
      );

      if (_response.statusCode == 200) {
        final List _jsonResponse = json.decode(_response.body);

        final LoanerDataModel _resultData =
            LoanerDataModel.fromJson(_jsonResponse);
        _result = _resultData;
      }

      return _result;
    } catch (e) {
      logger.e(e);
      return _result;
    }
  }
}
