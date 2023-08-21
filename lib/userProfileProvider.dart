import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/userModel.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Future<void> updateUserProfile(UserProfile newUserProfile) async {
    _userProfile = newUserProfile;
    notifyListeners();
    await saveUserProfileToSharedPreferences(newUserProfile);
  }
  Future<void> loadUserProfileFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userProfileJson = prefs.getString('userProfile');

    if (userProfileJson != null) {
      final userProfileMap = json.decode(userProfileJson);
      _userProfile = UserProfile.fromJson(userProfileMap);
      notifyListeners();
    }
  }

  Future<void> saveUserProfileToSharedPreferences(UserProfile userProfile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userProfileJson = userProfile.toJson();
    final userProfileString = json.encode(userProfileJson);
    prefs.setString('userProfile', userProfileString);
  }
}
