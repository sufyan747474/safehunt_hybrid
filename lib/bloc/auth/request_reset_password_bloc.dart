import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/screens/password_reset_code_screeen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class RequestResetPasswordBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void requestResetPasswordBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    String? email,
  }) async {
    setProgressBar();
    _formData = {"email": email};

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.REQUEST_RESET_PASSWORD_ENDPOINT,
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _requestResetPasswordResponseMethod(
        context: context,
        email: email,
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
      context: context,
      onFailure: _onFailure,
      formData: _formData,
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

  void _requestResetPasswordResponseMethod({
    required BuildContext context,
    String? email,
  }) {
    try {
      if (_response?.data != null) {
        AppNavigation.pushReplacement(ResetPasswordScreen(email: email));
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
