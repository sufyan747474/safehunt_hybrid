import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/model/friend_list_model.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

class RequestWidget extends StatelessWidget {
  final FriendList? friendData;
  final dynamic Function()? confirm, delete;
  const RequestWidget({super.key, this.friendData, this.confirm, this.delete});

  @override
  Widget build(BuildContext context) {
    String currentUserId = context.read<UserProvider>().user?.id ?? '';
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
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.blackColor),
        child: Row(
          children: [
            CustomImageWidget(
                isBorder: false,
                imageUrl: friendData?.user?.id == currentUserId
                    ? friendData?.friend?.profilePhoto
                    : friendData?.user?.profilePhoto,
                borderRadius: BorderRadius.circular(50.r)),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    '${friendData?.user?.id == currentUserId ? friendData?.friend?.firstname : friendData?.user?.firstname ?? ""} ${friendData?.user?.id == currentUserId ? friendData?.friend?.lastname : friendData?.user?.lastname ?? ""}',
                    style: TextStyle(
                        fontFamily: "",
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp)),
                5.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      text: "Confirm",
                      // : .3.sw,
                      // : 13.sp,
                      // padding: EdgeInsets.symmetric(vertical: 9.h),
                      // onTap: confirm
                      //  () {
                      //   AppDialogs.showToast(
                      //       message: "Joseph Request Confirmed");
                      // },
                    ),
                    8.horizontalSpace,
                    CustomButton(
                      text: "Delete",
                      // width: .3.sw,
                      // fontSize: 13.sp,
                      // padding: EdgeInsets.symmetric(vertical: 9.h),
                      // border: Border.all(color: AppColors.PRIMARY_COLOR),
                      // bgColor: AppColors.TRANSPARENT_COLOR,
                      // onTap: delete
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
