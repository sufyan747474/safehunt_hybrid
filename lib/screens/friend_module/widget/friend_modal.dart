import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/static_data.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';

class FriendModal {
  static void friendModal(
      {UserData? friend,
      void Function()? unFriend,
      blockFriend,
      String? currentUserId}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: StaticData.navigatorKey.currentContext!,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: .3.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                    color: appButtonColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: .06.sw),
                  child: Column(
                    children: [
                      8.verticalSpace,
                      Container(
                          width: 70.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: appBrownColor,
                              borderRadius: BorderRadius.circular(10.r))),
                      15.verticalSpace,
                      Row(
                        children: [
                          CustomImageWidget(
                            imageWidth: 50.w,
                            imageHeight: 50.w,
                            borderColor: appBrownColor,
                            borderWidth: 1.r,
                            imageUrl: friend?.profilePhoto,
                          ),
                          10.horizontalSpace,
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                      "Name : ${friend?.displayname ?? ""}",
                                      style: TextStyle(
                                          color: appBrownColor,
                                          overflow: TextOverflow.visible,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold)),
                                ),
                                10.verticalSpace,
                                // Flexible(
                                //   child: Text(
                                //       'Friends since ${Utils.formattedDate(formatPattern: 'MMM yyyy', date: friend?.createdAt ?? DateTime.now().toString())}',
                                //       // "Friends since July 2022",
                                //       style: AppTextStyles.customtextStyle(
                                //           overflow: TextOverflow.visible,
                                //           fontSize: 14.sp,
                                //           fontWeight: FontWeight.bold)),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                      25.verticalSpace,
                      GestureDetector(
                        onTap: blockFriend,
                        //  () {
                        //   AppNavigation.navigatorPop();
                        //   AppDialogs.showToast(
                        //       message: "Jake Blocked Successfully");
                        // },
                        child: _button(
                            icon: Icons.block_outlined,
                            title: "Block",
                            // ${friend?.user?.id == currentUserId ? friend?.friend?.firstName : friend?.user?.firstName ?? ""}
                            // ",
                            desc: 'Are you sure you want to block this user?'),
                      ),
                      20.verticalSpace,
                      GestureDetector(
                        onTap: unFriend,
                        //  () {
                        //   AppNavigation.navigatorPop();
                        //   AppDialogs.showToast(
                        //       message: "Jake Unfriended Successfully");
                        // },
                        child: _button(
                            icon: Icons.person_remove_outlined,
                            title: "Unfriend ",
                            // ${friend?.user?.id == currentUserId ? friend?.friend?.firstName : friend?.user?.firstName ?? ""}",
                            desc:
                                'Are you sure you want to unfriend this user?'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  static Widget _button({IconData? icon, String? title, String? desc}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration:
              const BoxDecoration(color: appBrownColor, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.whiteColor),
        ),
        15.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? "",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: appBrownColor),
              ),
              3.verticalSpace,
              Text(
                desc ?? "",
                style: TextStyle(
                    color: appBrownColor,
                    overflow: TextOverflow.visible,
                    fontSize: 12.sp,
                    height: 1.2.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
