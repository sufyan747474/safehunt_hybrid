import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class SendFriendRequestBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void sendFriendRequestBlocMethod({
    required BuildContext context,
    String? userId,
    required VoidCallback setProgressBar,
    Function? onSuccess,
  }) async {
    setProgressBar();

    _formData = {
      "recipientId": userId,
    };

    log("body : $_formData");

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.FRIENDS_REQUEST_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _sendFriendRequestResponseMethod(context: context, onSuccess: onSuccess);
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

  void _sendFriendRequestResponseMethod({
    required BuildContext context,
    Function? onSuccess,
  }) {
    try {
      if (_response?.data != null) {
        onSuccess?.call();
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
