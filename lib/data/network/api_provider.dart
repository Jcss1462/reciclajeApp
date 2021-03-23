import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reciclaje_app/data/network/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'package:reciclaje_app/service/preferences.dart';

class ApiProvider {
  var client = http.Client();

  String baseUrl = env['URL'];

  Preferences preferencias = new Preferences();

  Future<dynamic> get(String url) async {
    var responseJson;
    String token;

    print(baseUrl + url);

    try {
      await preferencias.obtenerToken().then((value) async {
        token = value;
      });
      print(token);
      Map<String, String> headers = {"Authorization": token};
      final response =
          await http.get(Uri.https(baseUrl, url), headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, String objToCreate) async {
    print(baseUrl + url);
    var responseJson;
    String token;
    try {
      await preferencias.obtenerToken().then((value) async {
        token = value;
      });
      print(token);
      Map<String, String> headers = {"Content-Type": "application/json","Authorization":token};

      final response = await http.post(
        Uri.https(baseUrl, url),
        headers: headers,
        body: objToCreate,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> del(String url) async {
    var responseJson;
    String token;

    print(baseUrl + url);

    try {
      await preferencias.obtenerToken().then((value) async {
        token = value;
      });
      print(token);
      Map<String, String> headers = {"Authorization": token};
      final response =
          await http.delete(Uri.https(baseUrl, url), headers: headers);
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
        try {
          return json.decode(response.body.toString());
        } catch (e) {
          return 1;
        }
        break;
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
