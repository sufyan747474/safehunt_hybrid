import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/post/get_all_post_bloc.dart';
import 'package:safe_hunt/bloc/post/get_post_details_bloc.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/drawer/add_post_screen.dart';
import 'package:safe_hunt/screens/post/post_detail_screen.dart';
import 'package:safe_hunt/screens/wheather/wheather_screen.dart';
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
  final ScrollController _scrollController = ScrollController();

  int _page = 1;

  bool _isLoadingMore = false;

  // WeatherModel? wheather;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchPost(true);
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            _isLoadingMore == false) {
          _isLoadingMore = true;
          setState(() {});
          _fetchPost(false);
        }
      });
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

  void _fetchPost(isLoader) {
    GetAllPostBloc().getAllPostBlocMethod(
      context: context,
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
      isLoader: isLoader,
      page: _page,
      onSuccess: () {
        _page++;

        _isLoadingMore = false;
        setState(() {});
      },
      onFailure: () {
        _isLoadingMore = false;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, PostProvider>(
        builder: (context, val, post, _) {
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
                child: Container(
                  alignment: Alignment.center,
                  height: 30.w,
                  width: 65.w,
                  decoration: BoxDecoration(
                    color: appBrownColor,
                    borderRadius: BorderRadius.all(Radius.circular(18.r)),
                  ),
                  child: SvgPicture.asset(
                    'assets/solar_notes-bold.svg',
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
                        // Utils.getLatLong().then((result) {
                        //   if (!mounted)
                        //   // ✅ Prevent setState if widget is disposed
                        //   {
                        //     setState(() {
                        //       val.setWeather(result.$2);
                        //     });
                        //   }
                        // });
                        AppNavigation.push(const WeatherTab());
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
              Container(
                // padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 7.w),
                alignment: Alignment.center,
                height: 30.w,
                width: 65.w,
                decoration: BoxDecoration(
                  color: appRedColor,
                  borderRadius: BorderRadius.all(Radius.circular(18.r)),
                ),
                child: BigText(
                  text: 'SOS',
                  size: 18.sp,
                  color: appWhiteColor,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
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
              SizedBox(
                height: 10.h,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: _isLoadingMore ? .62.sh : .7.sh,
                    child: Center(
                      child: post.isPost == false
                          ? BigText(text: 'Post not found')
                          : ListView.builder(
                              controller: _scrollController,
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
                    ),
                  ),
                  _isLoadingMore
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(
                            color: appLightGreenColor,
                            backgroundColor: appRedColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
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
