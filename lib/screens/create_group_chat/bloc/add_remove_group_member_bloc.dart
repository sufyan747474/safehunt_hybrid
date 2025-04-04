import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class AddRemoveGroupMemberBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  dynamic _formData;
  Future<void> addRemoveGroupMemberBlocMethod(
      {required BuildContext context,
      required VoidCallback setProgressBar,
      Function()? onSuccess,
      required String groupId,
      memmberId,
      String type = 'add_member'}) async {
    _formData = {"groupId": groupId, "status": "approved"};
    setProgressBar();

    _onFailure = () {
      Navigator.pop(context);
    };

    await _deleteRequest(
        type: type,
        endPoint: type == 'add_member'
            ? '${NetworkStrings.GROUP_ENDPOINT}/members/$memmberId'
            : '${NetworkStrings.GROUP_ENDPOINT}/$groupId/members/$memmberId',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _addRemoveGroupMemberResponseMethod(
          context: context,
          onSuccess: onSuccess,
          type: type,
          groupId: groupId,
          memberId: memmberId);
    };
    _validateResponse();
  }

  ///----------------------------------- Get Request -----------------------------------
  Future<void> _deleteRequest(
      {required String endPoint,
      required BuildContext context,
      String type = 'add_member'}) async {
    _response = type == 'add_member'
        ? await Network().putRequest(
            endPoint: endPoint,
            formData: _formData,
            context: context,
            onFailure: _onFailure,
            isHeaderRequire: true,
            isErrorToast: false,
            isToast: false)
        : await Network().deleteRequest(
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

  void _addRemoveGroupMemberResponseMethod({
    required BuildContext context,
    Function()? onSuccess,
    String? groupId,
    String? memberId,
    String? type,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        context.read<PostProvider>().updateGroupMember(
            type: type!, memberId: memberId!); // onSuccess?.call();
        AppDialogs.showToast(
          message:
              "Member ${type == 'add_member' ? 'added' : 'removed'} successfully",
        );
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
