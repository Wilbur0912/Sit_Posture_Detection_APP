import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/userModel.dart';

class UserProfileManager{
  // void saveUserProfile(UserProfile userProfile) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // 將使用者資訊以 JSON 格式儲存
  //   final userProfileJson = userProfile.toJson();
  //   final userProfileString = json.encode(userProfileJson);
  //   prefs.setString('userProfile', userProfileString);
  // }
  // Future<UserProfile?> loadUserProfile() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // 從 JSON 格式轉換回使用者資訊
  //   final userProfileJson = prefs.getString('userProfile');
  //   if (userProfileJson != null) {
  //     final userProfileMap = json.decode(userProfileJson);
  //     return UserProfile.fromJson(userProfileMap); // 假設有一個 fromJson 方法
  //   } else {
  //     return null;
  //   }
  // }
  Future<void> sendUserDataToBackend(UserProfile userProfile) async {
    final url = "http:///userprofile";
    final headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Cookie": 'user_name=$userProfile.username'
    };

    final userData = {
      'username': userProfile.username,
      'password': userProfile.password,
      'height': userProfile.height,
      'weight': userProfile.weight,
      'gender': userProfile.gender,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      print('OK');
    } else {
      print(response.statusCode);
    }
  }
}