import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_hunt/screens/password_reset_code_screeen.dart';
import 'package:safe_hunt/utils/custom_scafold.dart';
import 'package:safe_hunt/widgets/app_text_field.dart';
import 'package:safe_hunt/widgets/custom_button.dart';

import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/get_back_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailTextController = TextEditingController();
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
              text: 'Let’s recover your account.',
              size: 20.sp,
              color: appWhiteColor,
              fontWeight: FontWeight.w400,
            ),
            BigText(
              text:
                  'Enter the email or phone number associated with your account.',
              size: 12.sp,
              color: appWhiteColor,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 30.h,
            ),
            AppTextField(
                textController: emailTextController,
                hintText: 'Email or phone number'),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(const ResetPasswordScreen());
              },
              child: CustomButton(
                text: 'Send Reset Code',
                color: appButtonColor,
                textColor: appBrownColor,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
