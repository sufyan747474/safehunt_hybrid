import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/screens/post/model/post_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class GetOtherUserPostBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  Future<void> getOtherUserPostBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    required Function() onSuccess,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    await _getRequest(
        endPoint: NetworkStrings.ADD_POST_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _getOtherUserPostResponseMethod(context: context, onSuccess: onSuccess);
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

  void _getOtherUserPostResponseMethod({
    required BuildContext context,
    required Function() onSuccess,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        final post = List<PostData>.from(
            _response?.data['data']!.map((x) => PostData.fromJson(x))).toList();

        context.read<PostProvider>().setPosts(post);
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
