import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/journals/model/journal_model.dart';
import 'package:safe_hunt/screens/journals/model/location_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class UpdatejournalingBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  void updatejournalingBlocMethod({
    required BuildContext context,
    String? title,
    String? description,
    LocationModel? location,
    String? weather,
    String? id,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    _formData = {
      "title": title,
      "description": description,
      // "location": location?.toJson(),
      // "weather": weather,
    };

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    // ignore: use_build_context_synchronously
    await _putRequest(
        endPoint: '${NetworkStrings.JOURNALING_CREATE_ENDPOINT}/$id',
        context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _updatejournalingResponseMethod(
        context: context,
      );
    };
    _validateResponse();
  }

  //-------------------------- put Request ----------------------------------

  Future<void> _putRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().putRequest(
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

  void _updatejournalingResponseMethod({
    required BuildContext context,
  }) {
    try {
      if (_response?.data != null) {
        final journal = JournalData.fromJson(_response?.data['data']);

        context.read<UserProvider>().updateJournal(journal);
        AppNavigation.pop();
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
