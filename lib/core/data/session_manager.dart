import 'dart:convert';
import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class for managing sessions, handles saving and retrieving of data
class SessionManager {
  SessionManager._internal();

  SharedPreferences? sharedPreferences;

  static SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  static SessionManager get instance => _instance;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String KEY_USERS_DATA = 'usersData';
  static const String KEY_AUTH_TOKEN = 'authToken';
  static const String KEY_AGENT_TOKEN = 'authToken';
  static const String KEY_IS_LOGIN = 'is_logged_in';
  static const String KEY_IS_USER_SAVE = 'is_user_save';
  static const String KEY_APP_SESSION = 'app-session';

  String get authToken =>  (sharedPreferences!.getString(KEY_AUTH_TOKEN) ?? '');
  set authToken(String authToken) => sharedPreferences!.setString(KEY_AUTH_TOKEN, authToken);
  set authAGentToken(String authToken) => sharedPreferences!.setString(KEY_AGENT_TOKEN, authToken);

  Map<String, dynamic> get usersData => json.decode(sharedPreferences!.getString(KEY_USERS_DATA) ?? '');
  set usersData(Map<String, dynamic> map) => sharedPreferences!.setString(KEY_USERS_DATA, json.encode(map));

  set isUserSave(bool loggedIn) => sharedPreferences!.setBool(KEY_IS_USER_SAVE, loggedIn);
  bool get isUserSave => sharedPreferences!.getBool(KEY_IS_USER_SAVE) ?? false;

  set isLoggedIn(bool loggedIn) => sharedPreferences!.setBool(KEY_IS_LOGIN, loggedIn);
  bool get isLoggedIn => sharedPreferences!.getBool(KEY_IS_LOGIN) ?? false;

  String get lastSession => sharedPreferences!.getString(KEY_APP_SESSION) ?? '';
  set lastSession(String authToken) => sharedPreferences!.setString(KEY_APP_SESSION, authToken);


  save(String key, String value) async {
    try{
      await sharedPreferences!.setString(key, value);
    }catch(e){log(e.toString());}
  }

  delete(String key) async => await sharedPreferences!.remove(key);

  get(String key) async => sharedPreferences!.getString(key);


  Future<bool> logOut() async {
    await sharedPreferences!.clear();
    try {
      final cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
      final appDir = await getApplicationSupportDirectory();
      if (appDir.existsSync()) {
        appDir.deleteSync(recursive: true);
      }
    } catch (e) {
      log("error clearing cache");
    }
    return true;
  }
}
