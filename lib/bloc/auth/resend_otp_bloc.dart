import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class ResendOtpBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void resendOtpBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function(dynamic)? onSuccess,
  }) async {
    setProgressBar();
    _formData = {"email": context.read<UserProvider>().user?.email};

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.RESEND_OTP_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _resendOtpResponseMethod(
        onSuccess: onSuccess,
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
      context: context,
      onFailure: _onFailure,
      formData: _formData,
      isHeaderRequire: true,
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

  void _resendOtpResponseMethod({
    Function(dynamic)? onSuccess,
    required BuildContext context,
  }) {
    try {
      if (_response?.data != null) {
        onSuccess!('');
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
