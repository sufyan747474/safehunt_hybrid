import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/utils/static_data.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/widgets/big_text.dart';

class WeatherTab extends StatefulWidget {
  const WeatherTab({super.key});

  @override
  State<WeatherTab> createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  List<String> time = ["Now", "2 pm", "3 pm", "4 pm", "5 pm"];

  @override
  void initState() {
    super.initState();

    // Call getLatLong and update state
    Utils.getLatLong().then((result) {
      // if (!mounted) return; // ✅ Prevent setState if widget is disposed
      // setState(() {
      StaticData.navigatorKey.currentState?.context
          .read<UserProvider>()
          .setWeather(result.$2);
      // wheather = result.$2;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, val, _) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(val.wheather?.weather?[0].main == 'Clouds'
                    ? AppAssets.cloudyDay
                    : (val.wheather?.weather?[0].main == 'Rain' ||
                            val.wheather?.weather?[0].main == 'Drizzle' ||
                            val.wheather?.weather?[0].main == 'Thunderstorm')
                        ? AppAssets.rainyyDay
                        : val.wheather?.weather?[0].main == 'Snow'
                            ? AppAssets.snowDay
                            : AppAssets.sunnyDay))),
        child: Scaffold(
          backgroundColor: AppColors.transparentColor,
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
              text: 'Weather',
              size: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.w),
                width: 1.sw,
                // height: .5.sh,
                decoration: BoxDecoration(
                    color: appButtonColor,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 40.verticalSpace,
                    Text(
                      "Weather in the area",
                      style: TextStyle(
                          fontSize: 21.sp, fontWeight: FontWeight.bold),
                    ),
                    24.verticalSpace,
                    // ElevatedButton(onPressed: () async {}, child: Text('data')),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Utils.getWeatherIcon(val.wheather?.weather?[0].main,
                              val.wheather?.weather?[0].icon),
                          color: appLightGreenColor,
                          size: 28.r,
                        ),
                        10.horizontalSpace,
                        BigText(
                          text: '${val.wheather?.main?.temp?.round() ?? '-'}°',
                          // 'Breezy with hazy sun Hi: 31°',
                          size: 34.sp,
                          fontWeight: FontWeight.w600,
                          color: appBlackColor,
                        ),
                      ],
                    ),
                    24.verticalSpace,
                    Text(
                      "${val.wheather?.weather?.first.description ?? ""} - Feels like: ${val.wheather?.main?.feelsLike?.round() ?? ''}",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    // 24.verticalSpace,
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           for (int i = 0; i < 5; i++)
                    //             Text(
                    //               "${wheather?.main?.temp?.round() ?? "0"}°",
                    //               style: AppTextStyles.customtextStyle(
                    //                   fontSize: 30.sp,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //         ],
                    //       ),
                    //       24.verticalSpace,
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           for (int i = 0; i < 5; i++)
                    //             Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 Image.asset(icon[i],
                    //                     width: 24.w,
                    //                     color: AppColors.PRIMARY_COLOR),
                    //                 12.verticalSpace,
                    //                 Text(
                    //                   time[i],
                    //                   style: AppTextStyles.customtextStyle(
                    //                       fontSize: 14.sp,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //               ],
                    //             )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
