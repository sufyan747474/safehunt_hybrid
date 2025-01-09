import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/network/network.dart';

class RegisterUserBloc {
  dynamic _formData;
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;

  Future<void> registerUserBlocMethod({
    required BuildContext context,
    Function(dynamic)? onSuccess,
    String? email,
    String? phoneNumber,
    String? userName,
    String? displayName,
    String? password,
    String? confirmPassword,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

    _formData = {
      "username": userName,
      "displayname": displayName,
      "password": password,
      "confirmPassword": confirmPassword,
      "email": email,
      "phonenumber": phoneNumber,
    };

    _onFailure = () {
      Navigator.pop(context); // StopLoader
    };

    await _postRequest(
        endPoint: NetworkStrings.SIGNUP_ENDPOINT, context: context);

    _onSuccess = () {
      Navigator.pop(context);
      _registerUserResponseMethod(
        context: context,
        onSuccess: onSuccess,
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
      isHeaderRequire: false,
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

  void _registerUserResponseMethod({
    required BuildContext context,
    Function(dynamic)? onSuccess,
  }) {
    try {
      if (_response?.data != null) {
        onSuccess!('');
        // ser user to controller
        // final userData = AppUserData.fromJson(_response?.data['data']);
        // context.read<UserProvider>().setUserData(userData.user ?? User());

        // // nevigation ho rhi hy
        // // AuthController.i.registerUserType.value = AppStrings.EMAIL_ADDRESS;
        // AppNavigation.navigateReplacement(
        //     context, AppRouteName.otpVerificationScreenRoute,
        //     arguments: VerificationArguments(
        //         isFromPhoneNumber: false, emailAddress: userData.user?.email));
        // AppDialogs.showToast(
        //     message: AppStrings.sendCodeMessageForEmailAddress);
      }
    } catch (error) {
      log(error.toString());
      AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    }
  }
}
