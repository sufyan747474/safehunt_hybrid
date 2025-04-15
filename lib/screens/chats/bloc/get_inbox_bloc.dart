import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/model/inbox_model.dart';
import 'package:safe_hunt/providers/chat_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class GetInboxBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  Future<void> getInboxBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function()? onSuccess,
    Function()? onFailure,
    bool isLoader = true,
    String? userId,
    int page = 1,
    int limit = 10,
    String groupId = '',
  }) async {
    isLoader ? setProgressBar() : null;

    _onFailure = () {
      onFailure?.call();
      isLoader ? Navigator.pop(context) : null;
    };

    await _getRequest(
        endPoint: NetworkStrings.INBOX_ENDPOINT, context: context);

    _onSuccess = () {
      isLoader ? Navigator.pop(context) : null;
      _getInboxResponseMethod(context: context, onSuccess: onSuccess);
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

  void _getInboxResponseMethod({
    required BuildContext context,
    Function()? onSuccess,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        final inbox = List<InboxModel>.from((_response?.data['data'] as List)
            .map((x) => InboxModel.fromJson(x)));

        context.read<ChatProvider>().setInboxList(inbox);
        onSuccess?.call();
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
