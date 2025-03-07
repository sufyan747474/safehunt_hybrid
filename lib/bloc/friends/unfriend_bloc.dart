import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class UnfriendBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  Future<void> unfriendBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function()? onSuccess,
    required String userId,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    await _deleteRequest(
        endPoint: '${NetworkStrings.FRIENDS_ENDPOINT}/unfriend/$userId',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _unfriendResponseMethod(
          context: context, onSuccess: onSuccess, userId: userId);
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

  void _unfriendResponseMethod({
    required BuildContext context,
    Function()? onSuccess,
    String? userId,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        onSuccess?.call();
        AppDialogs.showToast(message: "Unfriend successfully");
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
