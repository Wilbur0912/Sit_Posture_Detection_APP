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
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  String selectedType = '日';
  Map<String, int> totalMinutesByDate = {};

  void changeDateAndChartType(
      {required DateTime start, DateTime? end, String? type}) {
    if (type != null) {
      setState(() {
        startDate = start;
        endDate = end;
        selectedType = type;
      });
    } else {
      setState(() {
        startDate = start;
        endDate = end;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnalyzationModel());
    userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    Future.delayed(Duration(milliseconds: 100), () {
      _fetchSitRecordData();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _onTabClick(String type) {
    DateTime s = DateTime.now();
    DateTime? e;
    final DateTime today = DateTime.now();

    switch (type) {
      case "日":
        s = today.subtract(const Duration(days: 7));
        e = today;
        break;
      case '周':
        s = today.subtract(const Duration(days: 28));
        e = today;
        break;
      case '月':
        s = today.subtract(const Duration(days: 365));
        e = today;
        break;
      case '年':
        s = today.subtract(const Duration(days: 3650));
        e = today;
        break;
    }
    changeDateAndChartType(start: s, end: e, type: type);
  }

  Future<void> _fetchSitRecordData() async {
    String sDate = DateFormat("yyyy-MM-dd").format(startDate);
    String? eDate;
    if (endDate != null) {
      DateTime tmp = endDate!;
      eDate = DateFormat("yyyy-MM-dd").format(tmp);
      print(eDate);
    }
    final res = await AnalyzationManager.getSitRecord(
        userProfileProvider.userProfile?.username, sDate, eDate);
    final List<SitRecord> fetchedSitRecordList =
        SitRecordFromResponse(res.data);
    totalMinutesByDate = calculateTotalMinutesByDate(fetchedSitRecordList);
    sitRecordList = fetchedSitRecordList; // 賦值給 SitRecordList 變數
  }

  Map<String, int> calculateTotalMinutesByDate(List<SitRecord> records) {
    Map<String, int> totalMinutesMap = {};
    for (var record in records) {
      String date = DateFormat('yyyy-MM-dd').format(record.time);
      totalMinutesMap[date] = (totalMinutesMap[date] ?? 0) + record.minutes;
    }
    return totalMinutesMap;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    double totalMinutes = ((sitRecordList.fold<int>(
                0,
                (previousValue, sitRecord) =>
                    previousValue + sitRecord.minutes)) /
            60)
        .roundToDouble();
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
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: Column(
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
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 100.0, 0.0),
                    child: Text(
                      '資料統計',
                      textAlign: TextAlign.center,
                      style:
                          FlutterFlowTheme.of(context).displayMedium.override(
                                fontFamily: 'Roboto',
                                fontSize: 45.0,
                                letterSpacing: 0.2,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0), //上下左右的填充
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(48.0, 4.0, 48.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '統計總共',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Rubik',
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
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                        fontSize: 36.0,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 0.0, 0.0, 6.0),
                                  child: Text(
                                    '小時',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
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
                              '總計平均',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Rubik',
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
                                  '${averageMinutes >= 1 ? averageMinutes : "<1.0"}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        color: Colors.white,
                                        fontSize: 36.0,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 0.0, 0.0, 6.0),
                                  child: Text(
                                    '小時',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
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
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '每$selectedType不良姿勢統計',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Rubik',
                                      fontSize: 16.0,
                                    ),
                              ),
                              Container(
                                width: 100.0,
                                height: 42.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 2.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: selectedType,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'Rubik',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.2,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        dropdownColor: Colors.blue,
                                        onChanged: (String? newValue) {
                                          // Change the callback argument type
                                          if (newValue != null) {
                                            setState(() {
                                              _onTabClick(newValue);
                                              _fetchSitRecordData();
                                              print('$endDate and $startDate');
                                            });
                                          }
                                        },
                                        items: <String>['日', '周', '月', '年']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        icon: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: FlutterFlowTheme.of(context)
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Timeline',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Rubik',
                                      fontSize: 16.0,
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
                          width: 286.6,
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
                                  int totalMinutes = entry.value;
                                  double totalHours = totalMinutes / 60.0;

                                  // Filter SitRecord objects for the current date
                                  List<SitRecord> recordsForDate = sitRecordList
                                      .where((record) =>
                                          DateFormat('yyyy-MM-dd')
                                              .format(record.time) ==
                                          date)
                                      .toList();

                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(24.0),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        totalHours
                                                            .toStringAsFixed(1),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Rubik',
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
                                                          '小時',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Rubik',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                fontSize: 12.0,
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
                                                    DateFormat('dd MMM yyyy')
                                                        .format(DateTime.parse(
                                                            date)),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Rubik',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        25.0, 0.0, 0.0, .0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: recordsForDate
                                                      .map((record) {
                                                    return Text(
                                                      '${record.position} : ${(record.minutes / 60).toStringAsFixed(1)}小時',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .displayMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 15.0,
                                                            letterSpacing: 0.2,
                                                            color: Colors.grey,
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
    );
  }
}
