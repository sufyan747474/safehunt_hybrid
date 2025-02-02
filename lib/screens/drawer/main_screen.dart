import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_hunt/screens/drawer/notification_screen.dart';
import 'package:safe_hunt/screens/drawer/map_screen.dart';
import 'package:safe_hunt/screens/drawer/setting.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'chat_screen.dart';
import 'drawer_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _mapActiveColor = false;
  int _page = 0;
  late PageController pageController;
  int currentIndex = 0;

  List<dynamic> imagePath = <dynamic>[
    SvgPicture.asset('assets/profile.svg'),
    SvgPicture.asset('assets/push_notification.svg'),
    Image.asset(
      'assets/mask.png',
    ),
    SvgPicture.asset(
      'assets/message.svg',
    ),
    SvgPicture.asset('assets/setting.svg'),
  ];

  List<dynamic> itemNameWhite = <dynamic>[
    SvgPicture.asset('assets/profile_white.svg'),
    SvgPicture.asset('assets/push_notification_white.svg'),
    Image.asset(
      'assets/mask_white.png',
    ),
    SvgPicture.asset(
      'assets/message_white.svg',
    ),
    SvgPicture.asset('assets/setting_white.svg'),
  ];
  var mainScreenItems = [
    const HomeScreen(),
    const NotificationScreen(),
    const MapScreen(),
    const ChatsScreen(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(keepPage: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
    // if(page == 4){
    //   Get.to(Setting());
    //   // Navigator.of(context).push(
    //   //     MaterialPageRoute(builder: (context) => Setting()));
    // } else{
    //   setState(() {
    //     _page = page.bitLength;
    //   });
    // }
  }

  void navigationTapped(int page) {
    // this will act as a link between tab bar and the pageView widget in the scaffold body.
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: currentIndex == 2
              ? const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/mapscreen.png"),
                    fit: BoxFit.cover,
                  ),
                )
              : const BoxDecoration(
                  color: appButtonColor,
                ),
          child: Scaffold(
              extendBody: true,
              backgroundColor: Colors.transparent,
              drawer: const DrawerScreen(),
              body: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: onPageChanged,
                children: mainScreenItems,
              ),
              bottomNavigationBar: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        height: 60.h,
                        decoration: const BoxDecoration(
                          color: appLightGreenColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                    navigationTapped(index);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      currentIndex == index
                                          ? itemNameWhite[index]
                                          : imagePath[index],
                                    ],
                                  ),
                                ),
                              );
                            })),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
