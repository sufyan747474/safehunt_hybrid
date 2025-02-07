import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_hunt/utils/utils.dart';

import '../screens/drawer/profile_tab.dart';
import '../utils/colors.dart';
import 'big_text.dart';

class NewsFeedCard extends StatelessWidget {
  final void Function()? functionOnTap;
  final bool isPostDetails;

  const NewsFeedCard(
      {super.key, this.functionOnTap, this.isPostDetails = false});

  // bool showPostComments = false;

  // bool likePost = false;

  @override
  Widget build(BuildContext context) {
    log('message');
    return Container(
      // padding: EdgeInsets.all(10.w),
      width: MediaQuery.of(context).size.width,
      color: subscriptionCardColor,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 15.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(ProfileTab());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: appLightGreenColor,
                          borderRadius: BorderRadius.all(Radius.circular(38)),
                          border:
                              Border.all(color: appLightGreenColor, width: 2.w),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: Image.asset(
                              'assets/profile_picture.png',
                              height: 50.h,
                              width: 50.w,
                            )),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: "Henry",
                            size: 17.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          FutureBuilder(
                              future: Utils.getLocationFromLatLng(
                                  lat: 24.8970, lng: 67.2136),
                              builder: (context, snapShot) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BigText(
                                      text: '1h',
                                      size: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    SvgPicture.asset(
                                        'assets/post_location_icon.svg'),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    BigText(
                                      text: snapShot.data.toString(),
                                      // Utils.getLocationFromLatLng(
                                      //     lat: 24.8970, lng: 67.2136),
                                      // "Sierra National Forest",
                                      size: 10.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                );
                              })
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.more_vert),
                    SizedBox(
                      height: 7.h,
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 23.w,
            ),
            child: BigText(
              text: 'Embracing the wild, one hunt at a time. #DeerSeason 🦌🌿',
              size: 12.sp,
              color: appBrownColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Image.asset('assets/post_picture.png',
              height: 331.h,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover),
          // Image.network(
          //   "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60",
          //   height: 331.h,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(
            height: 5.h,
          ),
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
                  BigText(
                    text: " Robert and 214 Other",
                    size: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  Spacer(),
                  BigText(
                    text: " 25",
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
          // showPostComments
          //     ? Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBox(
          //             height: 8.w,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.symmetric(horizontal: 20.w),
          //             child: Row(
          //               children: [
          //                 BigText(
          //                   text: 'All Comments',
          //                   size: 12.sp,
          //                   color: appBlackColor,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //                 SizedBox(
          //                   width: 10.w,
          //                 ),
          //                 const Icon(
          //                   Icons.keyboard_arrow_down_rounded,
          //                   weight: 0.3,
          //                   color: appBlackColor,
          //                 )
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 200.h,
          //             child: ListView.builder(
          //                 itemCount: 3,
          //                 itemBuilder: (BuildContext context, index) {
          //                   return const Padding(
          //                     padding: EdgeInsets.all(8.0),
          //                     child: PostComment(
          //                       time: '9:00AM',
          //                       postComment:
          //                           'Impressive harvest! How was the experience out in the wild?',
          //                       profileName: 'Henry',
          //                       profileImage: 'assets/subscription_picture.png',
          //                       likeCount: 1,
          //                     ),
          //                   );
          //                 }),
          //           ),
          //         ],
          //       )
          //     : SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   likePost = !likePost;
                    // });
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
                        // likePost
                        //     ?
                        // SvgPicture.asset('assets/like_color_icon.svg')
                        // :
                        SvgPicture.asset('assets/icons_like.svg'),
                        BigText(
                          text: "Like",
                          size: 10.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: functionOnTap,
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
                Spacer(),
                Container(
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
}
