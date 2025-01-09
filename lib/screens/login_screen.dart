import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_hunt/screens/signup_screen.dart';
import 'package:safe_hunt/utils/custom_scafold.dart';
import 'package:safe_hunt/utils/validators.dart';
import 'package:safe_hunt/widgets/app_text_field.dart';
import 'package:safe_hunt/widgets/custom_button.dart';
import 'package:safe_hunt/widgets/get_back_button.dart';

import '../utils/colors.dart';
import '../widgets/big_text.dart';
import 'forgot_password_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _value = false;

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
          text: 'Log In',
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
              text: 'Good to see you again!',
              fontWeight: FontWeight.w400,
              size: 20,
              color: appWhiteColor,
            ),
            SizedBox(
              height: 30.h,
            ),
            AppTextField(
              textController: userNameController,
              hintText: 'Username',
            ),
            SizedBox(
              height: 30.h,
            ),
            AppTextField(
              textController: passwordController,
              hintText: 'Password',
              // validator: CommonFieldValidators.emailValidator(v),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Container(
                    width: 15.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: appLightGreenColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: _value
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
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                BigText(
                  text: 'Remember me',
                  color: appGreyColor,
                  size: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(const ForgotPasswordScreen());
                  },
                  child: BigText(
                    text: 'Forgot Password?',
                    fontWeight: FontWeight.w700,
                    size: 14.sp,
                    color: appButtonColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              text: 'Log In',
              color: appButtonColor,
              textColor: appBrownColor,
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.to(const SignUpScreen());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'New to Safe Hunt? ',
                    style: TextStyle(
                        color: appWhiteColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign Up >',
                        style: TextStyle(
                            color: appButtonColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
