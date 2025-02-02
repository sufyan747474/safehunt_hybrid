import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';

class AppDialogs {
  static void showToast({String? message}) {
    Fluttertoast.showToast(
      msg: message ?? "",
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.blackColor,
    );
  }

  //circular progress dialog
  static void progressAlertDialog({required BuildContext context}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const Center(
              child: CircularProgressIndicator(
                color: appLightGreenColor,
                backgroundColor: appRedColor,
              ),
            ),
          );
        });
  }

  // Future showCustomConfirmationDialog(context,
  //     {String? title,
  //     String? description,
  //     final bool showCross = true,
  //     dynamic Function()? onTapCross,
  //     dynamic Function()? onTapButton}) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       // barrierColor: AppColors.brownColor.withOpacity(0.8),
  //       builder: (context) {
  //         return PopScope(
  //           canPop: false,
  //           child: CustomSuccessfulDialog(
  //             title: title,
  //             description: description,
  //             onTapCross: onTapCross,
  //             onTapButton: onTapButton,
  //             showCross: showCross,
  //           ),
  //         );
  //       });
  // }

  // Future showDeleteCardDialog({context, Function()? onTapYes, String? desc}) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return CustomConfirmDialog(onTapYes: onTapYes, description: desc);
  //       });
  // }

  // Future showInformationDialog({required BuildContext context}) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return SlotInformationDialog();
  //       });
  // }
}
