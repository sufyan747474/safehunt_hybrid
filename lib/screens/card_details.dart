import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_hunt/utils/custom_scafold.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

import '../utils/colors.dart';
import '../widgets/app_text_field_two.dart';
import '../widgets/big_text.dart';
import '../widgets/get_back_button.dart';
import 'drawer/base_screen.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  TextEditingController cardNumberTextController = TextEditingController();
  TextEditingController monthYearTextController = TextEditingController();
  TextEditingController cvcTextController = TextEditingController();
  TextEditingController nameCardHolderTextController = TextEditingController();

  bool _valueOne = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Transform.translate(
              offset: Offset(10.w, 0),
              child: const GetBackButton(
                width: 10,
                height: 10,
              )),
        ),
        title: BigText(
          text: 'Card Details',
          fontWeight: FontWeight.bold,
          size: 20.sp,
          color: appWhiteColor,
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 120,
            // replace with your Card here
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: appButtonColor,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  AppTextFieldTwo(
                    textController: cardNumberTextController,
                    hintText: 'Card Number',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFieldTwo(
                          textController: monthYearTextController,
                          hintText: 'MM/YY',
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Expanded(
                        child: AppTextFieldTwo(
                          textController: cvcTextController,
                          hintText: 'CVC',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextFieldTwo(
                    textController: nameCardHolderTextController,
                    hintText: 'Name Of The Card Holder',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _valueOne = !_valueOne;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: appLightGreenColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: _valueOne
                                  ? Icon(
                                      Icons.check,
                                      size: 10.0.sp,
                                      color: appLightGreenColor,
                                      weight: 10,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 10.0.sp,
                                      color: Colors.white,
                                      weight: 10,
                                    ),
                            ),
                          )),
                      SizedBox(
                        width: 10.w,
                        height: 10.h,
                      ),
                      Expanded(
                        child: BigText(
                          maxLine: 2,
                          text:
                              'Save This Card For a Faster Checkout Next Time',
                          size: 10.sp,
                          color: appBrownColor,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        const BaseScreen(),
                      );
                    },
                    child: CustomButton(
                      text: 'Done',
                      color: appLightGreenColor,
                      textColor: appButtonColor,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 450,
            // replace with your image here
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: appButtonColor.withOpacity(0.2),
                border: Border.all(
                    color: Colors.transparent.withOpacity(0.3), width: 1),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 250.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.h),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 15.0,
                    sigmaY: 15.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3), width: 1),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: appButtonColor.withOpacity(0.2),
                            blurRadius: 1.0,
                            offset: const Offset(0.0, 0.0),
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Container(
                                width: 70.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  color: appLightGreenColor,
                                ),
                                child: BigText(
                                  text: 'Primary',
                                  size: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: appWhiteColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: BigText(
                                text: 'Mastercard',
                                size: 14.sp,
                                fontWeight: FontWeight.w900,
                                color: appWhiteColor,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: BigText(
                            text: '**** 1184',
                            size: 26.53.sp,
                            fontWeight: FontWeight.w700,
                            color: appBrownColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
