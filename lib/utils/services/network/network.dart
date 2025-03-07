import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/app_main_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/shared_preference.dart';

import '../connectivity_manager.dart';
import '../dio_interceptors/logging_interceptor.dart';

class Network {
  static Dio? _dio;
  static CancelToken? _cancelRequestToken;
  static Network? _network;
  static ConnectivityManager? _connectivityManager;

  Network._createInstance();

  factory Network() {
    // factory with constructor, return some value
    if (_network == null) {
      _network = Network
          ._createInstance(); // This is executed only once, singleton object
      _dio = _getDio();
      _dio?.interceptors.add(LoggingInterceptor());
      _cancelRequestToken = _getCancelToken();
      _connectivityManager = ConnectivityManager();
    }
    return _network!;
  }

  static Dio _getDio() {
    // BaseOptions options = new BaseOptions(
    //   connectTimeout: 60,
    // );
    return _dio ??= Dio();
  }

  static CancelToken _getCancelToken() {
    return _cancelRequestToken ??= CancelToken();
  }

  downloadPDF(
      {String? url,
      required String path,
      required Function() onSuccess,
      required Function() onFailure}) async {
    try {
      // Directory? appDocumentsDirectory =
      //     await getApplicationDocumentsDirectory();
      // String savePath = '${appDocumentsDirectory.path}/pdf.pdf';
      if (url != null) {
        await _dio
            ?.download(url, path)
            .then((value) => debugPrint("Downloaded"));
        onSuccess.call();
      }
    } catch (e) {
      onFailure.call();
      print('Error downloading PDF: $e');
    }
  }

  /// --------------------- Get Request ---------------------
  Future<Response?> getRequest(
      {required BuildContext context,
      required String endPoint,
      Map<String, dynamic>? queryParameters,
      VoidCallback? onFailure,
      bool isToast = true,
      bool isErrorToast = true,
      String? baseUrl,
      Duration connectTimeOut = const Duration(seconds: 60),
      required bool isHeaderRequire}) async {
    Response? response;

    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = connectTimeOut;
        response =
            await _dio!.get((baseUrl ?? NetworkStrings.API_BASE_URL) + endPoint,
                queryParameters: queryParameters,
                cancelToken: _cancelRequestToken,
                options: Options(
                  headers: _setHeader(isHeaderRequire: isHeaderRequire),
                  sendTimeout: connectTimeOut,
                  receiveTimeout: connectTimeOut,
                ));
        //print(response);
      } on DioError catch (e) {
        // log("Error:${e.response.toString()}");
        _validateException(
            response: e.response,
            context: context,
            message: e.message,
            onFailure: onFailure,
            isToast: isToast,
            isErrorToast: isErrorToast);
        print("$endPoint Dio: ${e.message}");
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }

