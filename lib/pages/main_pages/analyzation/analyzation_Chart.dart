import 'dart:math';

import 'package:appp3/model/sitRecordModel.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../flutter_flow/flutter_flow_charts.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';

import '../../../generated/l10n.dart';
import 'analyzationUtil.dart';

class AnalysisChart extends StatefulWidget {
  final DateTime end;
  final DateTime? start;
  final String type;

  // String? username;
  final List<SitRecord> SitRecordList;

  AnalysisChart({
    Key? key,
    required this.end,
    this.start,
    required this.type,
    // this.username,
    required this.SitRecordList,
  }) : super(key: key);

  @override
  State<AnalysisChart> createState() => _AnalysisChartState();
}

class _AnalysisChartState extends State<AnalysisChart> {
  Map<String, double> dateCounter = {};
  List<String> dateKey = [];
  List<FlSpot> lineChartData = [];
  double maxCount = 0;

  @override
  void didUpdateWidget(covariant AnalysisChart oldWidget) {
    _onDateChange();
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _onDateChange() async {
    // String endDate = DateFormat("yyyy-MM-dd").format(widget.end);
    String? startDate;
    if (widget.start != null) {
      DateTime tmp = widget.start!;
      startDate = DateFormat("yyyy-MM-dd").format(tmp);
      print(startDate);
    }
    // if (widget.username != null) {
    //   final res = await AnalyzationManager.getSitRecord(
    //       widget.username, endDate, startDate);
    //   final List<SitRecord> SitRecordList = SitRecordFromResponse(res.data);
    final List<SitRecord> SitRecordList = widget.SitRecordList;
    SitRecordList.sort((a, b) => a.time.compareTo(b.time));
    dateKey = [];
    dateCounter = {};
    lineChartData = [];
    if (widget.type == S.of(context).day) {
      for (int i = 6; i >= 0; i--) {
        String interval = DateFormat("MM/dd").format(DateTime.now().subtract(Duration(days: i)));
        dateCounter[interval] = 0;
        dateKey.add(interval);
      }
    }
    else if(widget.type == S.of(context).week){
      for (int i = 42; i > 0; i=i-7) {
        String interval =
        "${DateFormat("MM/dd").format(widget.end.subtract(Duration(days: i)))}";
        print(interval);
        dateCounter[interval] = 0;
        dateKey.add(interval);
      }
    }
    else if(widget.type == S.of(context).year){
      for (int i = 1825; i >= 0; i=i-365) {
        String interval =
            "${DateFormat("yyyy").format(widget.end.subtract(Duration(days: i)))}";
        dateCounter[interval] = 0;
        dateKey.add(interval);
      }}else if(widget.type == S.of(context).month){
      for (int i = 1; i <= 12; i=i+1) {
        String interval="";
        if(i<10){
           interval =
              "0$i";
        }else{
           interval =
              "$i";
        }
        print(i);
        dateCounter[interval] = 0;
        dateKey.add(interval);
      }}

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
      if (widget.type == S.of(context).day) {
        interval = DateFormat("MM/dd").format(sitTime);
      } else if (widget.type == S.of(context).week) {
        DateTime p1 = widget.end; // 開始時間
        DateTime p2 = p1.subtract(const Duration(days: 7)); // 加7天得到下一個時間點
        DateTime p3 = p2.subtract(const Duration(days: 7));
        DateTime p4 = p3.subtract(const Duration(days: 7));
        DateTime p5 = p4.subtract(const Duration(days: 7));
        DateTime p6 = p5.subtract(const Duration(days: 7));
        DateTime p7 = p6.subtract(const Duration(days: 7));
        print('test1$sitTime');

        if (isDateInRange(sitTime, p2, p1)) {
          interval =
          "${DateFormat("MM/dd").format(p2)}";
          print('$interval aaa');
        } else if (isDateInRange(sitTime, p3, p2)) {
          interval =
          "${DateFormat("MM/dd").format(p3)}";
        } else if (isDateInRange(sitTime, p4, p3)) {
          interval =
          "${DateFormat("MM/dd").format(p4)}";
        } else if (isDateInRange(sitTime, p5, p4)) {
          interval =
          "${DateFormat("MM/dd").format(p5)}";
        }else if (isDateInRange(sitTime, p6, p5)) {
          interval =
          "${DateFormat("MM/dd").format(p6)}";
        }else if (isDateInRange(sitTime, p7, p6)) {
          interval =
          "${DateFormat("MM/dd").format(p7)}";
          print('$p7 is ok');
        }else{
          print('false');
        }
      } else if (widget.type == S.of(context).month) {
        interval = DateFormat("MM").format(sitTime);
      } else if (widget.type == S.of(context).year) {
        interval = DateFormat("yyyy").format(sitTime);
      }
      print('${SitRecordList[i].second/3600}');
      if (dateCounter.containsKey(interval)) {
        dateCounter[interval] = (dateCounter[interval] ?? 0) + (SitRecordList[i].second/3600);
      }
      // else {
      //   dateCounter[interval] = SitRecordList[i].second/3600;
      //   dateKey.add(interval);
      // }

    }
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    if (dateKey.isEmpty) return Container();
    String text = dateKey[value.toInt()];

    // if (widget.type == S.of(context).month) {
    //   text += " ${S.of(context).month}";
    // } else if (widget.type == S.of(context).year) {
    //   text += " ${S.of(context).year}";
    // }
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
      fontSize: 10,
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
              maxY: maxCount * 1.2,
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
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              lineBarsData: lineChartData.isNotEmpty
                  ? [
                      LineChartBarData(
                        spots: lineChartData,
                        // 資料點的列表
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
                horizontalInterval: 3,
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
