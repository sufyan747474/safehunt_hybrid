import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/model/friend_list_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class GetFriendRequestBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  Future<void> getFriendRequestBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    required Function(List<FriendModel>) onSuccess,
    bool isLoader = true,
  }) async {
    isLoader ? setProgressBar() : null;

    _onFailure = () {
      isLoader ? Navigator.pop(context) : null;
      onSuccess.call([]);
    };

    await _getRequest(
        endPoint: NetworkStrings.GE_FRIENDS_REQUEST_ENDPOINT, context: context);

    _onSuccess = () {
      isLoader ? Navigator.pop(context) : null;
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

  void _getAllPostResponseMethod({
    required BuildContext context,
    required Function(List<FriendModel>) onSuccess,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        final friends = List<FriendModel>.from(
                _response?.data['data']!.map((x) => FriendModel.fromJson(x)))
            .toList();

        onSuccess.call(friends);
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
