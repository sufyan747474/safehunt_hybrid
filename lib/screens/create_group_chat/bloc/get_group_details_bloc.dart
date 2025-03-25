import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/screens/create_group_chat/model/group_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class GetGroupDetailsBloc {
  VoidCallback? _onSuccess, _onFailure;
  Response? _response;

  void getGroupDetailsBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function? onSuccess,
    String? groupId,
  }) async {
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    // ignore: use_build_context_synchronously
    await _getRequest(
        endPoint: '${NetworkStrings.GROUP_ENDPOINT}/$groupId',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _getGroupDetailsResponseMethod(context: context, onSuccess: onSuccess);
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

  void _getGroupDetailsResponseMethod({
    required BuildContext context,
    Function? onSuccess,
  }) async {
    try {
      if (_response?.data != null) {
        final group = GroupModel.fromJson(_response?.data['data']);

        context.read<PostProvider>().setGroupDetail(group);

        onSuccess?.call(group);
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
