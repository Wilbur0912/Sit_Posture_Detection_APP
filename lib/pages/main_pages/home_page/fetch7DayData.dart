import 'dart:convert';

import '../../../flutter_flow/flutter_flow_util.dart';
import 'package:http/http.dart' as http;

import '../../../manager/AnalyzationManager.dart';
import '../detection/dataItem.dart';
int averageMinutes = 0;

Future<int> fetch7DayDataList(String? token) async {
  final DateTime now = DateTime.now();
  final DateTime endDate = now;
  final DateTime startDate = now.subtract(Duration(days: 6)); // 获取过去7天的起始日期

  final String formattedStartDate = DateFormat('yyyy-M-d').format(startDate);
  final String formattedEndDate = DateFormat('yyyy-M-d').format(endDate);

  final List<YourDataItem> allDataItems = [];

  final response = await AnalyzationManager.getSitRecord(token, formattedStartDate, formattedEndDate);
  print("reppon"+response.data.toString());
  final responseDataList = json.decode(response.data);

  if (response.isSuccess && responseDataList is List<dynamic>) {
    final List<YourDataItem> dataItems = responseDataList.map((itemData) {
      return YourDataItem(itemData['position'], itemData['second']);
    }).toList();
    allDataItems.addAll(dataItems);
    for (YourDataItem item in allDataItems) {
      print("Position: ${item.position}, Second: ${item.second}");
    }

  }

  double totalMinutes = 0;
  for (final item in allDataItems) {
    if (item.position != "坐姿端正") {
      totalMinutes += item.second;
    }
  }

  averageMinutes = totalMinutes ~/ 7;
  return averageMinutes;
  print("avag"+averageMinutes.toString());
}






//------------------------------------------------------------------------
// int averageMinutes = 0;
//
// Future<void> fetch7DayDataList(String? token) async {
//   final String value = 'weber'; // 这是你的 user_name 值
//   final DateTime now = DateTime.now();
//   final List<Future<http.Response>> fetchRequests = [];
//
//   for (int i = 0; i < 7; i++) {
//     final DateTime targetDate = now.subtract(Duration(days: i));
//     final String formattedDate = DateFormat('yyyy/M/d').format(targetDate);
//     final fetchRequest = http.get(
//       Uri.parse('http://172.20.10.2:8080/getTodayDataList?date=$formattedDate'),
//       headers: {'Cookie': 'user_name=$value'},
//     );
//     fetchRequests.add(fetchRequest);
//   }
//
//   final List<YourDataItem> allDataItems = [];
//
//   await Future.wait(fetchRequests).then((responses) {
//     for (final response in responses) {
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);
//         final List<YourDataItem> dataItems = responseData.map((itemData) {
//           return YourDataItem(itemData['name'], itemData['minutes']);
//         }).toList();
//         allDataItems.addAll(dataItems);
//       }
//     }
//   });
//
//   double totalMinutes = 0;
//   for (final item in allDataItems) {
//     if(item.postureName != "坐姿端正"){
//       totalMinutes += item.minutes;
//     }
//   }
//
//   averageMinutes = (totalMinutes / 7).toInt();
//
// }