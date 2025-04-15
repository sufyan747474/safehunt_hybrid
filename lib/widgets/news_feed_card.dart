import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/auth/get_user_profile_bloc.dart';
import 'package:safe_hunt/bloc/block_user/block_user_bloc.dart';
import 'package:safe_hunt/bloc/post/delete_post_bloc.dart';
import 'package:safe_hunt/bloc/post/like_unlike_post_bloc.dart';
import 'package:safe_hunt/bloc/post/post_share_bloc.dart';
import 'package:safe_hunt/bloc/post/report_post_bloc.dart';
import 'package:safe_hunt/bloc/post/update_post_status_bloc.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/drawer/add_post_screen.dart';
import 'package:safe_hunt/screens/other_user_profile_screen/other_user_profile_screen.dart';
import 'package:safe_hunt/screens/post/model/post_model.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/utils/custom_bottom_sheet.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

import '../utils/colors.dart';
import 'big_text.dart';

class NewsFeedCard extends StatelessWidget {
  final void Function()? functionOnTap;
  final bool isPostDetails;
  final PostData? post;
  final bool profileOntap;
  final String? groupId;

  const NewsFeedCard(
      {super.key,
      this.groupId,
      this.functionOnTap,
      this.isPostDetails = false,
      this.post,
      this.profileOntap = true});

  // bool showPostComments = false;

