import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class GetUserProfileBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void userProfileBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    required Function(UserData) onSuccess,
    String? userId,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    await _getRequest(
        endPoint: '${NetworkStrings.USER_PROFILE_ENDPOINT}?ids=$userId',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _getAllPostResponseMethod(context: context, onSuccess: onSuccess);
    };
    _validateResponse();
  }

  ///----------------------------------- Get Request -----------------------------------
  Future<void> _getRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().getRequest(
      baseUrl: NetworkStrings.API_BASE_URL,
      endPoint: endPoint,
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

  void _getAllPostResponseMethod({
    required BuildContext context,
    required Function(UserData) onSuccess,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        final user = UserData.fromJson(_response?.data['data']['data'][0]);
        onSuccess.call(user);
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
