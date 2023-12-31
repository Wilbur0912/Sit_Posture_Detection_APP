import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/io.dart';

import '../../../generated/l10n.dart';
import '../../../manager/AnalyzationManager.dart';
import '../../../model/sitRecordModel.dart';
import '../../../model/userModel.dart';
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
  String currentPostureName = '${S.current.no_sit}'; // 初始文字
  String debugData = '';
  List<SitRecord> sitRecordList = [];
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
    fetchDataList(userProfileProvider.userProfile?.token);
    // 監聽WebSocket消息

    //connectToSocket(userProfileProvider.userProfile);
    final channel = IOWebSocketChannel.connect(
      'ws://spineinspectorbackend-production.up.railway.app/inspect/',
      headers: {'token': userProfileProvider.userProfile?.token, 'Deviceid': '1'});
    var counter = 0;
    channel.stream.listen((message) {
      counter++;
      counter %= 100;
      // 當接收到新消息時，更新文字
      setState(() {

        debugData = counter.toString();
        fetchDataList(userProfileProvider.userProfile?.token);
        if(currentPostureName != message) {
          sendNotification(message);
        }
        currentPostureName = message;
        //currentPostureName = message + ':' + counter;
        if (currentPostureName == "") {
          currentPostureName = '${S.current.Sit}:$counter';
        } else {
          print("socket received: " + message);
        }

        //sendNotification();
        fetchDataList(userProfileProvider.userProfile?.token);
        //fetch資料，將資料整理到dataItem裡

      });
    });

    /*
     */
  }

  Future<void> connectToSocket(UserProfile? userProfile) async {
    Random r = new Random();
    String key = base64.encode(List<int>.generate(16, (_) => r.nextInt(255)));

    HttpClient client = HttpClient();
    HttpClientRequest request = await client.getUrl(Uri.parse('https://spineinspectorbackend-production.up.railway.app/inspect/'));
    request.headers.add('connection', 'Upgrade');
    request.headers.add('upgrade', 'websocket');
    request.headers.add('Sec-WebSocket-Version', '13');
    request.headers.add('Sec-WebSocket-Key', key);
    request.headers.add('token', userProfile?.token as Object);
    request.headers.add('Deviceid', '1');
    HttpClientResponse response = await request.close();

    Socket socket = await response.detachSocket();

    WebSocket ws = WebSocket.fromUpgradedSocket(socket, serverSide: false);
    var counter = 0;

    ws.listen((message) {
      counter++;
      counter %= 100;
      // 當接收到新消息時，更新文字
      setState(() {
        currentPostureName = message + ':' + counter;
        if (currentPostureName == "") {
          currentPostureName = '${S.current.Sit}:$counter';
        } else {
          print("socket received: " + message);
        }
        // sendNotification(currentPostureName);
        //fetch資料，將資料整理到dataItem裡
        //fetchDataList(userProfileProvider.userProfile?.token);
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


  // Future<void> sendNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     importance: Importance.max,
  //     channelDescription: 'your_channel_description',
  //   );
  //
  //   const NotificationDetails platformChannelSpecifics =
  //   NotificationDetails(android: androidPlatformChannelSpecifics);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //     0, // 通知的唯一 ID
  //     '正常坐姿', // 通知的標題
  //     '您的坐姿是正常的', // 通知的内容
  //     platformChannelSpecifics,
  //     payload: 'Custom_Sound',
  //   );
  // }
  Future<void> sendNotification(String sittingPosture) async {
    // 獲取當前坐姿

    // 根據坐姿修改通知的標題和內容
    String title = "";
    String body = "";
    switch (sittingPosture) {
      case "坐姿端正":
        title = sittingPosture;
        body = "您的坐姿是正確的";
        break;
      case "翹左腳":
        title = "不正確坐姿";
        body = "您的坐姿不正確，請注意避免翹左腳";
        break;
      case "翹右腳":
        title = "不正確坐姿";
        body = "您的坐姿不正確，請注意避免翹右腳";
        break;
      case "三分之一坐姿":
        title = "不正確坐姿";
        body = "您的坐姿不正確，請往後坐，確保身體不會造成損傷";
        break;
      case "上半身左傾":
        title = "不正確坐姿";
        body = "您的坐姿不正確，請將上半身往右，請注意保持背部挺直";
        break;
      case "上半身右傾":
        title = "不正確坐姿";
        body = "您的坐姿不正確，請將上半身往左，注意保持背部挺直";
        break;
      case "駝背":
        title = "不正確坐姿";
        body = "您的坐姿不正確，請注意保持挺直";
        break;
      case "半躺半坐":
        title = "不正確坐姿";
        body = "您的坐姿不正確，請注意保持坐姿";
        break;
      case "盤腿":
        title = "不正確坐姿";
        body = "您的坐姿不正確，請注意避免盤腿";
        break;
      case "沒人坐":
        title = "未知坐姿";
        body = "未能識別坐姿";
        break;
      // default:
      //   title = "未知坐姿";
      //   body = "未知坐姿";
      //   break;
    }

    // 發送通知
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
      title, // 通知的標題
      body, // 通知的内容
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
  Future<void> fetchDataList(String? token) async {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-M-d').format(now);

    final response = await AnalyzationManager.getSitRecord(
        token, formattedDate, formattedDate);
    print(formattedDate);
    if (response.isSuccess) {
      final List<SitRecord> fetchedSitRecordList = SitRecordFromResponse(response.data);
      setState(() {
        sitRecordList = fetchedSitRecordList;
      });
    }
  }


  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  String translatepose(String pose){
    String word = "";
    if(pose == '翹左腳'){
      word = S.current.Left_foot;
    }else if(pose == '翹右腳'){
      word = S.current.right_foot;
    }else if(pose == "三分之一坐姿"){
      word = S.current.One_third;
    }else if(pose == "上半身右傾"){
      word = S.current.Upper_right;
    }else if(pose == "上半身左傾"){
      word = S.current.Upper_left;
    }else if(pose == "駝背"){
      word = S.current.Hunchback;
    }else if(pose == "半躺半坐"){
      word = S.current.half_lying;
    }else if(pose == "坐姿端正"){
      word = S.current.Sit;
    }else if(pose == "盤腿"){
      word = S.current.Cross_Legged;
    }else if(pose == "沒人坐"){
      word = S.current.no_sit;
    }else if(pose == '正常坐姿'){
      word = S.current.Sit;
    }else{
      word = pose;
    }
      return word;
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
                    '${S.of(context).realtime}',
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
                    height: 250,
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
                                  width: 70.0,
                                  height: 100.0,
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
                          child:

                          Text(
                            '${S.of(context).now}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0.11,
                            ),
                          ),

                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(
                              60.0, 12.0, 60.0, 20.0),
                          child:

                          Text(
                            currentPostureName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0.11,
                            ),
                          ),

                        ),
                        Padding(padding: EdgeInsetsDirectional.fromSTEB(
                            60.0, 1, 60.0, 1),
                          child:
                            Text(debugData),

                        )
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
                                sitRecordList.length, (index) {
                              final currentItem = sitRecordList[index];

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
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) =>
                                              Text(''),
                                          // Text('Error loading image: ${error.toString()}'),
                                        ),
                                      ),
                                      Text(
                                        translatepose(currentItem.position),
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
                                            .toStringAsFixed(1)} ${S.of(context).min}',
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
                            text: '${S.of(context).see_static}',
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
