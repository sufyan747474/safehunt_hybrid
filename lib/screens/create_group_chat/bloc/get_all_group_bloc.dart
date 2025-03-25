import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/screens/create_group_chat/model/group_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class GetGroupBloc {
  VoidCallback? _onSuccess, _onFailure;
  Response? _response;

  void getGroupBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    // ignore: use_build_context_synchronously
    await _getRequest(
        endPoint: NetworkStrings.GROUP_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _getGroupResponseMethod(context: context);
    };
    _validateResponse();
  }

  ///----------------------------------- get Request -----------------------------------
  Future<void> _getRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().getRequest(
      baseUrl: NetworkStrings.API_BASE_URL,
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

  void _getGroupResponseMethod({required BuildContext context}) async {
    try {
      if (_response?.data != null) {
        final group = (_response?.data['data'] as List)
            .map((e) => GroupModel.fromJson(e))
            .toList();

        context.read<PostProvider>().setGroup(group);
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
