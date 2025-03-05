import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

class RequestWidget extends StatelessWidget {
  final UserData? friendData;
  final dynamic Function()? confirm, delete;
  const RequestWidget({super.key, this.friendData, this.confirm, this.delete});

  @override
  Widget build(BuildContext context) {
    // String currentUserId = context.read<UserProvider>().user?.id ?? '';
    return GestureDetector(
      onTap: () {
        // GetOtherUserProfileBloc().getOtherUserProfileBlocMethod(
        //   context: context,
        //   setProgressBar: () {
        //     AppDialogs.progressAlertDialog(context: context);
        //   },
        //   userId: friendData?.user?.id == currentUserId
        //       ? friendData?.friend?.id
        //       : friendData?.user?.id,
        //   onSuccess: (res) {
        //     AppNavigation.navigateTo(AppRouteName.OTHER_USER_SCREEN_ROUTE,
        //         arguments: OtherUserScreenArguments(
        //           user: res,
        //           coverPhoto: res.profilePictureUrl,
        //           title: "${res.firstName} ${res.lastName}",
        //         ));
        //   },
        // );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.r),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.whiteColor.withOpacity(.5)),
        child: Row(
          children: [
            CustomImageWidget(
              imageWidth: 50.w,
              imageHeight: 50.w,
              borderColor: appBrownColor,
              borderWidth: 1.r,
              imageUrl: friendData?.profilePhoto,
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(friendData?.displayname ?? '',
                    style: TextStyle(
                        color: appBrownColor,
                        fontFamily: "",
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp)),
                5.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                        text: "Accept",
                        height: 30.w,
                        color: AppColors.greenColor,
                        textColor: AppColors.whiteColor,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        onTap: confirm
                        //  () {
                        //   AppDialogs.showToast(
                        //       message: "Joseph Request Confirmed");
                        // },
                        ),
                    8.horizontalSpace,
                    CustomButton(
                        text: "Reject",
                        height: 30.w,
                        color: AppColors.greenColor,
                        textColor: AppColors.whiteColor,
                        // width: .3.sw,
                        // fontSize: 13.sp,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),

                        // border: Border.all(color: AppColors.PRIMARY_COLOR),
                        // bgColor: AppColors.TRANSPARENT_COLOR,
                        onTap: delete
                        //  () {
                        //   AppDialogs.showToast(message: "Joseph Request Deleted");
                        // },
                        ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
