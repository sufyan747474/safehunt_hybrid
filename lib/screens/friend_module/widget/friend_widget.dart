import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/model/friend_list_model.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';

class FriendWidget extends StatelessWidget {
  const FriendWidget({
    super.key,
    this.friendData,
    this.unFriend,
    this.blockFriend,
  });
  final FriendList? friendData;
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
      },
      // );

      // },
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
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                        '${friendData?.user?.id == currentUserId ? friendData?.friend?.displayname : friendData?.user?.displayname ?? ""} ${friendData?.user?.id == currentUserId ? friendData?.friend?.displayname : friendData?.user?.displayname ?? ""}',
                        style: TextStyle(
                            fontFamily: "",
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp)),
                  ),
                  // const Spacer(),
                  IconButton(
                      onPressed: () {
                        // FriendModal.friendModal(
                        //     currentUserId: currentUserId,
                        //     friend: friendData,
                        //     blockFriend: blockFriend,
                        //     unFriend: unFriend);
                      },
                      // moreFunction,
                      alignment: Alignment.centerRight,
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.greenColor,
                        size: 34,
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
