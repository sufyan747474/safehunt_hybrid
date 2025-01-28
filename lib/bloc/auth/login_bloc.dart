import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/drawer/main_screen.dart';
import 'package:safe_hunt/screens/signup_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';
import 'package:safe_hunt/utils/services/shared_preference.dart';

class LoginBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  String? deviceToken;

  void loginBlocMethod({
    required BuildContext context,
    String? userName,
    String? password,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
      log('Firebase Messaging Token: $deviceToken');
    } catch (e) {
      log('Error fetching token: $e');
    }

    _formData = {
      "username": userName,
      "password": password,
      "device_id": deviceToken ?? '232',
    };

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.LOGIN_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _loginResponseMethod(
        context: context,
      );
    };
    _validateResponse();
  }

  //-------------------------- Post Request ----------------------------------

  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
      baseUrl: NetworkStrings.API_BASE_URL,
      endPoint: endPoint,
      formData: _formData,
      context: context,
      onFailure: _onFailure,
      isHeaderRequire: false,
    );
  }

  //-------------------------- Validate Response --------------------------
  void _validateResponse() {
    if (_response != null) {
      Network().validateResponse(
        isToast: false,
        response: _response,
        onSuccess: _onSuccess,
        onFailure: _onFailure,
      );
    }
  }

  void _loginResponseMethod({
    required BuildContext context,
  }) {
    try {
      if (_response?.data != null) {
        // Logger().i(SharedPreference().getBearerToken());
        final user = UserData.fromJson(_response?.data['data']);
        context.read<UserProvider>().setUser(user);
        SharedPreference().setBearerToken(token: user.token);

        if (user.status == 'PENDING_VERIFICATION') {
          AppNavigation.push(const SignUpScreen(
            activeIndex: 2,
          ));
        } else if (user.status == 'OTP_VERIFIED') {
          SharedPreference().setUser(user: jsonEncode(user));
          AppNavigation.pushAndRemoveUntil(const MainScreen());
          AppDialogs.showToast(message: "Login successfully");
        }
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
