import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/screens/create_group_chat/model/group_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class CreateGroupBloc {
  FormData? _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  Map<String, dynamic> userObject = {};

  void createGroupBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    String? name,
    bool isUpdate = false,
    String? description,
    String? groupImage,
    String? groupLogo,
    String? groupId,
  }) async {
    setProgressBar();

    userObject = {
      // "members": jsonEncode(context.read<PostProvider>().selectedTagPeople),
      "name": name,
      "description": description,
      "status": "Active"
    };
    Logger().i("create group chat Data");
    log(userObject.toString());
    if (groupImage != null) {
      userObject["cover"] = await MultipartFile.fromFile(groupImage);
    }
    if (groupLogo != null) {
      userObject["logo"] = await MultipartFile.fromFile(groupLogo);
    }

    _formData = FormData.fromMap(userObject);

    _onFailure = () {
      Navigator.pop(context);
    };

    // ignore: use_build_context_synchronously
    await _postRequest(isUpdate,
        endPoint: isUpdate
            ? '${NetworkStrings.GROUP_ENDPOINT}/$groupId'
            : NetworkStrings.GROUP_ENDPOINT,
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _createGroupResponseMethod(context: context, isUpdate: isUpdate);
    };
    _validateResponse();
  }

  ///----------------------------------- Post Request -----------------------------------
  Future<void> _postRequest(bool isUpdate,
      {required String endPoint, required BuildContext context}) async {
    _response = isUpdate
        ? await Network().putRequest(
            endPoint: endPoint,
            formData: _formData,
            context: context,
            onFailure: _onFailure,
            isHeaderRequire: true,
          )
        : await Network().postRequest(
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

  void _createGroupResponseMethod(
      {required BuildContext context, required bool isUpdate}) async {
    try {
      if (_response?.data != null) {
        final group = GroupModel.fromJson(_response?.data['data']);
        if (isUpdate) {
          context.read<PostProvider>().updateGroupInList(group);
          AppDialogs.showToast(message: 'Group Updated Successfully');
        } else {
          group.name = _response?.data['data']['group']['name'];
          group.cover = _response?.data['data']['group']['cover'];
          group.logo = _response?.data['data']['group']['logo'];
          group.description = _response?.data['data']['group']['description'];
          group.id = _response?.data['data']['group']['id'].toString();

          context.read<PostProvider>().addGroupInList(group);
          AppDialogs.showToast(message: 'Group Created Successfully');
        }
        AppNavigation.pop();
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
