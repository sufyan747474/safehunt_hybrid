import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class DeleteJournalBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  Future<void> deleteJournalBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    required Function() onSuccess,
    String? id,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    await _deleteRequest(
        endPoint: '${NetworkStrings.JOURNALING_DELETE_ENDPOINT}/$id',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _deletePostResponseMethod(context: context, onSuccess: onSuccess);
    };
    _validateResponse();
  }

  ///----------------------------------- delete Request -----------------------------------
  Future<void> _deleteRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().deleteRequest(
      endPoint: endPoint,
      context: context,
      onFailure: _onFailure,
      isHeaderRequire: true,
    );
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
    required Function() onSuccess,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        onSuccess.call();
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
