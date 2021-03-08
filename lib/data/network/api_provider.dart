import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reciclaje_app/data/network/custom_exception.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  var client = http.Client();

  String baseUrl=env['URL'];
  Uri toUri(String path) => toUri(path);

  Future<dynamic> get(String url) async {
    var responseJson;
    
    print(baseUrl+url);
    try {
      final response = await http.get(toUri(baseUrl + url));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  Future<dynamic> post(String url, String objToCreate) async {
    print(baseUrl+url);
    var responseJson;
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await http.post(
        Uri.https(baseUrl,url),
        headers: headers,
        body: objToCreate,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
/*
  Future<dynamic> put(String url, String objToUpdate) async {
    var responseJson;
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await http.put(
        baseUrl + url,
        headers: headers,
        body: objToUpdate,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
*/
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        return json.decode(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
