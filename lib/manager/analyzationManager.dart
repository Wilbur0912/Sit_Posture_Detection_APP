
import 'package:http/http.dart' as http;
class ResponseData {
  bool isSuccess = false;
  dynamic data;
}
class AnalyzationManager{
  static const String baseUrl = "https://d7fc3fd8-0191-42ed-aad3-92e3b6b142df.mock.pstmn.io";

  static Future<ResponseData> getSitRecord(String? username, String start, String? end) async {
    final url = "$baseUrl/getSitRecord";
    ResponseData responseData = ResponseData();
    final requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Cookie': (username != null?'username: ${username};': '')+ 'start: $start' + (end != null ? ';end: $end' : ''),
    };
    try {
      final res = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );
      responseData.isSuccess = res.statusCode < 400;
      responseData.data = res.body;
    } catch (e) {
      throw Exception("登入失敗：$e");
    }
    return responseData;
  }
}