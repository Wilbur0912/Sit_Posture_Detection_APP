import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../manager/userProfileManager.dart';
import '../../../model/userModel.dart';
import '../../../userProfileProvider.dart';

Future<String?> inputDialog(BuildContext context, String lab,
    UserProfileProvider userProfileProvider) async {
  String inputData = '';

  String getTitle() {
    return '修改$lab';
  }

  TextInputType getKeyboardType() {
    return lab == '身高' || lab == '體重'
        ? TextInputType.number
        : TextInputType.text;
  }

  void handleInput(String value) {
    inputData = value;
  }

  void updateUserProfile(UserProfile newUserProfile) async {
    if (lab == '密碼' || lab == '帳號名稱') {
      await UserProfileManager().updateUser(newUserProfile.copyWith());
    } else {
      await UserProfileManager().updateUserprofile(newUserProfile.copyWith());
    }
    userProfileProvider.updateUserProfile(newUserProfile);
    Navigator.of(context).pop(inputData);
  }

  Widget buildAlertDialog(BuildContext context) {
    if (lab == '性別') {
      return GenderDialog(lab: lab, userProfileProvider: userProfileProvider);
    } else {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Center(
            child: Text(
          getTitle(),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Poppins',
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
        )),
        content: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12.0,
                      color: FlutterFlowTheme.of(context).gray200,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: TextField(
                  keyboardType: getKeyboardType(),
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: '請輸入$lab',
                    hintStyle: FlutterFlowTheme.of(context).bodySmall.override(
                          color: Colors.grey,
                          fontFamily: 'Lato',
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Rubik',
                        color: Colors.grey,
                      ),
                  onChanged: handleInput,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
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
                onPressed: () {
                  UserProfile newUserProfile = userProfileProvider.userProfile!;

                  switch (lab) {
                    case '身高':
                      newUserProfile = newUserProfile.copyWith(
                          height: int.tryParse(inputData));
                      break;
                    case '體重':
                      newUserProfile = newUserProfile.copyWith(
                          weight: int.tryParse(inputData) ?? 88);
                      break;
                    case '密碼':
                      newUserProfile =
                          newUserProfile.copyWith(password: inputData);
                      break;
                    case '帳號名稱':
                      newUserProfile =
                          newUserProfile.copyWith(username: inputData);
                      break;
                    // '性別' 会在上面的 if 分支处理，不需要在这里再处理一次
                  }

                  updateUserProfile(newUserProfile);
                },
                text: '送出',
                options: FFButtonOptions(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
          )

          // TextButton(
          //   child: Text('送出'),
          //   onPressed: () {
          //     UserProfile newUserProfile = userProfileProvider.userProfile!;
          //
          //     switch (lab) {
          //       case '身高':
          //         newUserProfile = newUserProfile.copyWith(
          //             height: int.tryParse(inputData));
          //         break;
          //       case '體重':
          //         newUserProfile = newUserProfile.copyWith(
          //             weight: int.tryParse(inputData) ?? 88);
          //         break;
          //       case '密碼':
          //         newUserProfile = newUserProfile.copyWith(password: inputData);
          //         break;
          //       case '帳號名稱':
          //         newUserProfile = newUserProfile.copyWith(username: inputData);
          //         break;
          //     // '性別' 会在上面的 if 分支处理，不需要在这里再处理一次
          //     }
          //
          //     updateUserProfile(newUserProfile);
          //   },
          // ),
        ],
      );
    }
  }

  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: buildAlertDialog,
  );
}

class GenderDialog extends StatefulWidget {
  final String lab;
  final UserProfileProvider userProfileProvider;

  GenderDialog({required this.lab, required this.userProfileProvider});

  @override
  _GenderDialogState createState() => _GenderDialogState();
}

class _GenderDialogState extends State<GenderDialog> {
  String? selectedGender;

  void updateUserProfile(UserProfile newUserProfile) async {
    widget.userProfileProvider.updateUserProfile(newUserProfile);
    await UserProfileManager().updateUserprofile(newUserProfile.copyWith());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
            '修改${widget.lab}',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Poppins',
              color: Colors.black45,
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RadioListTile<String>(
            title: Text('男'),
            value: 'Male',
            groupValue: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('女'),
            value: 'Female',
            groupValue: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
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
              onPressed: () {
                if (selectedGender != null) {
                  UserProfile newUserProfile =
                  widget.userProfileProvider.userProfile!;
                  newUserProfile = newUserProfile.copyWith(gender: selectedGender!);
                  updateUserProfile(newUserProfile);
                  print('完成');
                  Navigator.of(context).pop(selectedGender); // 返回选中的性别
                }
              },
              text: '送出',
              options: FFButtonOptions(
                width: double.infinity,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
        )

      ],
    );
  }
}
