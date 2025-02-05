import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:safe_hunt/screens/edit_profile_screen.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

import '../../utils/colors.dart';
import '../../widgets/news_feed_card.dart';
import '../../widgets/user_friends_list_card.dart';
import 'add_post_screen.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 23.sp,
                      color: Colors.black,
                    ))),
          ),
          titleSpacing: -10,
          title: BigText(
            text: 'Henry',
            size: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 60.w,
                height: 30.h,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: subscriptionCardColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                child: SvgPicture.asset(
                  'assets/search_icon.svg',
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: subscriptionCardColor,
              child: Stack(
                children: [
                  Container(
                    child: Image.asset('assets/post_picture.png',
                        fit: BoxFit.cover),
                    height: 215.h,
                    width: double.infinity,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 150.h, left: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: appLightGreenColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(68.r)),
                                border: Border.all(
                                    color: appLightGreenColor, width: 3.w),
                              ),
                              child: Image.asset(
                                'assets/profile_picture.png',
                                // height: 120.h,
                                // width: 120.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            BigText(
                              text: 'Henry',
                              size: 22.sp,
                              fontWeight: FontWeight.w700,
                              color: appBlackColor,
                            ),
                            Row(
                              children: [
                                BigText(
                                  text: '59',
                                  size: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: appBlackColor,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                BigText(
                                  text: 'mutual friends',
                                  size: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: appBlackColor,
                                )
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: BigText(
                                text:
                                    '“The search for a scapegoat is the easiest of all hunting expeditions.”',
                                size: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: appBlackColor,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   likePost = !likePost;
                                      // });
                                    },
                                    child: Container(
                                      width: 125.w,
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
                                          SvgPicture.asset(
                                            'assets/friends_icon.svg',
                                            width: 14.w,
                                            height: 13.81.h,
                                          ),
                                          BigText(
                                            text: "Friends",
                                            size: 12.sp,
                                            color: appBrownColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Container(
                                    width: 125.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                        color: appBrownColor,
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
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
                                  IconButton(
                                      onPressed: () {
                                        AppNavigation.push(
                                            const EditProfileScreen());
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: appBrownColor,
                                      ))

                                  // Container(
                                  //   // width: 62.w,
                                  //   // height: 35.h,
                                  //   decoration: BoxDecoration(
                                  //       color: appButtonColor,
                                  //       borderRadius:
                                  //           BorderRadius.circular(57.r)),
                                  //   padding: EdgeInsets.all(15.w),
                                  //   child: SvgPicture.asset(
                                  //     'assets/horizontal_dots_icon.svg',
                                  //     color: appBrownColor,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            )
                          ],
                        ),
                      ),
                    ],
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
                  Container(
                    alignment: Alignment.center,
                    width: 83.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(57.r)),
                    child: BigText(
                      text: 'Photos',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                          text: '5 Years Hunting Experience',
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
                        BigText(
                          text: '#Loremipsum #Loremipsum #Loremipsum ',
                          size: 12.sp,
                          color: appBlackColor,
                          fontWeight: FontWeight.w400,
                        ),
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
                    text: '59 mutual friends',
                    size: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: appBlackColor,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1 - 350,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0.0),
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 5.0 / 9.0,
                        ),
                        itemBuilder: (BuildContext ctx, index) {
                          return const UserFriendsList(
                            title: 'Akari Edward ',
                            image:
                                "https://images.unsplash.com/photo-1497316730643-415fac54a2af?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
                          );
                        }),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    text: 'See All Friends',
                    color: appButtonColor,
                    textColor: appBrownColor,
                  ),
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
                    text: 'Henry’s posts',
                    size: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const AddPost());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: subscriptionCardColor,
                        borderRadius: BorderRadius.all(Radius.circular(30.r)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: appBrownColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: BigText(
                              text: 'W',
                              size: 20.sp,
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
                itemCount: 3,
                itemBuilder: (BuildContext context, index) {
                  return const NewsFeedCard();
                }),

            //
            // Container(height: 100, color: Colors.green),
            //         Container(height: 100, color: Colors.yellow),
            //         Container(height: 100, color: Colors.blue),
          ],
        )));
  }
}
