import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class DeleteGroupBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void deleteGroupBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    String? groupId,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    // ignore: use_build_context_synchronously
    await _deleteRequest(
        endPoint: '${NetworkStrings.GROUP_ENDPOINT}/$groupId',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _deleteGroupResponseMethod(context: context, groupId: groupId ?? '');
    };
    _validateResponse();
  }

  ///----------------------------------- delete Request -----------------------------------
  Future<void> _deleteRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().deleteRequest(
      endPoint: endPoint,
      formData: _formData,
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

  void _deleteGroupResponseMethod(
      {required BuildContext context, required String groupId}) async {
    try {
      if (_response?.data != null) {
        context.read<PostProvider>().deleteGroupFromList(groupId);
        AppDialogs.showToast(message: 'Group Deleted Successfully');

        AppNavigation.pop();
        AppNavigation.pop();
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
