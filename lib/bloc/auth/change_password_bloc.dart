import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class ChangePasswordBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void changePasswordBlocMethod({
    required BuildContext context,
    String? currentPassword,
    String? newPassword,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    /// Form Data
    _formData = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };
    Logger().i("password Data");

    _onFailure = () {
      Navigator.pop(context);
    };

    // ignore: use_build_context_synchronously
    await _putRequest(
        endPoint: NetworkStrings.CHANGE_PASSWORD_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _changePasswordResponseMethod(context: context);
    };
    _validateResponse();
  }

  ///----------------------------------- Post Request -----------------------------------
  Future<void> _putRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().putRequest(
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

  void _changePasswordResponseMethod({required BuildContext context}) async {
    try {
      if (_response?.data != null) {
        AppDialogs.showToast(message: "Password change successfully");
        AppNavigation.pop();
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
