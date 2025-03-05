import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class FriendRequestUpdateBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void friendRequestUpdateBlocMethod({
    required BuildContext context,
    String? requesterId,
    String? status,
    required VoidCallback setProgressBar,
    Function? onSuccess,
  }) async {
    setProgressBar();

    _formData = {
      "requesterId": requesterId,
      "status": status,
    };

    log("body : $_formData");

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _putRequest(
        endPoint: NetworkStrings.FRIENDS_STATUS_UPDATE_ENDPOINT,
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _friendRequestUpdateResponseMethod(
          context: context, onSuccess: onSuccess, status: status);
    };
    _validateResponse();
  }

  //-------------------------- put Request ----------------------------------

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

  void _friendRequestUpdateResponseMethod({
    required BuildContext context,
    Function? onSuccess,
    String? status,
  }) {
    try {
      if (_response?.data != null) {
        onSuccess?.call(status);
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
