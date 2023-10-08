import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/userModel.dart';

class UserProfileManager {
  static const String baseUrl =
  "https://spineinspectorbackend-production.up.railway.app/api";
      // "https://d7fc3fd8-0191-42ed-aad3-92e3b6b142df.mock.pstmn.io";

  // Future<UserProfile> login(String username, String password) async {
  //   final url = "$baseUrl/user/auth/";
  //   print(password);
  //
  //   print(url);
  //   final requestHeaders = {
  //     'Content-Type': 'application/json',
  //     "Accept": "application/json",
  //   };
  //
  //   final requestBody = {
  //     'username': username,
  //     'password': password,
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: requestHeaders,
  //       body: json.encode(requestBody),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       return UserProfile.fromJson(responseData);
  //     } else {
  //       throw Exception("登入失敗1：${response.statusCode}");
  //     }
  //   } catch (e) {
  //     throw Exception("登入失敗2：$e");
  //   }
  // }
  Future<String> login(String username, String password) async {
    final url = "$baseUrl/user/auth/";
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
        final responseBody = json.decode(response.body);
        final token = responseBody['token'];
        print("登入成功");
        return token;
      } else {
        throw Exception("登入失敗1：${response.statusCode}");
      }
    } catch (e) {
      throw Exception("登入失敗2：$e");
    }
  }

  Future<UserProfile> getUserProfile(String? token) async {
    final url = "$baseUrl/user/get/";


    print(url);
    final requestHeaders = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'token':'$token'
    };


    try {
      final response = await http.get(
        Uri.parse(url),
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = json.decode(response.body);
        // return UserProfile.fromJson(responseData);
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          // 在這裡處理數組中的第一個元素
          return UserProfile.fromJson(responseData[0]);
        } else {
          throw Exception("API 回應數組為空");
        }
      } else {
        throw Exception("取得失敗1：${response.statusCode}");
      }
    } catch (e) {
      throw Exception("取得失敗2：$e");
    }
  }




  Future<void> register(UserProfile userProfile) async {
    final url = "$baseUrl/user/create/";
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

try {
  if (response.statusCode == 200 ||response.statusCode == 201 ) {
    // final responseBody = json.decode(response.body);
    // final token = responseBody['token'];
    print('register OK');
    // return token;
  } else {
    throw Exception("註冊連接失敗：${response.statusCode}");
  }
}catch(e){
  throw Exception("註冊失敗：$e");
}
  }



  Future<void> updateUserDataToBackend(UserProfile userProfile) async {
    final url = "$baseUrl/updateUserData";
    final headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      // "Cookie": 'user_name=${userProfile.username}'
      'token':'$userProfile.token'
    };
    print(userProfile.token);
    final userData = {
      'username': userProfile.username,
      'password': userProfile.password,
      'height': userProfile.height,
      'weight': userProfile.weight,
      'gender': userProfile.gender,
    };

    print('$userProfile');
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      print('OK');
    } else {
      throw Exception("更改失敗：$response.statusCode");
    }
  }
}
