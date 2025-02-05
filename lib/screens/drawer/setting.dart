import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:safe_hunt/screens/edit_profile_screen.dart';
import 'package:safe_hunt/screens/new_password_screen.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/drawer_card.dart';
import '../../widgets/setting_card.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool switchToggle = false;
  bool switchToggleTwo = false;

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
          text: 'Settings',
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
        child: Container(
          color: subscriptionCardColor,
          child: Column(
            children: [
              DrawerCard(
                label: 'Account',
                svgPicture: 'assets/profile_icon.svg',
                color: appBrownColor,
                fontWeight: FontWeight.w700,
                size: 16.sp,
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              SettingCard(
                label: 'Edit Profile',
                svgPicture: 'assets/Arrow_right.svg',
                onTap: () {
                  AppNavigation.push(const EditProfileScreen());
                },
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              SettingCard(
                onTap: () {
                  AppNavigation.push(const NewPasswordScreen(
                    isChangePassword: true,
                  ));
                },
                label: 'Change Password',
                svgPicture: 'assets/Arrow_right.svg',
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              SettingCard(
                label: 'Block',
                svgPicture: 'assets/Arrow_right.svg',
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              DrawerCard(
                label: 'Account',
                svgPicture: 'assets/notification_fill_brown.svg',
                color: appBrownColor,
                fontWeight: FontWeight.w700,
                size: 16.sp,
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Notifications',
                      color: appBrownColor,
                      size: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    Spacer(),

                    Transform.scale(
                      scale: 0.7,
                      // scaleX: 0.7,
                      //  scaleY: 0.7,
                      child: CupertinoSwitch(
                        // This bool value toggles the switch.
                        value: switchToggle,
                        thumbColor: switchToggle
                            ? appLightGreenColor
                            : inactiveSwitchColor,
                        activeColor: inactiveTrackColor,
                        trackColor: inactiveSwitchColor,
                        onChanged: (bool? value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            switchToggle = value ?? false;
                          });
                        },
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    // Container(
                    //   height: 1,
                    //   width: MediaQuery.of(context).size.width ,
                    //   color: Colors.grey,
                    // )
                  ],
                ),
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'App Notifications',
                      color: appBrownColor,
                      size: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 0.7,
                      // scaleX: 0.7,
                      //  scaleY: 0.7,
                      child: CupertinoSwitch(
                        // This bool value toggles the switch.
                        value: switchToggleTwo,
                        thumbColor: switchToggleTwo
                            ? appLightGreenColor
                            : inactiveSwitchColor,
                        activeColor: inactiveTrackColor,
                        trackColor: inactiveSwitchColor,
                        onChanged: (bool? value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            switchToggleTwo = value ?? false;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              DrawerCard(
                label: 'About App',
                svgPicture: 'assets/notification_fill_brown.svg',
                color: appBrownColor,
                fontWeight: FontWeight.w700,
                size: 16.sp,
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              SettingCard(
                label: 'Terms & Conditions',
                svgPicture: 'assets/Arrow_right.svg',
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              SettingCard(
                label: 'Privacy Policy',
                svgPicture: 'assets/Arrow_right.svg',
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              SettingCard(
                label: 'Rate Our App',
                svgPicture: 'assets/Arrow_right.svg',
              ),
              const Divider(
                color: appBrownColor,
                thickness: 0.3,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: CustomButton(
                    text: 'Logout',
                    color: appButtonColor,
                    textColor: appBrownColor,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: 85.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
