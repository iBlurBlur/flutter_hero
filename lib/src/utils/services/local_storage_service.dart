import 'package:flutter_hero/src/constants/app_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  Future<void> login(String username, token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppSetting.username, username);
    prefs.setString(AppSetting.token, token);
  }
}