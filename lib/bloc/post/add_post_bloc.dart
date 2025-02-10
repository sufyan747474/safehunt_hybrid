import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/screens/journals/model/location_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class AddPostBloc {
  dynamic _formData;
  Response? _response;
  Map<String, dynamic> userObject = {};
  VoidCallback? _onSuccess, _onFailure;

  void addPostBlocMethod({
    required BuildContext context,
    String? description,
    LocationModel? location,
    String? media,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();
    log("image path : $media");

    userObject = {
      "description": description,
      // "location": location?.toJson(),
      "latitude": location?.lat,
      "longitude": location?.lng,
      "tags": context.read<PostProvider>().selectedTagPeople
    };

    log("body : $userObject");

    if (media != null && media.isNotEmpty) {
      userObject["image"] = await MultipartFile.fromFile(media);
    }
    _formData = FormData.fromMap(userObject);

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _postRequest(
        endPoint: NetworkStrings.ADD_POST_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _addPostResponseMethod(
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
      formData: _formData,
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

  void _addPostResponseMethod({
    required BuildContext context,
  }) {
    try {
      if (_response?.data != null) {
        AppNavigation.pop();
        AppDialogs.showToast(message: "Post Created Successfully");
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
