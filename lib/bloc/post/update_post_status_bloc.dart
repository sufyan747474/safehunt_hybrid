import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class UpdatePostStatusBloc {
  Response? _response;
  Map<String, dynamic> userObject = {};
  VoidCallback? _onSuccess, _onFailure;

  void updatePostStatusBlocMethod({
    required BuildContext context,
    String? status,
    String? postId,
    String? groupId,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    userObject = {
      "status": status,
    };

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _putRequest(
        endPoint: 'groups/$groupId/posts/$postId', context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _updatePostStatusResponseMethod(context: context, postId: postId);
    };
    _validateResponse();
  }

  //-------------------------- Post Request ----------------------------------

  Future<void> _putRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().putRequest(
      endPoint: endPoint,
      formData: userObject,
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

  void _updatePostStatusResponseMethod({
    required BuildContext context,
    String? postId,
  }) {
    try {
      if (_response?.data != null) {
        AppNavigation.pop();
        context.read<PostProvider>().deletePost(postId ?? '');
        AppDialogs.showToast(message: "Post Approved Successfully");
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
