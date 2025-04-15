import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class DeletePostBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  Future<void> deletePostBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function()? onSuccess,
    required String postId,
    String groupId = '',
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    await _deleteRequest(
        endPoint:
            '${NetworkStrings.ADD_POST_ENDPOINT}/$postId?groupId=$groupId',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _deletePostResponseMethod(
          context: context, onSuccess: onSuccess, postId: postId);
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

  void _deletePostResponseMethod({
    required BuildContext context,
    Function()? onSuccess,
    String? postId,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        // final post = List<PostData>.from(
        //     _response?.data['data']!.map((x) => PostData.fromJson(x))).toList();

        context.read<PostProvider>().deletePost(postId ?? "");
        onSuccess?.call();
        AppDialogs.showToast(message: "Post deleted successfully");
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
