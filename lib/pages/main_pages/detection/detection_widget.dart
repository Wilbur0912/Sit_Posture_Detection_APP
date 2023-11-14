import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/io.dart';

import '../../../manager/AnalyzationManager.dart';
import '../../../userProfileProvider.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'detection_model.dart';
import 'package:http/http.dart' as http;
import 'imageHashMap.dart';

import 'dataItem.dart';
export 'detection_model.dart';


class DetectionWidget extends StatefulWidget {
  const DetectionWidget({Key? key}) : super(key: key);

  @override
  _DetectionWidgetState createState() => _DetectionWidgetState();
}

class _DetectionWidgetState extends State<DetectionWidget>
    with TickerProviderStateMixin {
  late DetectionModel _model;
  String currentPostureName = '坐姿端正'; // 初始文字
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'columnOnPageLoadAnimation1': AnimationInfo(
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
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
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
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation3': AnimationInfo(
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
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetectionModel());
    sortAndMoveToTop(yourItemList, currentPostureName);
    final userProfileProvider =
    Provider.of<UserProfileProvider>(context, listen: false);
    // 監聽WebSocket消息
    sendNotification();
    final channel = IOWebSocketChannel.connect(
      'ws://https://spineinspectorbackend-production.up.railway.app//inspect/',
      headers: {'token': userProfileProvider.userProfile?.token},);
    channel.stream.listen((message) {
      // 當接收到新消息時，更新文字
      setState(() {
        currentPostureName = message;
        if (currentPostureName == "") {
          currentPostureName = '坐姿端正';
        }

        sendNotification();

        //fetch資料，將資料整理到dataItem裡
        fetchDataList(userProfileProvider.userProfile?.token);
      });
    });
  }

  // Future<void> fetchDataList() async {
  //   final DateTime now = DateTime.now();
  //   final String user = 'weber';
  //   final String formattedDate = DateFormat('yyyy/M/d').format(now);
  //   final response = await http.get(
  //     Uri.parse('http://172.20.10.2:8080/getTodayDataList?date=$formattedDate'),
  //     headers: {'Cookie': 'user_name=$user'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> responseData = json.decode(response.body);
  //
  //     setState(() {
  //       yourItemList = responseData.map((itemData) {
  //         return YourDataItem(itemData['name'], itemData['minutes']);
  //       }).toList();
  //       sortAndMoveToTop(yourItemList, currentPostureName);
  //     });
  //   }
  // }
  Future<void> sendNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      channelDescription: 'your_channel_description',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // 通知的唯一 ID
      '正常坐姿', // 通知的標題
      '您的坐姿是正常的', // 通知的内容
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
  Future<void> fetchDataList(String? token) async {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-M-d').format(now);

    final response = await AnalyzationManager.getSitRecord(
        token, formattedDate, formattedDate);

    if (response.isSuccess && response.data is List<dynamic>) {
      final List<dynamic> responseData = response.data;

      setState(() {
        yourItemList = responseData.map((itemData) {
          return YourDataItem(itemData['position'], itemData['second']);
        }).toList();
        sortAndMoveToTop(yourItemList, currentPostureName);
      });
    }
  }


  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 24.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.grey,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.pop();
                    },
                  ),
                  Text(
                    '即時監控',
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                      fontFamily: 'Outfit',
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 48.0,
                    icon: Icon(
                      Icons.more_vert_outlined,
                      color: Colors.grey,
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
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 275,
                    height: 450,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.00, 0.08),
                        end: Alignment(1, -0.08),
                        colors: [Color(0xFFA192FD), Color(0xFF9DCEFF)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x4CC58BF2),
                          blurRadius: 22,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],

                    ),
                    child: Column(

                      children: [
                        Padding(padding:
                        EdgeInsetsDirectional.fromSTEB(60.0, 40.0, 60.0, 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  callPostureImage(currentPostureName),
                                  width: 180.0,
                                  height: 235.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(
                              60.0, 12.0, 60.0, 20.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '目前您',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: currentPostureName,
                                  style: TextStyle(),
                                ),
                              ],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0.11,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Text(
                        //   ' ',
                        //   style: FlutterFlowTheme
                        //       .of(context)
                        //       .bodyMedium
                        //       .override(
                        //     fontFamily: 'Rubik',
                        //     color: FlutterFlowTheme
                        //         .of(context)
                        //         .primary,
                        //     fontSize: 14.0,
                        //     letterSpacing: 1.0,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            36.0, 0.0, 36.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                yourItemList.length, (index) {
                              final currentItem = yourItemList[index];

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                        child: Image.asset(
                                          callPostureImage(
                                              currentItem.position),
                                          width: 40.0,
                                          height: 40.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        currentItem.position,
                                        style: FlutterFlowTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        '${(currentItem.second / 60)
                                            .toStringAsFixed(1)} 分鐘',
                                        style: FlutterFlowTheme
                                            .of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 24.0,
                                    thickness: 1.0,
                                    color: Color(0xFFE9E9E9),
                                  ),
                                ],
                              ).animateOnPageLoad(
                                animationsMap['columnOnPageLoadAnimation1']!,
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            72.0, 20.0, 72.0, 60.0),
                        child: Container(
                          width: 200,
                          height: 60.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.00, 0.08),
                              end: Alignment(1, -0.08),
                              colors: [Color(0xFFA192FD), Color(0xFF9DCEFF)],
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed('analyzation');
                            },
                            text: '觀看統計資料',
                            options: FFButtonOptions(
                              width: double.infinity,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Colors.transparent,
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
