import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class NotificationOnOffBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  dynamic _formData;

  void notificationOnOffBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    required VoidCallback setState,
    required bool enableNotificaion,
  }) async {
    setProgressBar();

    _formData = {
      "user_id": context.read<UserProvider>().user?.id,
      "notifications_enabled": enableNotificaion
    };

    _onFailure = () {
      Navigator.pop(context);
    };

    await _postRequest(
        endPoint: NetworkStrings.NOTIFICATION_ON_OFF_END_POINT,
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _notificationOnOffResponseMethod(
          context: context,
          setState: setState,
          enableNotificaion: enableNotificaion);
    };
    _validateResponse();
  }

  ///----------------------------------- Post Request -----------------------------------
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
        baseUrl: NetworkStrings.API_BASE_URL,
        endPoint: endPoint,
        context: context,
        onFailure: _onFailure,
        isHeaderRequire: true,
        formData: _formData);
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

  void _notificationOnOffResponseMethod({
    required BuildContext context,
    required VoidCallback setState,
    required bool enableNotificaion,
  }) async {
    try {
      if (_response?.data['statusCode'] == 201) {
        // context.read<UserProvider>().userData!.notification =
        //     _response?.data['data']['notification'];
        // SharedPreference()
        //     .setUser(user: jsonEncode(context.read<UserProvider>().userData!));
        setState.call();
        if (enableNotificaion) {
          AppDialogs.showToast(
            message: 'Notification is turned ON',
          );
        } else {
          AppDialogs.showToast(
            message: 'Notification is turned Off',
          );
        }
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
