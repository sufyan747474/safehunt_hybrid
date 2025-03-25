import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class GetEquipmentImagesBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  Future<void> getEquipmentImagesBlocMethod({
    required BuildContext context,
    required VoidCallback setProgressBar,
    Function? onSuccess,
    required Function onFailure,
    bool isLoader = true,
  }) async {
    isLoader ? setProgressBar() : null;

    _onFailure = () {
      onFailure.call();
      isLoader ? Navigator.pop(context) : null;
    };

    await _getRequest(
        endPoint: NetworkStrings.EQUIPMENT_ENDPOINT, context: context);

    _onSuccess = () {
      isLoader ? Navigator.pop(context) : null;
      _getAllPostResponseMethod(context: context, onSuccess: onSuccess);
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

  void _getAllPostResponseMethod({
    required BuildContext context,
    Function? onSuccess,
  }) async {
    try {
      if (_response?.data['statusCode'] == 200) {
        final List<String> images =
            List<String>.from(_response?.data['data'].map((x) => x['imageUrl']))
                .toList();
        onSuccess?.call(images);
      }
    } catch (error) {
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
