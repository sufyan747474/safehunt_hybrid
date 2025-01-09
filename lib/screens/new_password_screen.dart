import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/custom_scafold.dart';
import 'package:safe_hunt/widgets/app_text_field.dart';
import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/get_back_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  bool _valueOne = false;
  bool _valueTwo = false;

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
            text: 'Forgot Password',
            fontWeight: FontWeight.bold,
            size: 20.sp,
            color: appWhiteColor,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              const Spacer(),
              BigText(
                text: 'Create new password',
                size: 20.sp,
                color: appWhiteColor,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                  textController: passwordTextController,
                  hintText: 'Password *'),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                  textController: confirmPasswordTextController,
                  hintText: 'Confirm Password *'),
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: 'Password Requirements:',
                      color: appGreyColor,
                      size: 14.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _valueOne = !_valueOne;
                                });
                              },
                              child: Container(
                                width: 15.w,
                                height: 15.h,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: appButtonColor),
                                child: _valueOne
                                    ? Icon(
                                        Icons.check,
                                        size: 10.0.sp,
                                        color: Colors.black,
                                        weight: 10,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 10.0.sp,
                                        color: appButtonColor,
                                        weight: 10,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: BigText(
                            maxLine: 2,
                            text:
                                'Must contain at least 8 characters, 1 special symbol (!@#\$%&), 1 number',
                            size: 12.sp,
                            color: appGreyColor,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _valueTwo = !_valueTwo;
                            });
                          },
                          child: Container(
                            width: 15.w,
                            height: 15.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: appButtonColor),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: _valueTwo
                                  ? Icon(
                                      Icons.check,
                                      size: 10.0.sp,
                                      color: Colors.black,
                                      weight: 10,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 10.0.sp,
                                      color: appButtonColor,
                                      weight: 10,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: BigText(
                          text: 'May not be a previously used password',
                          size: 12.sp,
                          color: appGreyColor,
                          fontWeight: FontWeight.w400,
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {},
                child: CustomButton(
                  text: 'Reset Password',
                  color: appButtonColor,
                  textColor: appBrownColor,
                ),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
