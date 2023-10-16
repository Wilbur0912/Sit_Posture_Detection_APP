import 'dart:convert';

import 'package:http/http.dart' as http;

class ResponseData {
  bool isSuccess = false;
  dynamic data;
}

class AnalyzationManager {
  static const String baseUrl =
      "https://spineinspectorbackend-production.up.railway.app/api";

  static Future<ResponseData> getSitRecord(
      String? token, String? start, String end) async {
    String url = "$baseUrl/data/get/";
    // if (end != null) url += end;
    // String url = "$baseUrl/getSitRecord";
    ResponseData responseData = ResponseData();
    final requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Cookie':'token=token',
      'token': '$token',
      if (start != null) 'start': '$start',
      'end': '$end',
    };
    try {
      final res = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      responseData.isSuccess = res.statusCode < 400;
      responseData.data = utf8.decode(res.bodyBytes);
    } catch (e) {
      throw Exception("失敗：$e ");
    }

    return responseData;
  }
}
