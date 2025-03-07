import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class CancelRequestBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  dynamic _formData;

  Future<void> cancelRequestBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function()? onSuccess,
    String? requesterId,
    String? receipitId,
  }) async {
    setProgressBar();
    _formData = {
      "requesterId": requesterId,
      "recipientId": receipitId,
    };

    _onFailure = () {
      Navigator.pop(context);
    };

    await _deleteRequest(
        endPoint: '${NetworkStrings.FRIENDS_ENDPOINT}/cancel',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _cancelRequestResponseMethod(
        context: context,
        onSuccess: onSuccess,
      );
    };
    _validateResponse();
  }

  ///----------------------------------- Get Request -----------------------------------
  Future<void> _deleteRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().deleteRequest(
        endPoint: endPoint,
        context: context,
        onFailure: _onFailure,
        formData: _formData,
        isHeaderRequire: true,
        isErrorToast: false,
        isToast: false);
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

  void _cancelRequestResponseMethod({
    required BuildContext context,
    Function()? onSuccess,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        onSuccess?.call();
        AppDialogs.showToast(message: "Cancel request successfully");
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
