// import 'dart:convert';

import '../../../generated/l10n.dart';
import '../../../manager/AnalyzationManager.dart';
import '../../../model/sitRecordModel.dart';
import '../../../userProfileProvider.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'analyzation_Chart.dart';
import 'analyzation_model.dart';
export 'analyzation_model.dart';

class AnalyzationWidget extends StatefulWidget {
  const AnalyzationWidget({Key? key}) : super(key: key);

  @override
  _AnalyzationWidgetState createState() => _AnalyzationWidgetState();
}

class _AnalyzationWidgetState extends State<AnalyzationWidget>
    with TickerProviderStateMixin {
  late AnalyzationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late UserProfileProvider userProfileProvider;
  List<SitRecord> sitRecordList = [];
  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 5.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: Offset(0.0, 10.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: Offset(0.0, 10.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };
  DateTime endDate = DateTime.now();
  DateTime? startDate;
  String selectedType = S.current.day;
  Map<String, double> totalMinutesByDate = {};

  void changeDateAndChartType(
      {DateTime? start, required DateTime end, String? type}) {
    if (type != null) {
      setState(() {
        endDate = end;
        startDate = start;
        selectedType = type;
      });
    } else {
      setState(() {
        endDate = end;
        startDate = start;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnalyzationModel());
    userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    _fetchSitRecordData();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _onTabClick(String type) {
    DateTime e = DateTime.now();
    DateTime? s;
    final DateTime today = DateTime.now();

    if (type == S.of(context).day) {
      s = DateTime.now().subtract(const Duration(days: 6));
      e = DateTime.now();
    } else if (type == S.of(context).week) {
      s = DateTime.now().subtract(const Duration(days: 42));
      e = DateTime.now();
    } else if (type == S.of(context).month) {
      s = DateTime.now().subtract(const Duration(days: 364));
      e = DateTime.now();
    } else if (type == S.of(context).year) {
      s = DateTime.now().subtract(const Duration(days: 3649));
      e = DateTime.now();
    }
    changeDateAndChartType(start: s, end: e, type: type);
  }

  Future<void> _fetchSitRecordData() async {
    String eDate = DateFormat("yyyy-MM-dd").format(endDate);
    String sDate = DateFormat("yyyy-MM-dd")
        .format(DateTime.now().subtract(const Duration(days: 6)));
    if (startDate != null) {
      DateTime tmp = startDate!;
      sDate = DateFormat("yyyy-MM-dd").format(tmp);
      print(sDate);
    }
    final res = await AnalyzationManager.getSitRecord(
        userProfileProvider.userProfile?.token, sDate, eDate);
    final List<SitRecord> fetchedSitRecordList =
        SitRecordFromResponse(res.data);
    setState(() {
      totalMinutesByDate = calculateTotalMinutesByDate(fetchedSitRecordList);
      sitRecordList = fetchedSitRecordList;
      // 賦值給 SitRecordList 變數
    });
  }

  Map<String, double> calculateTotalMinutesByDate(List<SitRecord> records) {
    Map<String, double> totalMinutesMap = {};
    for (var record in records) {
      print(record.second);
      String date = DateFormat('yyyy-MM-dd').format(record.time);
      totalMinutesMap[date] =
          (totalMinutesMap[date] ?? 0) + (record.second / 60);
    }
    return totalMinutesMap;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    double totalMinutes = double.parse(((sitRecordList.fold<int>(
                0,
                (previousValue, sitRecord) =>
                    previousValue + sitRecord.second)) /
            3600)
        .toStringAsFixed(2));
    int totalDays = 0;
    for (SitRecord record in sitRecordList) {
      // 計算每個 time 的日期天數
      int daysInMonth =
          DateTime(record.time.year, record.time.month + 1, 0).day;
      int daysInYear = DateTime(record.time.year + 1, 1, 0)
          .difference(DateTime(record.time.year, 1, 0))
          .inDays;
      int daysInTenYears = DateTime(record.time.year + 10, 1, 0)
          .difference(DateTime(record.time.year, 1, 0))
          .inDays;

      // 根據不同時間間隔累加總天數
      totalDays += daysInMonth; // 月
      totalDays += daysInYear; // 年
      totalDays += daysInTenYears; // 十年
    }

    double averageMinutes = (totalMinutes / totalDays / 60).roundToDouble();
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
        child: Scaffold(
          key: scaffoldKey,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.00, 0.08),
                end: Alignment(1, -0.08),
                colors: [Color(0xFF9DCEFF), Color(0xFFA192FD)],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 1.0,
                        buttonSize: 48.0,
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          context.pop();
                        },
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        child: Center(
                          child: Text(
                            '${S.of(context).total_time}',
                            textAlign: TextAlign.center,
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Roboto',
                                      fontSize: 20.0,
                                      letterSpacing: 0.2,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 1.0,
                        buttonSize: 48.0,
                        icon: Icon(
                          Icons.more_vert_outlined,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                  //上下左右的填充
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            48.0, 4.0, 48.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${S.of(context).total_static}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        letterSpacing: 0.6,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '$totalMinutes',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 36.0,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 0.0, 6.0),
                                      child: Text(
                                        '${S.of(context).hour}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
                                              letterSpacing: 0.2,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${S.of(context).total_av}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        letterSpacing: 0.6,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 0.0, 5.0),
                                      child: Text(
                                        '${averageMinutes >= 1 ? "" : "${S.of(context).low_than} "}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
                                              fontSize: 25.0,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      '${averageMinutes >= 1 ? averageMinutes : "1"}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 36.0,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 0.0, 6.0),
                                      child: Text(
                                        '${S.of(context).hour}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
                                              letterSpacing: 0.2,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(36.0),
                          topRight: Radius.circular(36.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 24.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${S.of(context).every_awful(selectedType)}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      height: 0.09,
                                    ),
                                  ),
                                  Container(
                                    width: 100.0,
                                    height: 42.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(-1.00, 0.08),
                                        end: Alignment(1, -0.08),
                                        colors: [
                                          Color(0xFFA192FD),
                                          Color(0xFF9DCEFF)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 2.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          DropdownButton<String>(
                                            value: selectedType,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.white,
                                              letterSpacing: 0.2,
                                              fontWeight: FontWeight
                                                  .w700, // 設置 DropdownButton 的文本顏色
                                            ),
                                            underline: SizedBox(),
                                            onChanged: (String? newValue) {
                                              // Change the callback argument type
                                              if (newValue != null) {
                                                print('a');

                                                _onTabClick(newValue);
                                                _fetchSitRecordData();
                                                print(
                                                    '$startDate and $endDate');
                                              }
                                            },
                                            items: <String>['${S.of(context).day}', '${S.of(context).week}', '${S.of(context).month}', '${S.of(context).year}']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                    color: value == selectedType
                                                        ? Colors.white
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            icon: Icon(
                                              Icons.arrow_drop_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 0.0),
                                  child: Container(
                                    width: 300.0,
                                    height: 200.0,
                                    child: AnalysisChart(
                                      start: startDate,
                                      end: endDate,
                                      type: selectedType,
                                      SitRecordList: sitRecordList,
                                      // username: userProfileProvider.userProfile?.username,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 36.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${S.of(context).detail_record}',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                  ),
                                  Icon(
                                    Icons.keyboard_control_outlined,
                                    color: Color(0xFFE9E9E9),
                                    size: 24.0,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 300.6,
                              height: 300.0,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child: ListView(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    children:
                                        totalMinutesByDate.entries.map((entry) {
                                      String date = entry.key;
                                      double totalMinutes = entry.value;
                                      double totalHours = totalMinutes / 60.0;

                                      // Filter SitRecord objects for the current date
                                      List<SitRecord> recordsForDate =
                                          sitRecordList
                                              .where((record) =>
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(record.time) ==
                                                  date)
                                              .toList();

                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              225, 225, 225, 210),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            totalHours
                                                                .toStringAsFixed(
                                                                    1),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  fontSize:
                                                                      24.0,
                                                                ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        2.0,
                                                                        0.0,
                                                                        0.0,
                                                                        2.0),
                                                            child: Text(
                                                              '${S.of(context).hour}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        DateFormat(
                                                                'yyyy MM/dd ')
                                                            .format(
                                                                DateTime.parse(
                                                                    date)),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(40.0, 0.0,
                                                                0.0, .0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: recordsForDate
                                                          .map((record) {
                                                        return Text(
                                                          '${record.position} : ${(record.second / 3600).toStringAsFixed(2)}${S.of(context).hour}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .displayMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.2,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'containerOnPageLoadAnimation1']!);
                                    }).toList(),
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
