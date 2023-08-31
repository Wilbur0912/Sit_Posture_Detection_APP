import 'package:http/http.dart' as http;
Future<void> sendInfoToAP(String wifiName, String wifiPassword) async {
  // 假设 AP 提供一个 HTTP 接口用于接收信息
  final url = Uri.parse('http://your-ap-url/api/send-info');
  final response = await http.post(
    url,
    body: {
      'wifiName': wifiName,
      'wifiPassword': wifiPassword,
    },
  );

  if (response.statusCode == 200) {
    print('信息已成功发送给AP');
  } else {
    print('发送信息给AP失败：${response.statusCode}');
  }
}