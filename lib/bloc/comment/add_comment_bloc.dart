import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/screens/post/model/post_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class AddCommentBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void addCommentBlocMethod({
    required BuildContext context,
    String? comment,
    String? postId,
    required VoidCallback setProgressBar,
    Function? onSuccess,
  }) async {
    setProgressBar();

    _formData = {
      "content": comment,
    };

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: "${NetworkStrings.COMMENT_ENDPOINT}/$postId",
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _addCommentResponseMethod(context: context, onSuccess: onSuccess);
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

  void _addCommentResponseMethod({
    required BuildContext context,
    Function? onSuccess,
  }) {
    try {
      if (_response?.data != null) {
        final comment = PostComment.fromJson(_response?.data['data']);

        context.read<PostProvider>().addCommentInPost(
            comment, _response?.data['data']['post']['id'].toString() ?? '');
        onSuccess?.call();
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
