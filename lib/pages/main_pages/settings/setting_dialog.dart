import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    await UserProfileManager()
        .updateUserDataToBackend(newUserProfile.copyWith());
    userProfileProvider.updateUserProfile(newUserProfile);
    Navigator.of(context).pop(inputData);
  }

  Widget buildAlertDialog(BuildContext context) {
    if (lab == '性別') {
      return GenderDialog(lab: lab, userProfileProvider: userProfileProvider);
    } else {
      return AlertDialog(
        title: Text(getTitle()),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: getKeyboardType(),
                autofocus: true,
                decoration: InputDecoration(hintText: '請輸入$lab'),
                onChanged: handleInput,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('送出'),
            onPressed: () {
              UserProfile newUserProfile = userProfileProvider.userProfile!;

              switch (lab) {
                case '身高':
                  newUserProfile = newUserProfile.copyWith(
                      height: double.tryParse(inputData) ?? 88);
                  break;
                case '體重':
                  newUserProfile = newUserProfile.copyWith(
                      weight: double.tryParse(inputData) ?? 88);
                  break;
                case '密碼':
                  newUserProfile = newUserProfile.copyWith(password: inputData);
                  break;
                case '使用者名稱':
                  newUserProfile = newUserProfile.copyWith(username: inputData);
                  break;
              // '性別' 会在上面的 if 分支处理，不需要在这里再处理一次
              }

              updateUserProfile(newUserProfile);
            },
          ),
        ],
      );
    }
  }

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
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
    //await UserProfileManager().updateUserDataToBackend(newUserProfile.copyWith());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('修改${widget.lab}'),
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
        TextButton(
          child: Text('送出'),
          onPressed: () {
            if (selectedGender != null) {
              UserProfile newUserProfile = widget.userProfileProvider.userProfile!;
              newUserProfile = newUserProfile.copyWith(gender: selectedGender!);
              updateUserProfile(newUserProfile);
              Navigator.of(context).pop(selectedGender); // 返回选中的性别
            }
          },
        ),
      ],
    );
  }
}