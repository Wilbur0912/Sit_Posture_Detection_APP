import 'dart:math';

import 'package:appp3/model/sitRecordModel.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../flutter_flow/flutter_flow_charts.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../manager/analyzationManager.dart';
import 'analyzationUtil.dart';

class AnalysisChart extends StatefulWidget {
  DateTime start;
  DateTime? end;
  String type;
  // String? username;
  List<SitRecord> SitRecordList;
  AnalysisChart({
    Key? key,
    required this.start,
    this.end,
    required this.type,
    // this.username,
    required this.SitRecordList,
  }) : super(key: key);

  @override
  State<AnalysisChart> createState() => _AnalysisChartState();
}

class _AnalysisChartState extends State<AnalysisChart> {
  Map<String, int> dateCounter = {};
  List<String> dateKey = [];
  List<FlSpot> lineChartData = [];
  int maxCount = 0;

  @override
  void didUpdateWidget(covariant AnalysisChart oldWidget) {
    _onDateChange();
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _onDateChange() async {
    String startDate = DateFormat("yyyy-MM-dd").format(widget.start);
    String? endDate;
    if (widget.end != null) {
      DateTime tmp = widget.end!;
      endDate = DateFormat("yyyy-MM-dd").format(tmp);
      print(endDate);
    }
    // if (widget.username != null) {
    //   final res = await AnalyzationManager.getSitRecord(
    //       widget.username, startDate, endDate);
    //   final List<SitRecord> SitRecordList = SitRecordFromResponse(res.data);
      final List<SitRecord> SitRecordList = widget.SitRecordList;
      SitRecordList.sort((a, b) => a.time.compareTo(b.time));
      dateKey = [];
      dateCounter = {};
      lineChartData = [];

      setState(() {
        _setDateCounter(SitRecordList);
        _setLineChartData();
        maxCount =
            dateCounter.values.isEmpty ? 0 : dateCounter.values.reduce(max);
      });
    // }
  }

  void _setDateCounter(List<SitRecord> SitRecordList) {
    for (int i = 0; i < SitRecordList.length; i++) {
      String interval = ''; // 用於儲存時間區間
      DateTime sitTime = SitRecordList[i].time; // 取得 SitRecord 的時間

      switch (widget.type) {
        case '年':
          interval = DateFormat("yyyy").format(sitTime); // 格式化為年份
          break;
        case '月':
          interval = DateFormat("MM").format(sitTime); // 格式化為月
          break;
        case '日':
          interval = DateFormat("MM/dd").format(sitTime); // 格式化為月/日
          break;
        case '周':
          DateTime p1 = widget.start; // 開始時間
          DateTime p2 = p1.add(const Duration(days: 7)); // 加7天得到下一個時間點
          DateTime p3 = p2.add(const Duration(days: 7));
          DateTime p4 = p3.add(const Duration(days: 7));
          DateTime p5 = p4.add(const Duration(days: 7));

          if (isDateInRange(sitTime, p1, p2)) {
            interval =
                "${DateFormat("MM/dd").format(p1)}~${DateFormat("dd").format(p2)}";
          } else if (isDateInRange(sitTime, p2, p3)) {
            interval =
                "${DateFormat("MM/dd").format(p2)}~${DateFormat("dd").format(p3)}";
          } else if (isDateInRange(sitTime, p3, p4)) {
            interval =
                "${DateFormat("MM/dd").format(p3)}~${DateFormat("dd").format(p4)}";
          } else if (isDateInRange(sitTime, p4, p5)) {
            interval =
                "${DateFormat("MM/dd").format(p4)}~${DateFormat("dd").format(p5)}";
          }
          break;
      }

      if (interval != null) {
        if (dateCounter.containsKey(interval)) {
          dateCounter[interval] = (dateCounter[interval] ?? 0) + 1;
        } else {
          dateCounter[interval] = 1;
          dateKey.add(interval);
        }
      }
    }
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    if (dateKey.isEmpty) return Container();
    String text = dateKey[value.toInt()];

    if (widget.type == "月") {
      text += "月";
    } else if (widget.type == "年") {
      text += "年";
    }
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      space: 20,
      child: Text(text,
          style: const TextStyle(color: Color(0xff6a6f88), fontSize: 11)),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(
        0xff6a6f88,
      ),
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: LineChart(
            LineChartData(
              maxY:  maxCount*1.2,
              backgroundColor: Colors.white,
              lineTouchData: LineTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: bottomTitles,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    // reservedSize: 40,
                    getTitlesWidget: leftTitles,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false,),

                ),
              ),
              lineBarsData: lineChartData.isNotEmpty
                  ? [
                      LineChartBarData(
                        spots: lineChartData, // 資料點的列表
                        dotData: FlDotData(show: false),
                        isCurved: true,
                        color: FlutterFlowTheme.of(context).primary,
                        barWidth: 4.0,
                      ),
                    ]
                  : [
                      LineChartBarData(
                        spots: [FlSpot(0, 0)],
                        isCurved: true,
                        color: FlutterFlowTheme.of(context).primary,
                        barWidth: 2.0,
                      )
                    ],
              gridData: FlGridData(
                show: true,
                // 顯示網格
                drawVerticalLine: true,
                // 繪製垂直網格線
                drawHorizontalLine: true,
                // 繪製水平網格線
                verticalInterval: 1,
                // 垂直網格線之間的間隔
                horizontalInterval: 1,
                // 水平網格線之間的間隔
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey, // 網格線的顏色
                    strokeWidth: 1, // 網格線的寬度
                    dashArray: [5, 5], // 虛線的模式，這裡使用 5 個像素實線 + 5 個像素空白
                  );
                },
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setLineChartData() {
    lineChartData = []; // Clear the existing lineChartData

    for (var i = 0; i < dateKey.length; i++) {
      String date = dateKey[i];
      double x = i.toDouble();
      double y = dateCounter[date]?.toDouble() ?? 0;
      lineChartData.add(FlSpot(x, y));
    }
  }
}
