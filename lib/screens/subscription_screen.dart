import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/custom_scafold.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

import '../widgets/get_back_button.dart';
import 'card_details.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _valueOne = false;
  bool _valueTwo = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: Transform.translate(
              offset: Offset(10.w, 0),
              child: const GetBackButton(
                width: 10,
                height: 10,
              )),
        ),
        title: BigText(
          text: 'Safe Hunt Subscription',
          fontWeight: FontWeight.bold,
          size: 20.sp,
          color: appWhiteColor,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.82,

                // height: MediaQuery.of(context).size.height -190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: appButtonColor,
                  // image: new DecorationImage(image: new AssetImage("assets/subscription_picture.png"), fit: BoxFit.cover,),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              // color: Colors.white,
                              border: Border.all(color: appBrownColor),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/subscription_picture.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),

                            // DecorationImage(image: Image.asset('assets/subscription_picture.png',),
                            // ),
                          ),
                        ),
                        Positioned(
                          left: 275.w,
                          top: 200.h,
                          child: Container(
                            width: 25.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child:
                                // Icon(Icons.add),
                                Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset('assets/app_logo.png',
                                  fit: BoxFit.cover, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: Column(
                              children: [
                                BigText(
                                  text:
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore',
                                  size: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: appBrownColor,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 15.sp,
                                      weight: 15,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: BigText(
                                        text:
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore',
                                        size: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: appBrownColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 15.sp,
                                      weight: 15,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: BigText(
                                        text:
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit,',
                                        size: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: appBrownColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 15.sp,
                                      weight: 15,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: BigText(
                                        text: 'Lorem ipsum dolor sit amet',
                                        size: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: appBrownColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: subscriptionCardColor,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  padding: EdgeInsets.all(8.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _valueOne = !_valueOne;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: appButtonColor,
                                            border: Border.all(
                                                color: appLightGreenColor),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: _valueOne
                                                ? Icon(
                                                    Icons.check,
                                                    size: 20.0.sp,
                                                    color: appLightGreenColor,
                                                    weight: 10,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .check_box_outline_blank,
                                                    size: 20.0.sp,
                                                    color: appButtonColor,
                                                    weight: 10,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          BigText(
                                            text: "\$500",
                                            color: appBrownColor,
                                            fontWeight: FontWeight.w700,
                                            size: 24.sp,
                                          ),
                                          Row(
                                            children: [
                                              BigText(
                                                text: "1 Month",
                                                color: appBrownColor,
                                                size: 10.sp,
                                                fontWeight: FontWeight.w400,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: subscriptionCardColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.all(8.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _valueTwo = !_valueTwo;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: appButtonColor,
                                            border: Border.all(
                                              color: appLightGreenColor,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: _valueTwo
                                                ? Icon(
                                                    Icons.check,
                                                    size: 20.0.sp,
                                                    color: appLightGreenColor,
                                                    weight: 10,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .check_box_outline_blank,
                                                    size: 20.0.sp,
                                                    color: appButtonColor,
                                                    weight: 10,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          BigText(
                                            text: "\$100",
                                            color: appBrownColor,
                                            fontWeight: FontWeight.w700,
                                            size: 24.sp,
                                          ),
                                          Row(
                                            children: [
                                              BigText(
                                                text: "12 Month",
                                                color: appBrownColor,
                                                size: 10.sp,
                                                fontWeight: FontWeight.w400,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(const CardDetails());
                                  },
                                  child: CustomButton(
                                    text: 'Proceed',
                                    color: appLightGreenColor,
                                    textColor: subscriptionCardColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
