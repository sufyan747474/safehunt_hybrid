import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/big_text.dart';

showOptionsBottomSheet({
  required BuildContext context,
  double? sheetHeight,
  List<Widget>? option,
}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r))),
    backgroundColor:
        AppColors.transparentColor, // Set background to transparent
    context: context,
    builder: (context) {
      return SizedBox(
        width: 1.sw,
        // height: sheetHeight ?? 75.h,
        child: BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Adjust blur intensity
          child: Container(
            decoration: BoxDecoration(
              color:
                  AppColors.whiteColor, // Adjust background color and opacity
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 134,
                  margin: const EdgeInsets.only(top: 8),
                  alignment: Alignment.center,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: appBrownColor),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: option ?? [],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildOptionTile({
  String? asset,
  required String title,
  required String subTitle,
  required double iconwidth,
  required double iconHeight,
  required Function() onTap,
  IconData? icon,
  bool isCloseIcon = false,
  bool containsDivider = true,
  required BuildContext context,
  bool isIcon = true,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isIcon
                  ? asset != null
                      ? Image.asset(
                          asset,
                          width: iconwidth,
                          height: iconHeight,
                          color: appBrownColor,
                        )
                      : Icon(
                          icon ?? Icons.photo_library,
                          color: appBrownColor,
                          weight: iconwidth,
                        )
                  : const SizedBox.shrink(),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: title,
                    size: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                  5.verticalSpace,
                  BigText(
                    text: subTitle,
                    size: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
              if (isCloseIcon) const Spacer(),
              if (isCloseIcon)
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 25.w,
                    height: 25.w,
                    padding: const EdgeInsets.all(16),
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: AppColors.errorColor,
                    //   image: DecorationImage(
                    //       image: const AssetImage(
                    //         AppAssets.close,
                    //       ),
                    //       scale: 8.w),
                    // ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          containsDivider
              ? const Padding(
                  padding: EdgeInsets.only(left: 45, right: 12),
                  child: Divider(
                    color: appBrownColor,
                    thickness: 1,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    ),
  );
}
