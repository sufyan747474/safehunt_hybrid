import 'dart:convert';

import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreference? _sharedPreferenceHelper;
  static SharedPreferences? _sharedPreferences;

  SharedPreference._createInstance();

  factory SharedPreference() {
    // factory with constructor, return some value
    _sharedPreferenceHelper ??= SharedPreference._createInstance();
    return _sharedPreferenceHelper!;
  }

  Future<SharedPreferences> get sharedPreference async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  ///-------------------- Clear Preference -------------------- ///
  void clear() {
    _sharedPreferences?.clear();

    // _sharedPreferences?.remove(NetworkStrings.USER);
    // _sharedPreferences?.remove(NetworkStrings.BEARER_TOKEN);
  }

  void init() {}

  ///-------------------- Bearer Token -------------------- ///
  String? getBearerToken() {
    return _sharedPreferences?.getString(NetworkStrings.BEARER_TOKEN);
  }

  void setBearerToken({String? token}) async {
    await _sharedPreferences?.setString(
        NetworkStrings.BEARER_TOKEN, token ?? '');
  }

  ///-------------------- User -------------------- ///
  void setUser({String? user}) {
    _sharedPreferences?.setString(NetworkStrings.USER, user ?? '');
  }

  UserData? getUser() {
    if (_sharedPreferences?.getString(NetworkStrings.USER) == null) {
      return null;
    } else {
      var jsonResponse = jsonDecode(
          (_sharedPreferences!.getString(NetworkStrings.USER) ?? ''));
      var user = UserData.fromJson(jsonResponse);
      return user;
    }
  }
}
