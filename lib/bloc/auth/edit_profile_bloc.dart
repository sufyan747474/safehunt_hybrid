import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';
import 'package:safe_hunt/utils/services/shared_preference.dart';

class EditProfileBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  Map<String, dynamic> userObject = {};

  void editProfileBlocMethod({
    required BuildContext context,
    String? userName,
    String? displayName,
    String? phoneNumber,
    String? huntingExperience,
    String? email,
    String? bio,
    String? imageFilePath,
    String? coverPhoto,
    bool isEdit = true,
    List<String>? skills,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    log("image path : $imageFilePath");
    log("cover photo path : $coverPhoto");

    /// Form Data
    userObject = {
      "username": userName,
      "email": email,
      "displayname": displayName,
      'phonenumber': phoneNumber,
      'huntingExperience': huntingExperience,
      'bio': bio,
    };

    /// Dynamically adding skills in the correct format
    userObject.addAll(
      {
        for (var index in List.generate(skills?.length ?? 0, (index) => index))
          'skills[$index]': skills?[index]
      },
    );
    Logger().i("User Profile Data");
    print(userObject);

    if (imageFilePath != null && imageFilePath.isNotEmpty) {
      userObject["profilePhoto"] = await MultipartFile.fromFile(imageFilePath);
    }
    if (coverPhoto != null && coverPhoto.isNotEmpty) {
      userObject["coverPhoto"] = await MultipartFile.fromFile(coverPhoto);
    }
    _formData = FormData.fromMap(userObject);
    _onFailure = () {
      Navigator.pop(context);
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.EDIT_PROFILE_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _profileResponseMethod(context: context);
    };
    _validateResponse();
  }

  ///----------------------------------- Post Request -----------------------------------
  Future<void> _postRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().putRequest(
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

  void _profileResponseMethod({required BuildContext context}) async {
    try {
      if (_response?.data != null) {
        final user = UserData.fromJson(_response?.data['data']['user']);
        context.read<UserProvider>().setUser(user);
        SharedPreference().setUser(user: jsonEncode(user));
        AppDialogs.showToast(message: "Profile updated successfully");
        AppNavigation.pop();
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
