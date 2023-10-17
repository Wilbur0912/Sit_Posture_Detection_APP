import 'package:appp3/pages/main_pages/settings/setting_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../userProfileProvider.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'settings_model.dart';
export 'settings_model.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late SettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 10.0),
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
                  color: FlutterFlowTheme.of(context).gray600,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              Text(
                '設定',
                style: TextStyle(
                  color: Color(0xFF1D1517),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,

                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 16.0, 0.0),
                child: Container(
                  width: 44.0,
                  height: 44.0,

                ),
              ),
            ],
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 1.0),
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 1.0),
                  child:Stack(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Color(0x4D9489F5),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 500),
                                    fadeOutDuration: Duration(milliseconds: 500),
                                    imageUrl: 'https://picsum.photos/seed/934/600',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(70.0, 0.0, 0.0, 0.0),
                          child:Column(
                                      children: [
                                        Container(
                                          width: 73,
                                          height: 44,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 10,
                                                child: Text(
                                                  '${userProfileProvider.userProfile!.username}',
                                                    style: GoogleFonts.poppins(
                                                      textStyle:TextStyle(
                                                        color: Color(0xFF1D1517),
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   left: 0,
                                              //   top: 26,
                                              //   child: Text(
                                              //     '${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                                              //     style: GoogleFonts.poppins(
                                              //       textStyle:TextStyle(
                                              //         color: Color(0xFF7B6F72),
                                              //         fontSize: 14,
                                              //       ),
                                              //     )
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                          ],
                        ),
                  ), //使用者名稱
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 24.0, 1.0),
                      child:Stack(
                        children: [
                          Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 1.0),
                              child:
                                  Container(
                                      width: 85,
                                      height: 70,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x111D1617),
                                            blurRadius: 40,
                                            offset: Offset(0, 10),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                    child:Stack(
                                        alignment: Alignment.center,
                                        children:[
                                          Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            '${userProfileProvider.userProfile!.height}cm',

                                            style: GoogleFonts.poppins(
                                              textStyle:TextStyle(
                                                color: Color(0xFFA192FD),
                                                fontSize: 16,
                                                height: 0.11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                            child: Text(
                                              '身高',
                                              style: TextStyle(
                                                color: Color(0xFF7B6F72),
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ),
                                        ]

                                    ),
                                  )
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(137.0, 0.0, 0.0, 1.0),
                              child:
                              Container(
                                width: 85,
                                height: 70,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x111D1617),
                                      blurRadius: 40,
                                      offset: Offset(0, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),

                                child:Stack(
                                    alignment: Alignment.center,
                                    children:[
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                        child: Text(
                                          '${userProfileProvider.userProfile!.weight}kg',

                                          style: GoogleFonts.poppins(
                                            textStyle:TextStyle(
                                              color: Color(0xFFA192FD),
                                              fontSize: 16,
                                              height: 0.11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                        child: Text(
                                          '體重',
                                          style: TextStyle(
                                            color: Color(0xFF7B6F72),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.12,
                                          ),
                                        ),
                                      ),
                                    ]

                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(250.0, 0.0, 0.0, 1.0),
                              child:
                              Container(
                                width: 85,
                                height: 70,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x111D1617),
                                      blurRadius: 40,
                                      offset: Offset(0, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child:Stack(
                                    alignment: Alignment.center,
                                    children:[

                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                        child: Text(
                                          '性別',
                                          style: TextStyle(
                                            color: Color(0xFF7B6F72),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0.12,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                        child: Text(
                                          '${userProfileProvider.userProfile!.gender == 'Male' ? '男' : '女'} ',

                                          style: GoogleFonts.poppins(
                                            textStyle:TextStyle(
                                              color: Color(0xFFA192FD),
                                              fontSize: 16,
                                              height: 0.11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]

                                ),
                              )
                          ),

                        ],
                      )
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 1.0),
                      child: Container(
                        width: 325,
                        height: 320,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x111D1617),
                              blurRadius: 40,
                              offset: Offset(0, 10),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 0.0, 20.0),
                                child:
                                Text(
                                  '修改資料',
                                  style: TextStyle(
                                    color: Color(0xFF1D1517),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0.09,
                                  ),
                                )
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 1.0),
                              child:
                              Container(
                                width: 280,
                                height: 30,
                                child: InkWell(
                                  onTap: () async {
                                    final String? inputData = await inputDialog(
                                        context, "帳號名稱", userProfileProvider);
                                    print("你輸入：$inputData");
                                  },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(00.0, 0.0, 0.0, 1.0),
                                      child:SvgPicture.asset(
                                        'assets/images/Icon-Profile.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 1.0),
                                      child:Text(
                                        '帳號名稱',
                                        style: GoogleFonts.poppins(
                                          textStyle:TextStyle(
                                            color: Color(0xFF7B6F72),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(250.0, 5.0, 0.0, 1.0),
                                      child:Container(
                                        width: 18,
                                        height: 18,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF606A85),
                                          size: 15.0,
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 1.0),
                              child:
                              Container(
                                width: 280,
                                height: 30,
                                child: InkWell(
                                  onTap: () async {
                                    final String? inputData = await inputDialog(
                                        context, "密碼", userProfileProvider);
                                    print("你輸入：$inputData");
                                  },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(00.0, 0.0, 0.0, 1.0),
                                      child:SvgPicture.asset(
                                        'assets/images/Icon-password.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 1.0),
                                      child:Text(
                                        '密碼',
                                        style: GoogleFonts.poppins(
                                          textStyle:TextStyle(
                                            color: Color(0xFF7B6F72),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(250.0, 5.0, 0.0, 1.0),
                                      child:Container(
                                        width: 18,
                                        height: 18,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF606A85),
                                          size: 15.0,
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 1.0),
                              child:
                              Container(
                                width: 280,
                                height: 30,
                                child:InkWell(
                                  onTap: () async {
                                    final String? inputData = await inputDialog(
                                        context, "身高", userProfileProvider);
                                    print("你輸入：$inputData");
                                  },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(00.0, 0.0, 0.0, 1.0),
                                      child:SvgPicture.asset(
                                        'assets/images/height.svg', // 替换为你的 SVG 图像文件路径
                                        width: 20, // 设置图像宽度
                                        height: 20, // 设置图像高度
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 1.0),
                                      child:Text(
                                        '身高',
                                        style: GoogleFonts.poppins(
                                          textStyle:TextStyle(
                                            color: Color(0xFF7B6F72),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(250.0, 0.0, 0.0, 1.0),
                                      child:Container(
                                        width: 18,
                                        height: 18,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF606A85),
                                          size: 15.0,
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 1.0),
                              child:
                              Container(
                                width: 280,
                                height: 30,
                                child:InkWell(
                                  onTap: () async {
                                    final String? inputData = await inputDialog(
                                        context, "體重", userProfileProvider);
                                    print("你輸入：$inputData");
                                  },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(00.0, 0.0, 0.0, 1.0),
                                      child:SvgPicture.asset(
                                        'assets/images/weight.svg', // 替换为你的 SVG 图像文件路径
                                        width: 20, // 设置图像宽度
                                        height: 20, // 设置图像高度
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 1.0),
                                      child:Text(
                                        '體重',
                                        style: GoogleFonts.poppins(
                                          textStyle:TextStyle(
                                            color: Color(0xFF7B6F72),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(250.0, 0.0, 0.0, 1.0),
                                      child:Container(
                                        width: 18,
                                        height: 18,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF606A85),
                                          size: 15.0,
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 1.0),
                              child:
                              Container(
                                width: 280,
                                height: 40,
                                child:InkWell(
                                  onTap: () async {
                                    final String? inputData = await inputDialog(
                                        context, "性別", userProfileProvider);
                                    print("你輸入：$inputData");
                                  },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(00.0, 0.0, 0.0, 1.0),
                                      child:SvgPicture.asset(
                                        'assets/images/Gender.svg', // 替换为你的 SVG 图像文件路径
                                        width: 20, // 设置图像宽度
                                        height: 20, // 设置图像高度
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 1.0),
                                      child:Text(
                                        '性別',
                                        style: GoogleFonts.poppins(
                                          textStyle:TextStyle(
                                            color: Color(0xFF7B6F72),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(250.0, 0.0, 0.0, 1.0),
                                      child:Container(
                                        width: 18,
                                        height: 18,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF606A85),
                                          size: 15.0,
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                                ),
                              ),
                            ),



                          ],
                        ),
                      )
                  ),



                ]
              ),
          ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 1.0),
              //   child: Container(
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Color(0xFFF1F4F8),
              //       boxShadow: [
              //         BoxShadow(
              //           blurRadius: 0.0,
              //           color: Color(0xFFE5E7EB),
              //           offset: Offset(0.0, 1.0),
              //         )
              //       ],
              //     ),
              //     child: Padding(
              //       padding:
              //           EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 12.0),
              //       child: Text(
              //         '我的個資',
              //         style: FlutterFlowTheme.of(context).labelMedium.override(
              //               fontFamily: 'Plus Jakarta Sans',
              //               color: Color(0xFF606A85),
              //               fontSize: 14.0,
              //               fontWeight: FontWeight.w500,
              //             ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
              //   child: Container(
              //       width: double.infinity,
              //       height: 70.0,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             blurRadius: 0.0,
              //             color: Color(0xFFE5E7EB),
              //             offset: Offset(0.0, 1.0),
              //           )
              //         ],
              //         shape: BoxShape.rectangle,
              //       ),
              //       child: InkWell(
              //         onTap: () async {
              //           final String? inputData = await inputDialog(
              //               context, "身高", userProfileProvider);
              //           print("你輸入：$inputData");
              //         },
              //         child: Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(
              //               16.0, 0.0, 16.0, 0.0),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Row(
              //                 mainAxisSize: MainAxisSize.max,
              //                 children: [
              //                   Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           '身高',
              //                           style: FlutterFlowTheme.of(context)
              //                               .bodyLarge
              //                               .override(
              //                                 fontFamily: 'Plus Jakarta Sans',
              //                                 color: Color(0xFF15161E),
              //                                 fontSize: 16.0,
              //                                 fontWeight: FontWeight.w600,
              //                               ),
              //                         ),
              //                         Text(
              //                           '${userProfileProvider.userProfile!.height} cm',
              //                           style: FlutterFlowTheme.of(context)
              //                               .labelMedium
              //                               .override(
              //                                 fontFamily: 'Plus Jakarta Sans',
              //                                 color: Color(0xFF606A85),
              //                                 fontSize: 14.0,
              //                                 fontWeight: FontWeight.w500,
              //                               ),
              //                         ),
              //                       ]),
              //                   Expanded(
              //                       child: Align(
              //                     alignment: AlignmentDirectional(1.0, 0.0),
              //                     child: Icon(
              //                       Icons.arrow_forward_ios,
              //                       color: Color(0xFF606A85),
              //                       size: 20.0,
              //                     ),
              //                   )),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       )),
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
              //   child: Container(
              //       width: double.infinity,
              //       height: 70.0,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             blurRadius: 0.0,
              //             color: Color(0xFFE5E7EB),
              //             offset: Offset(0.0, 1.0),
              //           )
              //         ],
              //         shape: BoxShape.rectangle,
              //       ),
              //       child: InkWell(
              //         onTap: () async {
              //           final String? inputData = await inputDialog(
              //               context, "體重", userProfileProvider);
              //           print("你輸入：$inputData");
              //         },
              //         child: Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(
              //               16.0, 0.0, 16.0, 0.0),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Row(
              //                 mainAxisSize: MainAxisSize.max,
              //                 children: [
              //                   Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           '體重',
              //                           style: FlutterFlowTheme.of(context)
              //                               .bodyLarge
              //                               .override(
              //                                 fontFamily: 'Plus Jakarta Sans',
              //                                 color: Color(0xFF15161E),
              //                                 fontSize: 16.0,
              //                                 fontWeight: FontWeight.w600,
              //                               ),
              //                         ),
              //                         Text(
              //                           '${userProfileProvider.userProfile!.weight} kg',
              //                           style: FlutterFlowTheme.of(context)
              //                               .labelMedium
              //                               .override(
              //                                 fontFamily: 'Plus Jakarta Sans',
              //                                 color: Color(0xFF606A85),
              //                                 fontSize: 14.0,
              //                                 fontWeight: FontWeight.w500,
              //                               ),
              //                         ),
              //                       ]),
              //                   Expanded(
              //                     child: Align(
              //                       alignment: AlignmentDirectional(1.0, 0.0),
              //                       child: Icon(
              //                         Icons.arrow_forward_ios,
              //                         color: Color(0xFF606A85),
              //                         size: 20.0,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       )),
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
              //   child: Container(
              //       width: double.infinity,
              //       height: 70.0,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             blurRadius: 0.0,
              //             color: Color(0xFFE5E7EB),
              //             offset: Offset(0.0, 1.0),
              //           )
              //         ],
              //         shape: BoxShape.rectangle,
              //       ),
              //       child: InkWell(
              //         onTap: () async {
              //           final String? inputData = await inputDialog(
              //               context, "性別", userProfileProvider);
              //           print("你輸入：$inputData");
              //         },
              //         child: Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(
              //               16.0, 0.0, 16.0, 0.0),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Row(
              //                 mainAxisSize: MainAxisSize.max,
              //                 children: [
              //                   Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           '性別',
              //                           style: FlutterFlowTheme.of(context)
              //                               .bodyLarge
              //                               .override(
              //                                 fontFamily: 'Plus Jakarta Sans',
              //                                 color: Color(0xFF15161E),
              //                                 fontSize: 16.0,
              //                                 fontWeight: FontWeight.w600,
              //                               ),
              //                         ),
              //                         Text(
              //                           '${userProfileProvider.userProfile!.gender == 'Male' ? '男' : '女'} ',
              //                           style: FlutterFlowTheme.of(context)
              //                               .labelMedium
              //                               .override(
              //                                 fontFamily: 'Plus Jakarta Sans',
              //                                 color: Color(0xFF606A85),
              //                                 fontSize: 14.0,
              //                                 fontWeight: FontWeight.w500,
              //                               ),
              //                         ),
              //                       ]),
              //                   Expanded(
              //                     child: Align(
              //                       alignment: AlignmentDirectional(1.0, 0.0),
              //                       child: Icon(
              //                         Icons.arrow_forward_ios,
              //                         color: Color(0xFF606A85),
              //                         size: 20.0,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       )),
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
              //   child: Container(
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Color(0xFFF1F4F8),
              //       boxShadow: [
              //         BoxShadow(
              //           blurRadius: 0.0,
              //           color: Color(0xFFE5E7EB),
              //           offset: Offset(0.0, 1.0),
              //         )
              //       ],
              //     ),
              //     child: Padding(
              //       padding:
              //           EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 12.0),
              //       child: Text(
              //         '我的帳戶',
              //         style: FlutterFlowTheme.of(context).labelMedium.override(
              //               fontFamily: 'Plus Jakarta Sans',
              //               color: Color(0xFF606A85),
              //               fontSize: 14.0,
              //               fontWeight: FontWeight.w500,
              //             ),
              //       ),
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     Padding(
              //       padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
              //       child: Container(
              //           width: MediaQuery.sizeOf(context).width * 1.0,
              //           height: 70.0,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             boxShadow: [
              //               BoxShadow(
              //                 blurRadius: 0.0,
              //                 color: Color(0xFFE5E7EB),
              //                 offset: Offset(0.0, 1.0),
              //               )
              //             ],
              //             shape: BoxShape.rectangle,
              //           ),
              //           child: InkWell(
              //             onTap: () async {
              //               final String? inputData = await inputDialog(
              //                   context, "帳號名稱", userProfileProvider);
              //               print("你輸入：$inputData");
              //             },
              //             child: Padding(
              //               padding: EdgeInsetsDirectional.fromSTEB(
              //                   16.0, 0.0, 16.0, 0.0),
              //               child: Column(
              //                 mainAxisSize: MainAxisSize.max,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Row(
              //                     mainAxisSize: MainAxisSize.max,
              //                     children: [
              //                       Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             Text(
              //                               '使用者名稱',
              //                               style: FlutterFlowTheme.of(context)
              //                                   .bodyLarge
              //                                   .override(
              //                                     fontFamily:
              //                                         'Plus Jakarta Sans',
              //                                     color: Color(0xFF15161E),
              //                                     fontSize: 16.0,
              //                                     fontWeight: FontWeight.w600,
              //                                   ),
              //                             ),
              //                             Text(
              //                               '${userProfileProvider.userProfile!.username}',
              //                               style: FlutterFlowTheme.of(context)
              //                                   .labelMedium
              //                                   .override(
              //                                     fontFamily:
              //                                         'Plus Jakarta Sans',
              //                                     color: Color(0xFF606A85),
              //                                     fontSize: 14.0,
              //                                     fontWeight: FontWeight.w500,
              //                                   ),
              //                             ),
              //                           ]),
              //                       Expanded(
              //                         child: Align(
              //                           alignment:
              //                               AlignmentDirectional(1.0, 0.0),
              //                           child: Icon(
              //                             Icons.arrow_forward_ios,
              //                             color: Color(0xFF606A85),
              //                             size: 20.0,
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           )),
              //     ),
              //   ],
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
              //   child: Container(
              //       width: MediaQuery.sizeOf(context).width * 1.0,
              //       height: 70.0,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             blurRadius: 0.0,
              //             color: Color(0xFFE5E7EB),
              //             offset: Offset(0.0, 1.0),
              //           )
              //         ],
              //         shape: BoxShape.rectangle,
              //       ),
              //       child: InkWell(
              //         onTap: () async {
              //           final String? inputData = await inputDialog(
              //               context, "密碼", userProfileProvider);
              //           print("你輸入：$inputData");
              //         },
              //         child: Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(
              //               16.0, 0.0, 16.0, 0.0),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Row(
              //                 mainAxisSize: MainAxisSize.max,
              //                 children: [
              //                   Text(
              //                     '更改密碼',
              //                     style: FlutterFlowTheme.of(context)
              //                         .bodyLarge
              //                         .override(
              //                           fontFamily: 'Plus Jakarta Sans',
              //                           color: Color(0xFF15161E),
              //                           fontSize: 16.0,
              //                           fontWeight: FontWeight.w600,
              //                         ),
              //                   ),
              //                   Expanded(
              //                     child: Align(
              //                       alignment: AlignmentDirectional(1.0, 0.0),
              //                       child: Icon(
              //                         Icons.arrow_forward_ios,
              //                         color: Color(0xFF606A85),
              //                         size: 20.0,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       )),
              // ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        userProfileProvider.clearUserProfileFromSharedPreferences();
                        context.pushNamed('LoginPage');
                      },
                      text: '登出',
                      options: FFButtonOptions(
                        width: 130.0,
                        height: 50.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Colors.white,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF606A85),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Color(0xFFE5E7EB),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


