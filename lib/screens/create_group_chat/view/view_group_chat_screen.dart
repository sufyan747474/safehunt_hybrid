import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/post/get_post_details_bloc.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/create_group_chat/bloc/delete_group_bloc.dart';
import 'package:safe_hunt/screens/create_group_chat/view/add_group_info_screen.dart';
import 'package:safe_hunt/screens/create_group_chat/view/group_member_screen.dart';
import 'package:safe_hunt/screens/drawer/add_post_screen.dart';
import 'package:safe_hunt/screens/post/post_detail_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/utils/custom_bottom_sheet.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/news_feed_card.dart';

class ViewGroupChatScreen extends StatelessWidget {
  final bool isLeadingIcon;

  const ViewGroupChatScreen({
    super.key,
    this.isLeadingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, PostProvider>(
        builder: (context, val, post, _) {
      return Scaffold(
        backgroundColor: subscriptionCardColor,
        appBar: AppBar(
          backgroundColor: appButtonColor,
          elevation: 0.0,
          // centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Transform.translate(
                offset: Offset(1.w, 0),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 23.sp,
                      color: Colors.black,
                    ))),
          ),

          titleSpacing: -3,
          // toolbarHeight: 70.h,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageWidget(
                imageUrl: post.groupDetail?.logo,
                imageHeight: 42.w,
                imageWidth: 42.w,
                borderColor: AppColors.greenColor,
                borderWidth: 1.r,
                imageAssets: AppAssets.postImagePlaceHolder,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: BigText(
                          maxLine: 2,
                          textAlign: TextAlign.start,
                          text: post.groupDetail?.name ?? '',
                          size: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: appBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

          actions: [
            if (post.groupDetail?.adminInfo?.member?.id == val.user?.id)
              IconButton(
                onPressed: () {
                  showOptionsBottomSheet(
                    context: context,
                    sheetHeight: 150.h,
                    option: [
                      buildOptionTile(
                          icon: Icons.edit,
                          title: 'Edit Group',
                          subTitle: 'Do you want to edit this group',
                          iconwidth: 15.w,
                          iconHeight: 15.w,
                          onTap: () {
                            AppNavigation.pop();
                            AppNavigation.push(AddGroupInFoScreen(
                              group: post.groupDetail,
                              isEdit: true,
                            ));
                          },
                          context: context),
                      buildOptionTile(
                          icon: Icons.delete,
                          title: 'Delete Group',
                          subTitle: 'Do you want to delete this group',
                          iconwidth: 15.w,
                          iconHeight: 15.w,
                          containsDivider: true,
                          onTap: () {
                            DeleteGroupBloc().deleteGroupBlocMethod(
                              context: context,
                              setProgressBar: () {
                                AppDialogs.progressAlertDialog(
                                    context: context);
                              },
                              groupId: post.groupDetail?.id,
                            );
                          },
                          context: context),
                      buildOptionTile(
                          icon: Icons.person,
                          title: 'Group Members',
                          subTitle: 'View all group members',
                          iconwidth: 15.w,
                          iconHeight: 15.w,
                          containsDivider: true,
                          onTap: () {
                            post.emptyGroupMember();

                            AppNavigation.pop();

                            AppNavigation.push(GroupMemberScreen(
                              groupId: post.groupDetail?.id ?? '',
                            ));
                          },
                          context: context),
                      buildOptionTile(
                          icon: Icons.edit_document,
                          title: 'Approve Post',
                          subTitle: 'Pending post for approval',
                          iconwidth: 15.w,
                          iconHeight: 15.w,
                          containsDivider: false,
                          onTap: () {},
                          context: context)
                    ],
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: GestureDetector(
                onTap: () {
                  context.read<PostProvider>().emptySelectedTagPeople();
                  context.read<PostProvider>().emptyTagPeopleList();
                  AppNavigation.push(const AddPost());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: subscriptionCardColor,
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50.w,
                        width: 50.w,
                        padding: EdgeInsets.all(10.r),
                        decoration: const BoxDecoration(
                            color: appBrownColor, shape: BoxShape.circle),
                        child: BigText(
                          text: val.user?.displayname?.isNotEmpty ?? false
                              ? val.user!.displayname![0].toUpperCase()
                              : '',
                          size: 22.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      BigText(
                        text: 'What are you thinking about?',
                        size: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: appBrownColor,
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/gallery.svg'),
                      SizedBox(
                        width: 15.w,
                      )
                    ],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImageWidget(
                      imageWidth: 1.sw,
                      imageHeight: 220.h,
                      imageAssets: AppAssets.postImagePlaceHolder,
                      shape: BoxShape.rectangle,
                      imageUrl: post.groupDetail?.cover,
                    ),
                    15.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: BigText(
                        text: 'Group Description',
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.bold,
                        size: 16.sp,
                      ),
                    ),
                    10.verticalSpace,

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: BigText(
                        text: (post.groupDetail?.description) ?? '',
                        textAlign: TextAlign.start,
                        size: 14.sp,
                      ),
                    ),
                    post.isPost == false
                        ? BigText(text: 'Post not found')
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: post.post.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: NewsFeedCard(
                                  post: post.post[index],
                                  functionOnTap: () {
                                    PostDetailBloc().postDetailBlocMethod(
                                      context: context,
                                      setProgressBar: () {
                                        AppDialogs.progressAlertDialog(
                                            context: context);
                                      },
                                      postId: post.post[index].id ?? '0',
                                      onSuccess: () {
                                        AppNavigation.push(
                                            const PostDetailScreen());
                                      },
                                    );
                                  },
                                ),
                              );
                            }),
                    // _isLoadingMore
                    //     ? const Padding(
                    //         padding: EdgeInsets.all(16.0),
                    //         child: CircularProgressIndicator(
                    //           color: appLightGreenColor,
                    //           backgroundColor: appRedColor,
                    //         ),
                    //       )
                    //     : const SizedBox.shrink(),
                    10.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        )),
      );
    });
  }
}
