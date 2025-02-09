import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class DeleteCommentBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void deleteCommentBlocMethod({
    required BuildContext context,
    String? commentId,
    String? postId,
    required VoidCallback setProgressBar,
    Function? onSuccess,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _deleteRequest(
        endPoint: "${NetworkStrings.COMMENT_ENDPOINT}/$commentId",
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _deleteCommentResponseMethod(
          context: context,
          onSuccess: onSuccess,
          postId: postId,
          commentId: commentId);
    };
    _validateResponse();
  }

  //-------------------------- Post Request ----------------------------------

  Future<void> _deleteRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().deleteRequest(
      endPoint: endPoint,
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

  void _deleteCommentResponseMethod({
    required BuildContext context,
    Function? onSuccess,
    String? postId,
    String? commentId,
  }) {
    try {
      if (_response?.data != null) {
        context
            .read<PostProvider>()
            .deleteCommentFromPost(commentId ?? "", postId ?? '');
        onSuccess?.call();
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
