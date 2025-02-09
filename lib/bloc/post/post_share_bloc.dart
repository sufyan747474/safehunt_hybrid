import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class PostShareBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void postShareBlocMethod({
    required BuildContext context,
    String? postId,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: "${NetworkStrings.POST_SHARE_ENDPOINT}/$postId",
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _postShareResponseMethod(
        context: context,
      );
    };
    _validateResponse();
  }

  //-------------------------- Post Request ----------------------------------

  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().postRequest(
      baseUrl: NetworkStrings.API_BASE_URL,
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

  void _postShareResponseMethod({
    required BuildContext context,
  }) {
    try {
      if (_response?.data != null) {
        AppDialogs.showToast(message: "Post Shared Successfully");
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
