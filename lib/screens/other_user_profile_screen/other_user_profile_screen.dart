import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/friends/accept_reject_friend_request_bloc.dart';
import 'package:safe_hunt/bloc/friends/cancel_request_bloc.dart';
import 'package:safe_hunt/bloc/friends/get_all_friends_bloc.dart';
import 'package:safe_hunt/bloc/friends/send_friend_request_bloc.dart';
import 'package:safe_hunt/bloc/friends/unfriend_bloc.dart';
import 'package:safe_hunt/bloc/post/get_all_post_bloc.dart';
import 'package:safe_hunt/bloc/post/get_post_details_bloc.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/post/post_detail_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/big_text.dart';

import '../../utils/colors.dart';
import '../../widgets/news_feed_card.dart';
import '../../widgets/user_friends_list_card.dart';

class OtherUserProfileScreen extends StatefulWidget {
  final UserData? user;
  const OtherUserProfileScreen({super.key, this.user});

  @override
  State<OtherUserProfileScreen> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<OtherUserProfileScreen> {
  List<UserData> friend = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchFriendMethod();
      GetAllPostBloc().getAllPostBlocMethod(
        context: context,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        userId: widget.user?.id,
        onSuccess: () {},
      );
    });
  }

  void _fetchFriendMethod() {
    GetAllFriendsBloc().getAllFriendsBlocMethod(
      context: context,
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
      isLoader: false,
      userId: widget.user?.id ?? '0',
      onSuccess: (res) {
        friend = res;
        setState(() {});
      },
    );
  }

  bool pressAttentionColor = false;
  bool showDetails = false;
  List equipmentImages = [
    'assets/shot_gun.png',
    'assets/sniper_gun.png',
    'assets/sniper_two_gun.png',
    'assets/binoculars.png',
    'assets/sniper_two_gun.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, PostProvider>(
        builder: (context, val1, post, _) {
      return Scaffold(
          backgroundColor: appButtonColor,
          appBar: AppBar(
            bottomOpacity: 0.0,
            scrolledUnderElevation: 0,
            elevation: 0,
            backgroundColor: appButtonColor,
            leading: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Transform.translate(
                  offset: Offset(1.w, 0),
                  child: GestureDetector(
                      onTap: () {
                        AppNavigation.pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 23.sp,
                        color: Colors.black,
                      ))),
            ),
            titleSpacing: -10,
            title: BigText(
              text: widget.user?.displayname ?? "",
              size: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: subscriptionCardColor,
                child: Stack(
                  children: [
                    CustomImageWidget(
                      imageWidth: 1.sw,
                      imageHeight: 215.h,
                      imageUrl: widget.user?.coverPhoto,
                      imageAssets: AppAssets.postImagePlaceHolder,
                      shape: BoxShape.rectangle,
                      isBorder: false,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 160.h, left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageWidget(
                            imageWidth: 80.w,
                            imageHeight: 80.w,
                            imageUrl: widget.user?.profilePhoto,
                            isBorder: true,
                            borderWidth: 3.r,
                            borderColor: AppColors.greenColor,
                          ),
                          BigText(
                            textAlign: TextAlign.start,
                            text: widget.user?.displayname ?? '',
                            size: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: appBlackColor,
                          ),
                          Row(
                            children: [
                              BigText(
                                text: friend.length.toString(),
                                // val.friend.length.toString(),
                                size: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: appBlackColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              BigText(
                                text: 'friends',
                                size: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: appBlackColor,
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: BigText(
                              text: '“${widget.user?.bio ?? ''}”',
                              size: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: appBlackColor,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.user?.isFriend == 1
                                      ? UnfriendBloc().unfriendBlocMethod(
                                          setProgressBar: () {
                                            AppDialogs.progressAlertDialog(
                                                context: context);
                                          },
                                          context: context,
                                          userId: widget.user?.id ?? '',
                                          onSuccess: () {
                                            widget.user?.isFriend = 0;

                                            setState(() {});
                                            _fetchFriendMethod();
                                          },
                                        )
                                      : widget.user?.isRequestReceived == true
                                          ? FriendRequestUpdateBloc()
                                              .friendRequestUpdateBlocMethod(
                                                  context: context,
                                                  setProgressBar: () {
                                                    AppDialogs
                                                        .progressAlertDialog(
                                                            context: context);
                                                  },
                                                  requesterId: widget.user
                                                          ?.requestedBy?.id ??
                                                      '',
                                                  status: 'accepted',
                                                  onSuccess: (res) {
                                                    if (res == 'accepted') {
                                                      widget.user?.isFriend = 1;
                                                      widget.user?.requestedBy =
                                                          null;
                                                      widget.user
                                                              ?.isRequestSent =
                                                          false;
                                                      widget.user
                                                              ?.isRequestReceived =
                                                          false;
                                                      setState(() {});
                                                      _fetchFriendMethod();
                                                    }
                                                  })
                                          : widget.user?.isRequestSent == true
                                              ? CancelRequestBloc()
                                                  .cancelRequestBlocMethod(
                                                  context: context,
                                                  setProgressBar: () {
                                                    AppDialogs
                                                        .progressAlertDialog(
                                                            context: context);
                                                  },
                                                  requesterId: context
                                                      .read<UserProvider>()
                                                      .user
                                                      ?.id,
                                                  receipitId: widget.user?.id,
                                                  onSuccess: () {
                                                    widget.user?.isFriend = 0;
                                                    widget.user?.requestedBy =
                                                        null;
                                                    widget.user?.isRequestSent =
                                                        false;
                                                    widget.user
                                                            ?.isRequestReceived =
                                                        false;
                                                    setState(() {});
                                                  },
                                                )
                                              : SendFriendRequestBloc()
                                                  .sendFriendRequestBlocMethod(
                                                      context: context,
                                                      setProgressBar: () {
                                                        AppDialogs
                                                            .progressAlertDialog(
                                                                context:
                                                                    context);
                                                      },
                                                      userId: widget.user?.id,
                                                      onSuccess: () {
                                                        widget.user
                                                                ?.isRequestSent =
                                                            true;
                                                        widget.user
                                                                ?.requestedBy =
                                                            val1.user;
                                                        setState(() {});
                                                      });
                                },
                                child: Container(
                                  width: widget.user?.isRequestReceived == true
                                      ? 80.w
                                      : 125.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                      color: appButtonColor,
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  padding: EdgeInsets.all(5.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      (widget.user?.isRequestSent == true ||
                                              widget.user?.isRequestReceived ==
                                                  true)
                                          ? const SizedBox.shrink()
                                          : SvgPicture.asset(
                                              'assets/friends_icon.svg',
                                              width: 14.w,
                                              height: 13.81.h,
                                            ),
                                      BigText(
                                        text: widget.user?.isRequestSent == true
                                            ? 'Cancel Request'
                                            : widget.user?.isRequestReceived ==
                                                    true
                                                ? 'Accept'
                                                : widget.user?.isFriend == 0
                                                    ? "Add Friend"
                                                    : widget.user?.isFriend == 1
                                                        ? 'Unfriend'
                                                        : "Friend",
                                        size: 12.sp,
                                        color: appBrownColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (widget.user?.isRequestSent == true ||
                                  widget.user?.isRequestReceived == true) ...[
                                12.horizontalSpace,
                                InkWell(
                                  onTap: () {
                                    widget.user?.isRequestReceived == true
                                        ? FriendRequestUpdateBloc()
                                            .friendRequestUpdateBlocMethod(
                                                context: context,
                                                setProgressBar: () {
                                                  AppDialogs
                                                      .progressAlertDialog(
                                                          context: context);
                                                },
                                                requesterId: widget.user
                                                        ?.requestedBy?.id ??
                                                    '',
                                                status: 'declined',
                                                onSuccess: () {
                                                  widget.user
                                                          ?.isRequestReceived =
                                                      false;
                                                  setState(() {});
                                                })
                                        : null;
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 80.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                        color: appButtonColor,
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    padding: EdgeInsets.all(5.w),
                                    child: BigText(
                                      text: widget.user?.isRequestSent == true
                                          ? "Pending"
                                          : "Reject",
                                      size: 12.sp,
                                      color: appBrownColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                              12.horizontalSpace,
                              Container(
                                width: 125.w,
                                height: 36.h,
                                decoration: BoxDecoration(
                                    color: appBrownColor,
                                    borderRadius: BorderRadius.circular(30.r)),
                                padding: EdgeInsets.all(5.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/message_white.svg',
                                      color: Colors.white,
                                      width: 14.w,
                                      height: 14.81.h,
                                    ),
                                    BigText(
                                      text: "Message",
                                      size: 12.sp,
                                      color: appWhiteColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),
                              15.horizontalSpace,
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 83.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: subscriptionCardColor,
                          borderRadius: BorderRadius.circular(57.r)),
                      child: BigText(
                        text: 'Posts',
                        color: appBrownColor,
                        size: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showDetails = !showDetails;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 83.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: showDetails
                                ? subscriptionCardColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(57.r)),
                        child: BigText(
                          text: 'Details',
                          color: appBrownColor,
                          size: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              showDetails
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      width: MediaQuery.of(context).size.width,
                      color: subscriptionCardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: 'Hunting Experiences',
                            size: 12.sp,
                            color: appBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          BigText(
                            text:
                                '${widget.user?.huntingExperience ?? '0'} Years Hunting Experience',
                            size: 12.sp,
                            color: appBlackColor,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          BigText(
                            text: 'Skills',
                            size: 12.sp,
                            color: appBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          Wrap(spacing: 8.w, children: [
                            ...List.generate(
                                widget.user?.skills?.length ?? 0,
                                (index) => BigText(
                                      text: '#${widget.user?.skills?[index]}',
                                      size: 12.sp,
                                      color: appBlackColor,
                                      fontWeight: FontWeight.w400,
                                    )),
                          ]),
                          SizedBox(
                            height: 10.h,
                          ),
                          BigText(
                            text: 'Equipment',
                            size: 12.sp,
                            color: appBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 40.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: equipmentImages.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          equipmentImages[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              Container(
                color: subscriptionCardColor,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                // padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Friends',
                      size: 16.sp,
                      color: appBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    BigText(
                      text: '${friend.length.toString()} friends',
                      size: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: appBlackColor,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: friend.length > 6
                          ? .53.sh
                          : friend.isNotEmpty
                              ? .26.sh
                              : 0,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0.0),
                          itemCount: friend.length > 6
                              ? 6
                              : friend.length, // Limit to 6 items
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 5.0 / 9.0,
                          ),
                          itemBuilder: (BuildContext ctx, index) {
                            return UserFriendsList(
                                title: friend[index].displayname ?? '',
                                image: friend[index].profilePhoto);
                          }),
                    ),
                    // if (friend.isNotEmpty)
                    //   CustomButton(
                    //     text: 'See All Friends',
                    //     color: appButtonColor,
                    //     textColor: appBrownColor,
                    //   ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: '${widget.user?.displayname ?? ""} posts',
                      size: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              ListView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: post.userpost.length,
                  itemBuilder: (BuildContext context, index) {
                    return NewsFeedCard(
                      profileOntap: false,
                      post: post.userpost[index],
                      functionOnTap: () {
                        PostDetailBloc().postDetailBlocMethod(
                          context: context,
                          setProgressBar: () {
                            AppDialogs.progressAlertDialog(context: context);
                          },
                          postId: post.userpost[index].id ?? '0',
                          onSuccess: () {
                            AppNavigation.push(const PostDetailScreen());
                          },
                        );
                      },
                    );
                  }),

              //
              // Container(height: 100, color: Colors.green),
              //         Container(height: 100, color: Colors.yellow),
              //         Container(height: 100, color: Colors.blue),
            ],
          )));
    });
  }
}
