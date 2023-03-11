import 'dart:convert';
import 'package:http/http.dart' as http;

import '../services/handlerErrors.dart';

dynamic returnResponse(http.Response response) {
  var responseJson = jsonDecode(response.body) as List;
  switch (response.statusCode) {
    case 200:
      return responseJson;
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