    return response;
  }

  /// -------------------------Post Request---------------------------
  Future<Response?> postRequest({
    required BuildContext context,
    required String endPoint,
    dynamic formData,
    VoidCallback? onFailure,
    Map<String, dynamic>? data,
    bool isToast = true,
    String? baseUrl,
    Duration connectTimeOut = const Duration(seconds: 60),
    bool isErrorToast = true,
    required bool isHeaderRequire,
  }) async {
    Response? response;
    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = connectTimeOut;
        response = await _dio!.post(
            (baseUrl ?? NetworkStrings.API_BASE_URL) + endPoint,
            data: data ?? formData,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: _setHeader(isHeaderRequire: isHeaderRequire),
                sendTimeout: connectTimeOut,
                receiveTimeout: connectTimeOut));
        // print(response);
      } on DioError catch (e) {
        print("Error on Network");
        print(e);
        _validateException(
            response: e.response,
            context: context,
            message: e.message,
            onFailure: onFailure,
            isToast: isToast,
            isErrorToast: isErrorToast);
        print("$endPoint Dio: ${e.message}");
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }
    return response;
  }

  /// ---------------------------- Put Request -------------------------
  Future<Response?> putRequest(
      {required BuildContext context,
      required String endPoint,
      Map<String, dynamic>? queryParameters,
      dynamic formData,
      VoidCallback? onFailure,
      bool isToast = true,
      connectTimeOut = const Duration(seconds: 60),
      bool isErrorToast = true,
      required bool isHeaderRequire}) async {
    Response? response;

    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = connectTimeOut;
        response = await _dio!.put(
          data: formData,
          NetworkStrings.API_BASE_URL + endPoint,
          queryParameters: queryParameters,
          cancelToken: _cancelRequestToken,
          options: Options(
            headers: _setHeader(isHeaderRequire: isHeaderRequire),
            sendTimeout: connectTimeOut,
            receiveTimeout: connectTimeOut,
          ),
        );
        //print(response);
      } on DioError catch (e) {
        _validateException(
            response: e.response,
            context: context,
            message: e.message,
            onFailure: onFailure,
            isToast: isToast,
            isErrorToast: isErrorToast);
        print("$endPoint Dio: ${e.message}");
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }

    return response;
  }

  /// ----------------------------- Delete Request -----------------------
  Future<Response?> deleteRequest(
      {required BuildContext context,
      required String endPoint,
      Map<String, dynamic>? queryParameters,
      VoidCallback? onFailure,
      dynamic formData,
      bool isToast = true,
      connectTimeOut = const Duration(seconds: 60),
      bool isErrorToast = true,
      required bool isHeaderRequire}) async {
    Response? response;
    if (await _connectivityManager!.isInternetConnected()) {
      try {
        _dio?.options.connectTimeout = connectTimeOut;
        response = await _dio!.delete(NetworkStrings.API_BASE_URL + endPoint,
            queryParameters: queryParameters,
            data: formData,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: _setHeader(isHeaderRequire: isHeaderRequire),
                sendTimeout: connectTimeOut,
                receiveTimeout: connectTimeOut));
        //  print(response.toString());
      } on DioError catch (e) {
        _validateException(
            response: e.response,
            context: context,
            message: e.message,
            onFailure: onFailure,
            isToast: isToast,
            isErrorToast: isErrorToast);
        print("$endPoint Dio: ${e.message!}");
      }
    } else {
      _noInternetConnection(onFailure: onFailure);
    }
    return response;
  }

  /// ------------------------------  Set Header ---------------------------
  _setHeader({required bool isHeaderRequire}) {
    if (isHeaderRequire == true) {
      String token = SharedPreference().getBearerToken() ?? "";
      return {
        'Accept': NetworkStrings.ACCEPT,
        'Authorization': "Bearer $token",
      };
    } else {
      return {
        'Accept': NetworkStrings.ACCEPT,
      };
    }
  }

  /// ---------------------------- Validate Response -----------------------
  void validateResponse(
      {Response? response,
      VoidCallback? onSuccess,
      VoidCallback? onFailure,
      bool isToast = true}) {
    var validateResponseData = response?.data;
    print(validateResponseData);
    if (validateResponseData != null) {
      isToast
          ? AppDialogs.showToast(message: validateResponseData['message'] ?? "")
          : null;
      if (response!.statusCode == NetworkStrings.SUCCESS_CODE ||
          response.statusCode == 201) {
        if (validateResponseData['statusCode'] == NetworkStrings.SUCCESS_CODE ||
            validateResponseData['statusCode'] == 201) {
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          if (onFailure != null) {
            Logger().e("API Sucess FAILURE CODE");
            onFailure();
          }
        }
      } else {
        if (onFailure != null) {
          Logger().e("API Response FAILURE CODE");
          onFailure();
        }
      }
    }
  }

  /// --------------------------------  Stripe Validate Response -------------------
  void stripeValidateResponse(
      {Response? response, VoidCallback? onSuccess, VoidCallback? onFailure}) {
    var validateResponseData = response?.data;
    if (validateResponseData != null) {
      if (response!.statusCode == NetworkStrings.SUCCESS_CODE) {
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        if (onFailure != null) {
          onFailure();
        }
      }
    }
  }

  /// -----------------  Validate Response -----------------
  void validateGifResponse({
    Response? response,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  }) {
    var validateResponseData = response?.data;
    if (validateResponseData != null) {
      if (response!.statusCode == NetworkStrings.SUCCESS_CODE ||
          response.statusCode == 201) {
        if (onSuccess != null) {
          onSuccess();
        }
      }
    } else {
      if (onFailure != null) {
        onFailure();
      }
      //log(response!.statusCode!.toString());
    }
  }

  /// ----------------- Validate Exception -----------------
  void _validateException(
      {required BuildContext context,
      Response? response,
      String? message,
      bool normalRequest = true,
      bool isToast = true,
      bool isErrorToast = true,
      VoidCallback? onFailure}) {
    log("Response:${response.toString()}");
    if (onFailure != null) {
      onFailure();
    }
    if (response?.statusCode == NetworkStrings.CARD_ERROR_CODE) {
      AppDialogs.showToast(
          message: response?.data["error"]["message"] ??
              NetworkStrings.INVALID_CARD_ERROR);
    } else if (response?.statusCode == NetworkStrings.BAD_REQUEST_CODE) {
      //to check normal api or stripe bad request error
      if (normalRequest == true) {
        //for normal api request error
        isToast
            ? AppDialogs.showToast(
                message: (response?.data["message"] is List &&
                        response?.data["message"].isNotEmpty)
                    ? response?.data["message"][0]
                    : response?.data["message"] ?? "Unknown error occurred")
            : null;
      } else {
        //for stripe bad request error
        AppDialogs.showToast(
            message: response?.data["error"]["message"] ??
                NetworkStrings.INVALID_BANK_ACCOUNT_DETAILS_ERROR);
      }
    } else if (response?.statusCode == NetworkStrings.INTERNAL_SERVER_CODE) {
      AppDialogs.showToast(message: response?.data["message"] ?? "");
    } else if (response?.statusCode == NetworkStrings.FORBIDDEN_CODE) {
      //to check normal api or stripe bad request error
      AppDialogs.showToast(message: response?.data["message"] ?? "");
    } else {
      isErrorToast
          ? AppDialogs.showToast(
              message: response?.statusMessage ?? message.toString())
          : null;
    }
    if (response?.statusCode == NetworkStrings.UNAUTHORIZED_CODE) {
      SharedPreference().clear();
      context.read<UserProvider>().clearUserProvider();
      // context.read<GerageProvider>().clearGerageProvider();
      // context.read<ChatProvider>().clearChatProvider();

      AppNavigation.pushAndRemoveUntil(const AppMainScreen());
    }
  }

  /// ----------------- No Internet Connection -----------------
  void _noInternetConnection({VoidCallback? onFailure}) {
    if (onFailure != null) {
      onFailure();
    }
    AppDialogs.showToast(message: NetworkStrings.NO_INTERNET_CONNECTION);
  }
}
