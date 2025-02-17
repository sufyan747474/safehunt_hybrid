import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class ResetPasswordBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void resetPasswordBlocMethod({
    required BuildContext context,
    String? email,
    String? newPassword,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    /// Form Data
    _formData = {
      "email": email,
      "newPassword": newPassword,
    };
    Logger().i("password Data");

    _onFailure = () {
      Navigator.pop(context);
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.RESET_PASSWORD_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _resetPasswordResponseMethod(context: context);
    };
    _validateResponse();
  }

  ///----------------------------------- Post Request -----------------------------------
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
      endPoint: endPoint,
      formData: _formData,
      context: context,
      onFailure: _onFailure,
      isHeaderRequire: true,
    );
  }

  ///----------------------------------- Validate Response -----------------------------------
  void _validateResponse() {
    if (_response != null) {
      Network().validateResponse(
          response: _response,
          onSuccess: _onSuccess,
          onFailure: _onFailure,
          isToast: false);
    }
  }

  void _resetPasswordResponseMethod({required BuildContext context}) async {
    try {
      if (_response?.data != null) {
        AppDialogs.showToast(message: "Password reset successfully");
        AppNavigation.pop();
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
