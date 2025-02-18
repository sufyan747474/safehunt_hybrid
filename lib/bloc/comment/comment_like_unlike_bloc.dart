import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class LikeUnlikeCommentBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void likeUnlikeCommentBlocMethod({
    required BuildContext context,
    String? commentId,
    String? parrentId,
    bool liked = false,
    bool? isChild,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        isLiked: liked,
        endPoint: isChild == true
            ? '${NetworkStrings.COMMENT_ENDPOINT}/replies/$commentId/${liked ? 'like' : 'unlike'}'
            : '${NetworkStrings.COMMENT_ENDPOINT}/$commentId/like',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _likeUnlikePostResponseMethod(
          context: context,
          commentId: commentId ?? "",
          liked: liked,
          parrentId: parrentId ?? "",
          isChild: isChild);
    };
    _validateResponse();
  }

  //-------------------------- Comment Request ----------------------------------

  Future<void> _postRequest(
      {required String endPoint,
      required BuildContext context,
      required bool isLiked}) async {
    _response = !isLiked
        ? await Network().deleteRequest(
            endPoint: endPoint,
            context: context,
            onFailure: _onFailure,
            isHeaderRequire: true,
          )
        : await Network().postRequest(
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

  void _likeUnlikePostResponseMethod({
    required BuildContext context,
    required String commentId,
    required String parrentId,
    bool? liked,
    bool? isChild,
  }) {
    try {
      if (_response?.data != null) {
        context.read<PostProvider>().updateCommentLikeInPostDetail(
              commentId: commentId,
              isLiked: liked ?? false,
              isChild: isChild,
              parrentId: parrentId,
            );
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
