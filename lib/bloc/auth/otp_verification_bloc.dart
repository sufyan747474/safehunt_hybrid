import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/drawer/main_screen.dart';
import 'package:safe_hunt/screens/new_password_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';
import 'package:safe_hunt/utils/services/shared_preference.dart';

class OtpVerifiactionBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void otpVerificatiobBlockMethod({
    required BuildContext context,
    String? otp,
    required VoidCallback setProgressBar,
    bool isChangePassword = false,
    String? email,
  }) async {
    setProgressBar();

    //Form Data
    _formData = {
      "email": email ?? context.read<UserProvider>().user?.email,
      "otp": otp,
    };
    print({_formData});
    _onFailure = () {
      Navigator.pop(context);
    };

    await _postRequest(
        endPoint: NetworkStrings.OTP_VERIFICATION_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _verifyOtpResponseMethod(
          context: context, isChangePassword: isChangePassword, email: email);
    };
    _validateResponse();
  }

  //----------------------------------- Post Request -----------------------------------
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
      endPoint: endPoint,
      formData: _formData,
      context: context,
      onFailure: _onFailure,
      baseUrl: NetworkStrings.API_BASE_URL,
      isHeaderRequire: true,
    );
  }

  //----------------------------------- Validate Response -----------------------------------
  void _validateResponse() {
    if (_response != null) {
      Network().validateResponse(
          response: _response,
          onSuccess: _onSuccess,
          onFailure: _onFailure,
          isToast: false);
    }
  }

  void _verifyOtpResponseMethod({
    required BuildContext context,
    bool isChangePassword = false,
    String? email,
  }) {
    try {
      if (isChangePassword) {
        AppNavigation.pushReplacement(NewPasswordScreen(
          email: email,
        ));
      } else {
        SharedPreference()
            .setUser(user: jsonEncode(context.read<UserProvider>().user));
        AppNavigation.pushAndRemoveUntil(const MainScreen());
        AppDialogs.showToast(message: "Login successfully");
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
