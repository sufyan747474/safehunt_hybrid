import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class ReportPostBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  dynamic _formData;

  void reportPostBlocMethod({
    required BuildContext context,
    String? postId,
    required VoidCallback setProgressBar,
    Function? onSuccess,
  }) async {
    setProgressBar();
    _formData = {"postId": postId, "reason": 'Inappropriate Content'};
    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.REPORT_POST_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _reportPostResponseMethod(context: context, onSuccess: onSuccess);
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

  void _reportPostResponseMethod({
    required BuildContext context,
    Function? onSuccess,
  }) {
    try {
      if (_response?.data != null) {
        AppDialogs.showToast(message: "Post Report Successfully");
        onSuccess?.call();
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
