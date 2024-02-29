import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'base_api_service.dart';
import 'exceptions/app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    // ignore: avoid_print
    debugPrint(url);

    dynamic responseJson;

    // Option 1 Only one Try
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Encoding': 'gzip'
      }).timeout(const Duration(seconds: 3600));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOutExceptions {
      throw RequestTimeOutExceptions('');
    }
    return responseJson;

    // Option 2 for multiple retries
    /*
    int attempts = 10;
    bool gotResponse = false;
    String errMsg = "";
    while (attempts > 0) {
      attempts = attempts - 1;
      debugPrint(attempts.toString());
      try {
        final response = await http
            .get(Uri.parse(url))
            .timeout(const Duration(seconds: 3600));
        responseJson = returnResponse(response);
        return responseJson;
      } catch (err) {
        // set your tracking variables for failure checking here
        gotResponse = false;
        errMsg = err.toString();
      }
    }
    if (gotResponse == false) {
      throw Exception(errMsg);
    } else {
      throw Exception("Everything's broken");
    }
    */
  }

  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    if (kDebugMode) {
      debugPrint(url);
      debugPrint(data);
    }
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url),
              body:
                  data //jsonEncode(data)   // if data is in raw form then encode else only data
              )
          .timeout(const Duration(seconds: 3600));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOutExceptions {
      throw RequestTimeOutExceptions('');
    } on FetchDataExceptions {
      throw FetchDataExceptions('');
    }
    if (kDebugMode) {
      debugPrint(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      debugPrint(response.statusCode.toString());
    }
    switch (response.statusCode) {
      case 200:
        // option 1
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      // option 2
      //final bytes = response.bodyBytes;
      //debugPrint(bytes.toString());
      // Convert bytes to String then decode
      //dynamic responseJson = jsonDecode(utf8.decode(bytes));
      //return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      //throw InvalidUrlExceptions('');
      default:
        throw FetchDataExceptions(''); // Error ${response.statusCode}
    }
  }
}
