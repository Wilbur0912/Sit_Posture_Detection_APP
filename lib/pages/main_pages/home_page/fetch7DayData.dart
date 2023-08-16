import 'dart:convert';

import '../../../flutter_flow/flutter_flow_util.dart';
import 'package:http/http.dart' as http;

import '../detection/dataItem.dart';
int averageMinutes = 0;
Future<void> fetch7DayDataList() async {
  final String value = 'weber'; // 这是你的 user_name 值
  final DateTime now = DateTime.now();
  final List<Future<http.Response>> fetchRequests = [];

  for (int i = 0; i < 7; i++) {
    final DateTime targetDate = now.subtract(Duration(days: i));
    final String formattedDate = DateFormat('yyyy/M/d').format(targetDate);
    final fetchRequest = http.get(
      Uri.parse('http://172.20.10.2:8080/getTodayDataList?date=$formattedDate'),
      headers: {'Cookie': 'user_name=$value'},
    );
    fetchRequests.add(fetchRequest);
  }

  final List<YourDataItem> allDataItems = [];

  await Future.wait(fetchRequests).then((responses) {
    for (final response in responses) {
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<YourDataItem> dataItems = responseData.map((itemData) {
          return YourDataItem(itemData['name'], itemData['minutes']);
        }).toList();
        allDataItems.addAll(dataItems);
      }
    }
  });

  double totalMinutes = 0;
  for (final item in allDataItems) {
    if(item.postureName != "坐姿端正"){
      totalMinutes += item.minutes;
    }
  }

  averageMinutes = (totalMinutes / 7).toInt();

}