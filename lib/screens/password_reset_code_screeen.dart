import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/bloc/auth/resend_otp_bloc.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/validators.dart';
import '../utils/colors.dart';
import '../utils/custom_scafold.dart';
import '../widgets/app_text_field.dart';
import '../widgets/big_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/get_back_button.dart';
import 'new_password_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, this.email});
  final String? email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _confirmationFormKey = GlobalKey<FormState>();
  final ValueNotifier<int> remainingSeconds = ValueNotifier<int>(0);
  Timer? _timer;

  void startTimer() {
    remainingSeconds.value = 60; // Start the countdown from 60 seconds

    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

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
        child: Form(
          key: _confirmationFormKey,
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
                  text: widget.email ?? "",
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
                hintText: 'Confirmation Code ',
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                maxLength: 6,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  return CommonFieldValidators.validateEmptyOrNull(
                    label: 'Confirmation Code',
                    value: resetPasswordController.text,
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: ValueListenableBuilder<int>(
                    valueListenable: remainingSeconds,
                    builder: (context, val, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Didn't receive a code?",
                              style: TextStyle(
                                  color: appGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Send again.',
                                    style: TextStyle(
                                        color: val > 0
                                            ? Colors.grey.shade600
                                            : Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        val <= 0
                                            ? ResendOtpBloc()
                                                .resendOtpBlocMethod(
                                                context: context,
                                                setProgressBar: () {
                                                  AppDialogs
                                                      .progressAlertDialog(
                                                          context: context);
                                                },
                                                onSuccess: (res) {
                                                  AppDialogs.showToast(
                                                      message:
                                                          'We have resend OTP verification code at your email address');
                                                  startTimer();
                                                },
                                              )
                                            : null;
                                      }),
                                if (val > 0)
                                  TextSpan(
                                    text: "  ${val.toString()}",
                                    style: TextStyle(
                                        color: val < 0
                                            ? Colors.grey.shade600
                                            : Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                              ],
                            ),
                          ),
                          // Text(val.toString(),
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20.sp,
                          //         fontWeight: FontWeight.w500)),
                        ],
                      );
                    }),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (_confirmationFormKey.currentState?.validate() ?? false) {
                    _confirmationFormKey.currentState?.save();

                    AppNavigation.pushReplacement(const NewPasswordScreen());
                    // Get.to(const NewPasswordScreen());
                  }
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
      ),
    );
  }
}
