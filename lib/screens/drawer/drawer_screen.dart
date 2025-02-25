import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/auth/get_content_bloc.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/app_main_screen.dart';
import 'package:safe_hunt/screens/content/content_screen.dart';
import 'package:safe_hunt/screens/drawer/map_screen.dart';
import 'package:safe_hunt/screens/drawer/profile_tab.dart';
import 'package:safe_hunt/screens/drawer/setting.dart';
import 'package:safe_hunt/screens/friend_module/friend_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/services/shared_preference.dart';
import '../../widgets/big_text.dart';
import '../../widgets/drawer_card.dart';
import '../chats/chat_screen.dart';
import 'notification_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, val, _) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.green[300]?.withOpacity(0.4),
          // height: MediaQuery.of(context).size.height ,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: appLightGreenColor,
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: Colors.grey),
                    )),
                height: 236.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Get.to(EditProfileScreen());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.w,
                            width: 50.w,
                            padding: EdgeInsets.all(10.r),
                            decoration: const BoxDecoration(
                                color: appButtonColor, shape: BoxShape.circle),
                            child: BigText(
                              textAlign: TextAlign.center,
                              text: val.user?.displayname?.isNotEmpty ?? false
                                  ? val.user!.displayname![0].toUpperCase()
                                  : '',
                              size: 22.sp,
                              fontWeight: FontWeight.w900,
                              color: appBrownColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 21,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    BigText(
                      text: val.user?.displayname ?? '',
                      color: appWhiteColor,
                      size: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 0.h,
                    )
                  ],
                ),
              ),
              // const Spacer(),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 1.03,
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              AppNavigation.push(const ProfileTab());
                            },
                            child: DrawerCard(
                              label: "My profile",
                              svgPicture: 'assets/profile_white.svg',
                            )),
                        const Divider(
                          color: Colors.grey,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            AppNavigation.push(const NotificationScreen());
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/push_notification_white.svg',
                            label: "Notification",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            AppNavigation.push(const FriendScreen());
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/message_white.svg',
                            label: "Friend",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            AppNavigation.pop();
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/feed_white.svg',
                            label: "Feed",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            AppNavigation.push(const ChatsScreen());
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/message_white.svg',
                            label: "Messages",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const MapScreen());
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/Mask group (4).svg',
                            label: "Map",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            AppNavigation.push(const SettingScreen());
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/setting_white.svg',
                            label: "Setting",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            GetContentBloc().getContentBlocMethod(
                              context: context,
                              setProgressBar: () {
                                AppDialogs.progressAlertDialog(
                                    context: context);
                              },
                              page: 'terms',
                              onSuccess: (res) {
                                Navigator.pop(context);
                                AppNavigation.push(
                                    ContentScreen(termsData: res));
                              },
                            );
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/terms_and_condition_white.svg',
                            label: "Terms & conditions",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            GetContentBloc().getContentBlocMethod(
                              context: context,
                              setProgressBar: () {
                                AppDialogs.progressAlertDialog(
                                    context: context);
                              },
                              page: 'privacy-policy',
                              onSuccess: (res) {
                                Navigator.pop(context);
                                AppNavigation.push(
                                    ContentScreen(termsData: res));
                              },
                            );
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/privacy_policy_white.svg',
                            label: "Privacy policy",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Get.to(() => const ReferAFriend());
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/rate_our_app_white.svg',
                            label: "Rate our App",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            SharedPreference().clear();
                            val.clearUserProvider();
                            context.read<PostProvider>().clearPostProvider();
                            AppNavigation.pushAndRemoveUntil(
                                const AppMainScreen());
                            AppDialogs.showToast(
                                message: "Logout successfully");
                          },
                          child: DrawerCard(
                            svgPicture: 'assets/logout_white.svg',
                            label: "Logout",
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
