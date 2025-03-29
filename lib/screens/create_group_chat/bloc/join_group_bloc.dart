import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class JoinGroupBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  Map<String, dynamic> userObject = {};

  void joinGroupBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    String? groupId,
  }) async {
    setProgressBar();

    userObject = {
      "memberId": context.read<UserProvider>().user?.id,
      "type": "Member",
    };

    _onFailure = () {
      Navigator.pop(context);
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: '${NetworkStrings.GROUP_ENDPOINT}/$groupId/members',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _joinGroupResponseMethod(
        context: context,
        groupId: groupId,
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
      formData: userObject,
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

  void _joinGroupResponseMethod(
      {required BuildContext context, String? groupId, String? status}) async {
    try {
      if (_response?.data != null) {
        context
            .read<PostProvider>()
            .updateGroupStatus("Pending", groupId ?? '');
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
