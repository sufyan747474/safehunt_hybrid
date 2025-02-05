import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/post/get_all_post_bloc.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/drawer/add_post_screen.dart';
import 'package:safe_hunt/screens/post/post_detail_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/utils.dart';
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
  // WeatherModel? wheather;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetAllPostBloc().getAllPostBlocMethod(
        context: context,
        setProgressBar: () {
          AppDialogs.progressAlertDialog(context: context);
        },
        onSuccess: () {},
      );
    });
// Call getLatLong and update state
    Utils.getLatLong().then((result) {
      if (!mounted) return; // ✅ Prevent setState if widget is disposed
      setState(() {
        context.read<UserProvider>().setWeather(result.$2);
        // wheather = result.$2;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, val, _) {
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
                  Utils.unFocusKeyboard(context);
                  context.read<UserProvider>().emptyJournal();
                  AppNavigation.push(const HuntingJournalScreen());
                  // Get.to(HuntingJournalScreen());
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.standard,
                      onPressed: () async {
                        Utils.getLatLong().then((result) {
                          if (!mounted)
                          // ✅ Prevent setState if widget is disposed
                          {
                            setState(() {
                              val.setWeather(result.$2);
                            });
                          }
                        });
                      },
                      icon:
                          // CustomImageWidget(
                          //   shape: BoxShape.rectangle,
                          //   borderRadius: BorderRadius.zero,
                          //   isBorder: false,
                          //   isBaseUrl: false,
                          //   imageUrl:
                          //       'https://openweathermap.org/img/wn/${wheather?.weather?[0].icon}@2x.png',
                          //   fit: BoxFit.contain,
                          //   imageWidth: 20.w,
                          //   imageHeight: 20.h,

                          Icon(
                              Utils.getWeatherIcon(
                                  val.wheather?.weather?[0].main,
                                  val.wheather?.weather?[0].icon),
                              color: appLightGreenColor)),
                  BigText(
                    text: '${val.wheather?.main?.temp?.round() ?? '-'}°',
                    // 'Breezy with hazy sun Hi: 31°',
                    size: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: appBlackColor,
                  ),
                ],
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
                          alignment: Alignment.center,
                          height: 50.w,
                          width: 50.w,
                          padding: EdgeInsets.all(10.r),
                          decoration: const BoxDecoration(
                              color: appBrownColor, shape: BoxShape.circle),
                          child: BigText(
                            text: val.user?.username?.isNotEmpty ?? false
                                ? val.user!.username![0].toUpperCase()
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
                        child: NewsFeedCard(
                          functionOnTap: () {
                            AppNavigation.push(const PostDetailScreen());
                          },
                        ),
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
    });
  }
}
