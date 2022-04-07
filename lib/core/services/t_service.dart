import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TService {
  /// Returns application/json header
  getJsonHeader() {
    Map<String, String> headers = {'Content-type': 'application/json'};
    return headers;
  }

  /// Generic method to handle the server response
  handleResponse(http.Response response) {
    // check for erros
    if (response.statusCode == 400 ||
        response.statusCode == 500 ||
        response.statusCode == 403 ||
        response.statusCode == 401) {
      Map<String, dynamic> error = {
        "statusCode": response.statusCode,
        "error": response.reasonPhrase,
        "status": false
      };
      throw Exception(error);
    }
    return response;
  }

  ///Generic method to handle http get request
  Future<Response> httpGet(String url,
      {Map<String, String>? authHeader}) async {
    try {
      return http.get(Uri.parse(url), headers: authHeader ?? getJsonHeader());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  ///Generic method to handle http Post request
  Future<Response> httpPost(String url, Map<String, dynamic> body,
      {Map<String, String>? authHeader}) async {
    try {
      return http.post(Uri.parse(url),
          body: json.encode(body), headers: authHeader ?? getJsonHeader());
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Generic method to handle http Delete request
  Future<Response> httpDelete(String url,
      {Map<String, String>? authHeader}) async {
    try {
      return http.delete(Uri.parse(url),
          headers: authHeader ?? getJsonHeader());
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Generic method to handle http Put request
  Future<Response> httpPut(String url, Map<String, dynamic> body,
      {Map<String, String>? authHeader}) async {
    try {
      return http.put(Uri.parse(url),
          body: json.encode(body), headers: authHeader ?? getJsonHeader());
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Generic method to handle http Patch request
  Future<Response> httpPatch(String url, Map<String, dynamic> body,
      {Map<String, String>? authHeader}) {
    try {
      return http.patch(Uri.parse(url),
          body: json.encode(body), headers: authHeader ?? getJsonHeader());
    } catch (e) {
      throw Exception(e);
    }
  }
}
