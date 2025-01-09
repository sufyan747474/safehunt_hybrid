import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../utils/colors.dart';
import '../utils/custom_scafold.dart';
import '../widgets/app_text_field.dart';
import '../widgets/big_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/get_back_button.dart';
import 'new_password_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController resetPasswordController = TextEditingController();
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
              text: 'A password reset  code was sent to',
              size: 18.sp,
              color: appWhiteColor,
              fontWeight: FontWeight.w400,
            ),
            Center(
              child: BigText(
                text: 'example123@gmail.com.',
                size: 20.sp,
                color: appWhiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            BigText(
              text: 'Check your email and enter the code below.',
              size: 14.sp,
              color: appWhiteColor,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
                textController: resetPasswordController,
                hintText: 'Confirmation Code '),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Didn’t receive a code? ',
                  style: TextStyle(
                      color: appWhiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Send again.',
                      style: TextStyle(
                          color: appButtonColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(const NewPasswordScreen());
              },
              child: CustomButton(
                text: 'Continue',
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
