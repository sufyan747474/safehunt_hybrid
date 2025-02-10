import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class UpdateChildCommentBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void updateChildCommentBlocMethod({
    required BuildContext context,
    String? comment,
    String? commentId,
    String? parrendId,
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
        endPoint: "${NetworkStrings.COMMENT_ENDPOINT}/$commentId",
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _updateChildCommentResponseMethod(
          context: context,
          onSuccess: onSuccess,
          commentId: commentId,
          parrentId: parrendId);
    };
    _validateResponse();
  }

  //-------------------------- Post Request ----------------------------------

  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().putRequest(
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

  void _updateChildCommentResponseMethod({
    required BuildContext context,
    Function? onSuccess,
    String? parrentId,
    String? commentId,
  }) {
    try {
      if (_response?.data != null) {
        // final comment = PostComment.fromJson(_response?.data['data']);

        context.read<PostProvider>().updateChildCommentInPostDetails(
            _response?.data['data']['content'],
            commentId ?? '',
            parrentId ?? '');
        onSuccess?.call();
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
