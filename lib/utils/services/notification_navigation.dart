import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/shared_preference.dart';

class NotificationNavigationClass {
  // UserProvider? _userProvider;
  // UserCompleteProfile? _userProvider;
  void notificationMethod(
      {required BuildContext context,
      Map<String, dynamic>? notificationData,
      String? pushNotificationType}) async {
    _setUserSession(context: context);
    _setNotificationCount(pushNotificationType: pushNotificationType);
    if (notificationData != null) {
      log("data is $notificationData");
      log("data type is ${notificationData["type"]}");
      if (pushNotificationType == NetworkStrings.KILLED_NOTIFICATION) {
        await Future.delayed(
          const Duration(seconds: 2),
        );
      }
      // if (AppConstant. == '') {
      // ignore: use_build_context_synchronously
      handleNotification(
        context: context,
        notificationData: notificationData,
        type: notificationData["type"].toString(),
      );
      // }
    } else {
      clearAppDataMethod(context: context);
    }
  }

  void checkUserSessionMethod({required BuildContext context}) {
    // AuthSingletonUserRole authSingletonUserRole = AuthSingletonUserRole();
    log("this method calllss${SharedPreference().getUser()}");
    try {
      if (SharedPreference().getUser() != null) {
        // var splashController = Get.isRegistered()
        //     ? Get.find<SplashController>()
        //     : Get.put(SplashController());
        // var userRole = splashController.currentUser.value?.role.toString();
        // if (userRole == "Venue") {
        //   authSingletonUserRole.userRole = UserRole.Business;
        // } else if (userRole == "Guest") {
        //   authSingletonUserRole.userRole = UserRole.Guest;
        // }
      } else {
        clearAppDataMethod(context: context);
      }
    } catch (e) {
      print("error is $e");
    }
  }

  void _setUserSession({required BuildContext context}) {
    print('Set User Session');
    if (SharedPreference().getUser() != null) {
      log('Setting Role');
    }
  }

  void clearAppDataMethod({required BuildContext context}) {
    String? languageType;
  }

  void _setNotificationCount({String? pushNotificationType}) {
    //log("Push Type:${pushNotificationType}");
    if (pushNotificationType == NetworkStrings.BACKGROUND_NOTIFICATION) {}
  }

  void handleNotification({
    required String type,
    required Map<String, dynamic> notificationData,
    required BuildContext context,
  }) {
    // AuthSingletonUserRole authSingletonUserRole = AuthSingletonUserRole();
    Logger().i("type: $type notificationData: $notificationData");

    if (type == 'follow_user') {
      // context.read<PostProvider>().emptyPostDetails();
    } else if (type == 'new_order_review') {
      // AppNavigator.pushAndRemoveUntil(
      //     context,
      //     const MainScreenVendorModule(
      //       index: 4,
      //     ));
    } else if (type == 'order_completed') {
      // context.read<UserProvider>().emptyOrderList();
      // AppNavigator.push(
      //     context,
      //     const TrackPurchasesScreen(
      //       isComeFromPushNotification: true,
      //     ));
    }
  }
}
