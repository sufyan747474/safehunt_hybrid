import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_hunt/bloc/auth/social_auth_bloc.dart';
import 'package:safe_hunt/screens/signup_screen.dart';
import 'package:safe_hunt/utils/custom_scafold.dart';
import 'package:safe_hunt/widgets/big_text.dart';

import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/app_logo.png",
                fit: BoxFit.fill,
              ),
              BigText(
                text: 'SAFE Hunt',
                color: appWhiteColor,
                size: 24.sp,
                fontWeight: FontWeight.w900,
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SignUpScreen());
                },
                child: CustomButton(
                  text: 'Sign Up',
                  fontWeight: FontWeight.w500,
                  textColor: appBlackColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const LogInScreen());
                },
                child: CustomButton(
                  text: 'Log In',
                  fontWeight: FontWeight.w500,
                  textColor: appWhiteColor,
                  color: Colors.transparent,
                  border: Border.all(color: appButtonWhiteColor, width: 2.0),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  FirebaseAuthBloc().signInWithGoogle(mainContext: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: 'Sign Up With',
                      color: appWhiteColor,
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/google_icon.png",
                      fit: BoxFit.fill,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              BigText(
                text: 'Sign Up With Phone Number',
                color: appWhiteColor,
                size: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
