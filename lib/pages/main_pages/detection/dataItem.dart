import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';

import '../../../flutter_flow/flutter_flow_util.dart';
export 'detection_model.dart';

class YourDataItem {
  final String postureName;
  final int minutes;

  YourDataItem(this.postureName, this.minutes);
}

List<YourDataItem> yourItemList = [
  // 添加更多的項目...
];


void sortAndMoveToTop(List<YourDataItem> itemList, String currentPostureName) {
  itemList.sort((a, b) {
    // 将特定的 postureName 移到列表的第一位
    if (a.postureName == currentPostureName) {
      return -1;
    } else if (b.postureName == currentPostureName) {
      return 1;
    }
    // 根据 minutes 进行排序
    return b.minutes.compareTo(a.minutes);
  });
}






