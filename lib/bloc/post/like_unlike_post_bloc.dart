import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class LikeUnlikePostBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  String? deviceToken;

  void likeUnlikePostBlocMethod({
    required BuildContext context,
    String? postId,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    _formData = {
      "userId": context.read<UserProvider>().user?.id,
      'postId': postId
    };

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.POST_LIKE_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _likeUnlikePostResponseMethod(context: context, postId: postId ?? '');
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

  void _likeUnlikePostResponseMethod({
    required BuildContext context,
    required String postId,
  }) {
    try {
      if (_response?.data != null) {
        context.read<PostProvider>().postLikeUpdate(
            isLike: _response?.data['data'] == "Post unliked" ? false : true,
            postId: postId);
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
