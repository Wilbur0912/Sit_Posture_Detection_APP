import '../../../generated/l10n.dart';
import '../../../userProfileProvider.dart';
import '/flutter_flow/flutter_flow_animations.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'gender_selection_model.dart';
export 'gender_selection_model.dart';

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({Key? key}) : super(key: key);

  @override
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget>
    with TickerProviderStateMixin {
  late GenderSelectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMale = true;
  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, -80.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GenderSelectionModel());
  }

  void updateGender(bool gender) {
    final userProfileProvider = context.read<UserProfileProvider>();
    final newUserProfile = userProfileProvider.userProfile?.copyWith(
      gender: gender ? 'Male' : 'Female',
    );
    userProfileProvider.updateUserProfile(newUserProfile!);
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
          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          body: SafeArea(
            top: true,
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      percent: 0.66,
                      width: 120.0,
                      lineHeight: 8.0,
                      animation: true,
                      progressColor: Color(0xFF7165E3),
                      backgroundColor: Color(0xFFE9E9E9),
                      barRadius: Radius.circular(12.0),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${S.of(context).step}',
                            style: GoogleFonts.getFont(
                              'Rubik',
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                          TextSpan(
                            text: '3',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: '/',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: '5',
                            style: TextStyle(),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Rubik',
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(96.0, 12.0, 96.0, 0.0),
                      child: Text(
                        '${S.of(context).you_gender}',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Rubik',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 6.0, 0.0, 6.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMale = true;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Container(
                                    width: 156.0,
                                    height: 216.0,
                                    decoration: BoxDecoration(
                                      color: isMale
                                          ? Color(0xFF9DCEFF)
                                          : Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 24.0,
                                          color: Color(0x0D000000),
                                          offset: Offset(0.0, 0.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 16.0, 16.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${S.of(context).male}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Rubik',
                                                  color: !isMale
                                                      ? Color(0xFF9DCEFF)
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMale = false;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Container(
                                    width: 156.0,
                                    height: 216.0,
                                    decoration: BoxDecoration(
                                      color: !isMale
                                          ? Color(0xFF9DCEFF)
                                          : Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 24.0,
                                          color: Color(0x0D000000),
                                          offset: Offset(0.0, 0.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 16.0, 16.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${S.of(context).female}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Rubik',
                                                  color: isMale
                                                      ? Color(0xFF9DCEFF)
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 72.0),
                          child: SvgPicture.asset(
                            'assets/images/love.svg',
                            height: 220.0,
                            fit: BoxFit.cover,
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsetsDirectional.fromSTEB(0.0, 38.0, 0.0, 0.0),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.max,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(
              //               84.0, 0.0, 84.0, 0.0),
              //           child: Text(
              //             '藉由性別我們能更準確地\n偵測您的坐姿',
              //             textAlign: TextAlign.center,
              //             style:
              //                 FlutterFlowTheme.of(context).bodyMedium.override(
              //                       fontFamily: 'Rubik',
              //                       letterSpacing: 0.2,
              //                       color: Colors.grey,
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding:
                    EdgeInsetsDirectional.fromSTEB(72.0, 100.0, 72.0, 50.0),
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
                      updateGender(isMale);
                      context.pushNamed(
                        'WeightEntry',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                          ),
                        },
                      );
                    },
                    text: '${S.of(context).next_step}',
                    options: FFButtonOptions(
                      width: double.infinity,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                ),
              ),
            ]),
          ),
        ));
  }
}
