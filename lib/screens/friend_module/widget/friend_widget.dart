import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/screens/friend_module/widget/friend_modal.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';

class FriendWidget extends StatelessWidget {
  const FriendWidget({
    super.key,
    this.friendData,
    this.unFriend,
    this.blockFriend,
  });
  final UserData? friendData;
  final void Function()? unFriend, blockFriend;

  // void moreFunction({required String currentUserId}) {
  //   FriendModal.friendModal(
  //       currentUserId: currentUserId,
  //       friend: friendData,
  //       blockFriend: blockFriend,
  //       unFriend: unFriend);
  // }

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
      },
      // );

      // },
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
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(friendData?.displayname ?? "",
                        style: TextStyle(
                            color: appBrownColor,
                            fontFamily: "",
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp)),
                  ),
                  // const Spacer(),
                  IconButton(
                      onPressed: () {
                        FriendModal.friendModal(
                            currentUserId: '1',
                            friend: friendData,
                            blockFriend: blockFriend,
                            unFriend: unFriend);
                      },
                      // moreFunction,
                      alignment: Alignment.centerRight,
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.greenColor,
                        size: 28,
                      )),
                ],
              ),
            ),

            // GestureDetector(
            //   onTap: moreFunction,
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 10.w, top: 10.w, bottom: 10.w),
            //     child: Image.asset(
            //       AppAssets.moreIcon,
            //       height: 20.h,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
