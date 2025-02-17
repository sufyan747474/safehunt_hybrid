import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:safe_hunt/screens/drawer/user_chat_screen.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import '../../../utils/colors.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/chats_card.dart';

class ChatsScreen extends StatefulWidget {
  final bool isLeadingIcon;

  const ChatsScreen({super.key, this.isLeadingIcon = true});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        bottomOpacity: 0.0,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: appButtonColor,
        leading: widget.isLeadingIcon
            ? Padding(
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
              )
            : null,
        titleSpacing: widget.isLeadingIcon ? -10 : null,
        title: BigText(
          text: 'Message',
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
          children: [
            Container(
              color: subscriptionCardColor,
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: 117.w,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: appButtonColor,
                          borderRadius: BorderRadius.circular(57.r)),
                      child: BigText(
                        text: 'Recent Chats',
                        color: appBrownColor,
                        size: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Expanded(
                    child: Container(
                      // width: 117.w,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: appBrownColor,
                          borderRadius: BorderRadius.circular(57.r)),
                      child: BigText(
                        text: 'People',
                        color: appWhiteColor,
                        size: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: appBrownColor,
                          borderRadius: BorderRadius.circular(57.r)),
                      child: BigText(
                        text: 'Message Request',
                        color: appWhiteColor,
                        size: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => const UserChat(
                          id: 'WATASHIVA NAI SHINDARUUU !!!! NANIIII!!!!!',
                        ));
                  },
                  child: const ChatsCard(
                    name: 'Henry',
                    message: 'Please take a look at the images.',
                    time: '20.00',
                    image: 'assets/profile_picture.png',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
