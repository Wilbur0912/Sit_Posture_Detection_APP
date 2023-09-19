import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/userModel.dart';

class UserProfileManager {
  static const String baseUrl =
      "https://d7fc3fd8-0191-42ed-aad3-92e3b6b142df.mock.pstmn.io";

  Future<UserProfile> login(String username, String password) async {
    final url = "$baseUrl/login";
    print(password);

    print(url);
    final requestHeaders = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
    };

    final requestBody = {
      'username': username,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: requestHeaders,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return UserProfile.fromJson(responseData);
      } else {
        throw Exception("登入失敗1：${response.statusCode}");
      }
    } catch (e) {
      throw Exception("登入失敗2：$e");
    }
  }

  Future<String?> sendUserDataToBackend(UserProfile userProfile) async {
    final url = "$baseUrl/userprofile";
    final headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      // "Cookie": 'token=$userProfile.username'
      // "Cookie": 'user_name=$userProfile.username'
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
      final responseBody = json.decode(response.body);
      final token = responseBody['token'];
      print('OK');
      return token;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<void> updateUserDataToBackend(UserProfile userProfile) async {
    final url = "$baseUrl/updateUserData";
    final headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      // "Cookie": 'user_name=${userProfile.username}'
      "Cookie": 'token=$userProfile.token'
    };
    print(userProfile.token);
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