  // bool likePost = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.w),
      width: 1.sw,
      color: subscriptionCardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post?.sharedUserId != 'null') ...[
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: profileOntap
                              ? () {
                                  (post?.sharedUserId !=
                                          context.read<UserProvider>().user?.id)
                                      ? GetUserProfileBloc()
                                          .userProfileBlocMethod(
                                          context: context,
                                          setProgressBar: () {
                                            AppDialogs.progressAlertDialog(
                                                context: context);
                                          },
                                          userId: post?.sharedUserId,
                                          onSuccess: (res) {
                                            context
                                                .read<PostProvider>()
                                                .emptyUserPost();
                                            AppNavigation.push(
                                                OtherUserProfileScreen(
                                              user: res,
                                            ));
                                          },
                                        )
                                      : null;
                                }
                              : null,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: CustomImageWidget(
                              imageUrl: post?.sharedUser?.profilePhoto,
                              imageHeight: 40.w,
                              imageWidth: 40.w,
                              borderColor: AppColors.greenColor,
                              borderWidth: 2.r,
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: BigText(
                                  textAlign: TextAlign.start,
                                  text: post?.sharedUser?.displayname ?? "",
                                  size: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              // SizedBox(
                              //   height: 5.h,
                              // ),
                              // Flexible(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisSize: MainAxisSize.min,
                              //     children: [
                              //       Flexible(
                              //         child: BigText(
                              //           textAlign: TextAlign.start,
                              //           text: Utils.getDayFromDateTime(
                              //               post?.createdAt ??
                              //                   DateTime.now().toString()),
                              //           size: 10.sp,
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.black87,
                              //           overflow: TextOverflow.visible,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  Visibility(
                    visible: post?.sharedUserId !=
                        context.read<UserProvider>().user?.id,
                    child: IconButton(
                      onPressed: () {
                        showOptionsBottomSheet(
                            context: context,
                            sheetHeight: 150.h,
                            option: [
                              buildOptionTile(
                                  icon: Icons.report,
                                  title: 'Report Post',
                                  subTitle: 'Do you want to report this post',
                                  iconwidth: 15.w,
                                  iconHeight: 15.w,
                                  onTap: () {
                                    ReportPostBloc().reportPostBlocMethod(
                                        context: context,
                                        setProgressBar: () {
                                          AppDialogs.progressAlertDialog(
                                              context: context);
                                        },
                                        postId: post?.id,
                                        onSuccess: () {
                                          AppNavigation.pop();
                                        });
                                  },
                                  context: context),
                              buildOptionTile(
                                  icon: Icons.block,
                                  title: 'Block User',
                                  subTitle: 'Do you want to block this user',
                                  iconwidth: 15.w,
                                  iconHeight: 15.w,
                                  containsDivider: false,
                                  onTap: () {
                                    BlockUserBloc().blockUserBlocMethod(
                                        context: context,
                                        setProgressBar: () {
                                          AppDialogs.progressAlertDialog(
                                              context: context);
                                        },
                                        userId: post?.sharedUserId,
                                        onSuccess: () {
                                          AppNavigation.pop();
                                        });
                                  },
                                  context: context)
                            ]);
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: appBrownColor,
              height: 15.h,
            ),
            5.verticalSpace,
          ],
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: profileOntap
                            ? () {
                                context.read<UserProvider>().user?.id !=
                                        post?.userId
                                    ? GetUserProfileBloc()
                                        .userProfileBlocMethod(
                                        context: context,
                                        setProgressBar: () {
                                          AppDialogs.progressAlertDialog(
                                              context: context);
                                        },
                                        userId: post?.userId,
                                        onSuccess: (res) {
                                          context
                                              .read<PostProvider>()
                                              .emptyUserPost();
                                          AppNavigation.push(
                                              OtherUserProfileScreen(
                                            user: res,
                                          ));
                                        },
                                      )
                                    : null;
                              }
                            : null,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: CustomImageWidget(
                            imageUrl: post?.user?.profilePhoto,
                            imageHeight: 50.w,
                            imageWidth: 50.w,
                            borderColor: AppColors.greenColor,
                            borderWidth: 2.r,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: BigText(
                                textAlign: TextAlign.start,
                                text: post?.user?.displayname ?? "",
                                size: 17.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: BigText(
                                      textAlign: TextAlign.start,
                                      text: Utils.getDayFromDateTime(
                                          post?.createdAt ??
                                              DateTime.now().toString()),
                                      size: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  FutureBuilder(
                                      future: Utils.getLocationFromLatLng(
                                          lat: double.tryParse(
                                                  post?.latitude ?? '0.0') ??
                                              0.0,
                                          lng: double.tryParse(
                                                  post?.longitude ?? '0.0') ??
                                              0.0),
                                      builder: (context, snapShot) {
                                        return Flexible(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/post_location_icon.svg'),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Flexible(
                                                child: BigText(
                                                  textAlign: TextAlign.start,
                                                  text:
                                                      snapShot.connectionState ==
                                                              ConnectionState
                                                                  .waiting
                                                          ? ''
                                                          : snapShot.data
                                                              .toString(),
                                                  // Utils.getLocationFromLatLng(
                                                  //     lat: 24.8970, lng: 67.2136),
                                                  // "Sierra National Forest",
                                                  size: 10.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                10.horizontalSpace,
                Visibility(
                  visible:
                      post?.sharedUserId == 'null' && post?.status != 'pending',
                  child: IconButton(
                    onPressed: () {
                      showOptionsBottomSheet(
                          context: context,
                          sheetHeight: 150.h,
                          option: [
                            if (post?.user?.id ==
                                context.read<UserProvider>().user?.id) ...[
                              buildOptionTile(
                                  icon: Icons.edit,
                                  title: 'Edit Post',
                                  subTitle: 'Do you want to edit this post',
                                  iconwidth: 15.w,
                                  iconHeight: 15.w,
                                  onTap: () {
                                    AppNavigation.pushReplacement(AddPost(
                                      isEdit: true,
                                      post: post,
                                      groupId: groupId,
                                    ));
                                  },
                                  context: context),
                              buildOptionTile(
                                  icon: Icons.delete,
                                  title: 'Delete Post',
                                  subTitle: 'Do you want to delete this post',
                                  iconwidth: 15.w,
                                  iconHeight: 15.w,
                                  containsDivider: false,
                                  onTap: () {
                                    DeletePostBloc().deletePostBlocMethod(
                                      context: context,
                                      setProgressBar: () {
                                        AppDialogs.progressAlertDialog(
                                            context: context);
                                      },
                                      groupId: groupId ?? "",
                                      postId: post?.id ?? "",
                                      onSuccess: () {
                                        isPostDetails
                                            ? AppNavigation.pop()
                                            : null;
                                        AppNavigation.pop();
                                      },
                                    );
                                  },
                                  context: context)
                            ],
                            if (post?.user?.id !=
                                context.read<UserProvider>().user?.id) ...[
                              buildOptionTile(
                                  icon: Icons.report,
                                  title: 'Report Post',
                                  subTitle: 'Do you want to report this post',
                                  iconwidth: 15.w,
                                  iconHeight: 15.w,
                                  onTap: () {
                                    ReportPostBloc().reportPostBlocMethod(
                                        context: context,
                                        setProgressBar: () {
                                          AppDialogs.progressAlertDialog(
                                              context: context);
                                        },
                                        postId: post?.id,
                                        onSuccess: () {
                                          AppNavigation.pop();
                                        });
                                  },
                                  context: context),
                              buildOptionTile(
                                  icon: Icons.block,
                                  title: 'Block User',
                                  subTitle: 'Do you want to block this user',
                                  iconwidth: 15.w,
                                  iconHeight: 15.w,
                                  containsDivider: false,
                                  onTap: () {
                                    BlockUserBloc().blockUserBlocMethod(
                                        context: context,
                                        setProgressBar: () {
                                          AppDialogs.progressAlertDialog(
                                              context: context);
                                        },
                                        userId: post?.user?.id,
                                        onSuccess: () {
                                          AppNavigation.pop();
                                        });
                                  },
                                  context: context)
                            ],
                          ]);
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
                // SizedBox(
                //   height: 1.h,
                // )
              ],
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 23.w,
            ),
            child: BigText(
              textAlign: TextAlign.start,
              text: '${post?.description ?? ''} 🦌🌿',
              size: 12.sp,
              color: appBrownColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.verticalSpace,
          CustomImageWidget(
            imageWidth: 1.sw,
            imageHeight: 330.h,
            imageUrl: post?.image,
            shape: BoxShape.rectangle,
            isBorder: false,
            imageAssets: AppAssets.postImagePlaceHolder,
          ),
          // Image.asset('assets/post_picture.png',
          //     height: 331.h,
          //     width: MediaQuery.of(context).size.width,
          //     fit: BoxFit.cover),
          // Image.network(
          //   "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60",
          //   height: 331.h,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(
            height: 5.h,
          ),
          if (post?.status == 'pending')
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        _updatePostStatus(context, 'approved');
                      },
                      text: 'Approve',
                      color: AppColors.greenColor,
                      textColor: AppColors.whiteColor,
                    ),
                  ),
                  15.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        _updatePostStatus(context, 'declssined');
                      },
                      text: 'Decline',
                      color: appBrownColor,
                      textColor: AppColors.whiteColor,
                    ),
                  )
                ],
              ),
            ),
          if (post?.status != 'pending')
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  // setState(() {
                  //   showPostComments = !showPostComments;
                  // });
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/like_color_icon.svg',
                      width: 16,
                    ),
                    5.horizontalSpace,
                    BigText(
                      text: post?.likesCount ?? '0',
                      size: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    const Spacer(),
                    BigText(
                      text: post?.comments?.length.toString() ?? '0',
                      size: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    BigText(
                      text: "Comments",
                      size: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          if (post?.status != 'pending')
            SizedBox(
              height: 10.h,
            ),
          if (post?.status != 'pending')
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: post?.status != 'pending'
                        ? () {
                            LikeUnlikePostBloc().likeUnlikePostBlocMethod(
                              context: context,
                              setProgressBar: () {
                                AppDialogs.progressAlertDialog(
                                    context: context);
                              },
                              postId: post?.id,
                            );
                            // setState(() {
                            //   likePost = !likePost;
                            // });
                          }
                        : null,
                    child: Container(
                      width: 117.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: appButtonColor,
                          borderRadius: BorderRadius.circular(30.r)),
                      padding: EdgeInsets.all(5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // likePost
                          //     ?
                          // SvgPicture.asset('assets/like_color_icon.svg')
                          // :

                          SvgPicture.asset(
                            'assets/icons_like.svg',
                            color: post?.postLiked == true
                                ? AppColors.redColor
                                : null,
                          ),
                          BigText(
                            text: post?.postLiked == true ? "Liked" : "Like",
                            size: 10.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: post?.status != 'pending' ? functionOnTap : null,
                    child: Container(
                      width: 117.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: appButtonColor,
                          borderRadius: BorderRadius.circular(30.r)),
                      padding: EdgeInsets.all(5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/icon_comment.svg'),
                          BigText(
                            text: "Comment",
                            size: 10.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      PostShareBloc().postShareBlocMethod(
                        context: context,
                        setProgressBar: () {
                          AppDialogs.progressAlertDialog(context: context);
                        },
                        postId: post?.id,
                      );
                    },
                    child: Container(
                      width: 117.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: appButtonColor,
                          borderRadius: BorderRadius.circular(30.r)),
                      padding: EdgeInsets.all(5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/icons_share.svg'),
                          BigText(
                            text: "Share",
                            size: 10.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }

  void _updatePostStatus(BuildContext context, String status) {
    UpdatePostStatusBloc().updatePostStatusBlocMethod(
        context: context,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        groupId: groupId,
        postId: post?.id,
        status: status);
  }
}
