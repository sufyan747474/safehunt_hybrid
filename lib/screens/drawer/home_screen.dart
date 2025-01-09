import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:safe_hunt/screens/drawer/add_post_screen.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/news_feed_card.dart';
import '../journals/hunting_journal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showComments = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leadingWidth: 85.w,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
            child: Transform.translate(
              offset: Offset(20.w, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: appLightGreenColor,
                  borderRadius: BorderRadius.all(Radius.circular(38)),
                ),
                child: SvgPicture.asset('assets/hamburg_icon.svg',
                    color: Colors.white, fit: BoxFit.scaleDown),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(HuntingJournalScreen());
              },
              child: SizedBox(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  width: 70.w,
                  height: 35.h,
                  decoration: const BoxDecoration(
                    color: appBrownColor,
                    borderRadius: BorderRadius.all(Radius.circular(38)),
                  ),
                  child: SvgPicture.asset(
                    'assets/solar_notes-bold.svg',
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: 70.w,
                height: 35.h,
                decoration: const BoxDecoration(
                  color: appButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(38)),
                ),
                child: SvgPicture.asset(
                  'assets/light_add.svg',
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              child: Container(
                // padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 7.w),
                width: 70.w,
                height: 35.h,
                decoration: const BoxDecoration(
                  color: appRedColor,
                  borderRadius: BorderRadius.all(Radius.circular(38)),
                ),
                child: BigText(
                  text: 'SOS',
                  size: 20.sp,
                  color: appWhiteColor,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
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
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const NewsFeedCard(),
                    );
                  }),
            ),
            const SizedBox(
              height: 13,
            ),
          ],
        ),
      )),
    );
  }
}
