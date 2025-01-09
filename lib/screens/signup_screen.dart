import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:safe_hunt/bloc/auth/register_bloc.dart';
import 'package:safe_hunt/screens/login_screen.dart';
import 'package:safe_hunt/screens/subscription_screen.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/validators.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/custom_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../utils/colors.dart';
import '../utils/custom_scafold.dart';
import '../widgets/app_text_field.dart';
import '../widgets/get_back_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmationCodeController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController signupConfirmPasswordController =
      TextEditingController();

  bool _valueOne = false;
  bool _valueTwo = false;
  bool obsecureTax = true;
  bool obsecureTax1 = true;

  int activeIndex = 1;
  int totalIndex = 2;
  bool isChecked = false;
  bool isSwitched = false;
  final GlobalKey<FormState> _signFormKey = GlobalKey<FormState>();

  Widget businessDetails() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 150.h,
              ),
              BigText(
                text: 'A confirmation code was sent to example123@gmail.com.',
                maxLine: 2,
                size: 20.sp,
                color: appWhiteColor,
              ),
              SizedBox(
                height: 70.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: BigText(
                  text: 'Check your email and enter the code below.',
                  size: 12.sp,
                  color: appGreyColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                textController: confirmationCodeController,
                hintText: 'Confirmation Code ',
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Didn’t receive a code?',
                    style: TextStyle(
                        color: appGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Send again.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        Get.to(const SubscriptionScreen());
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) =>
                        //         WelcomeScreen(
                        //       title: 'Home',
                        //     ),
                        //   ),
                        // );
                        print('helo');
                      },
                    );
                  },
                  child: CustomButton(text: 'Continue')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (activeIndex != 1) {
          activeIndex--;
          setState(() {});
          return false;
        }
        return true;
      },
      child: CustomScaffold(
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
            text: 'Sign Up',
            fontWeight: FontWeight.bold,
            size: 20.sp,
            color: appWhiteColor,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 116.w,
                      child: StepProgressIndicator(
                        // customStep: ,
                        totalSteps: totalIndex,
                        currentStep: activeIndex,
                        roundedEdges: const Radius.circular(30),
                        size: 10,
                        padding: 4,
                        selectedColor: appButtonWhiteColor,
                        unselectedColor: appGreyColor,
                      ),
                    )
                  ],
                ),
                bodyBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyBuilder() {
    switch (activeIndex) {
      case 0:
        return signUpDetails();
      case 1:
        return signUpDetails();

      case 2:
        return businessDetails();
      default:
        return signUpDetails();
    }
  }

  Widget signUpDetails() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _signFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      BigText(
                        text: 'Get Started',
                        color: appWhiteColor,
                        size: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextField(
                        textController: emailController,
                        hintText: 'Email *',
                        maxLength: 35,
                        validator: (value) {
                          return CommonFieldValidators.emailValidator(value);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextField(
                        textController: displayNameController,
                        hintText: 'Display Name *',
                        maxLength: 35,
                        validator: (value) {
                          return CommonFieldValidators.validateEmptyOrNull(
                              label: 'Display Name', value: value);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextField(
                        textController: userNameController,
                        hintText: 'User Name *',
                        maxLength: 35,
                        validator: (value) {
                          return CommonFieldValidators.validateEmptyOrNull(
                              label: 'User Name', value: value);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextField(
                        textController: phoneNumberController,
                        hintText: 'Phone Number *',
                        validator: (value) {
                          return CommonFieldValidators.phoneFieldValidatorLogin(
                            value,
                          );
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(
                            mask: '+1 ### ### ####',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy,
                          ),
                          LengthLimitingTextInputFormatter(16),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextField(
                        textController: signupPasswordController,
                        hintText: 'Password *',
                        maxLength: 35,
                        validator: (value) {
                          return CommonFieldValidators.passwordValidator(value);
                        },
                        isObscure: obsecureTax,
                        isSuffixIcons: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              obsecureTax = !obsecureTax;
                              setState(() {});
                            },
                            icon: Icon(
                              !obsecureTax
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: appWhiteColor,
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextField(
                        textController: signupConfirmPasswordController,
                        hintText: 'Confirm Password *',
                        maxLength: 35,
                        validator: (value) {
                          return CommonFieldValidators.confirmPasswordValidator(
                            signupPasswordController.text,
                            value,
                          );
                        },
                        isObscure: obsecureTax1,
                        isSuffixIcons: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              obsecureTax1 = !obsecureTax1;
                              setState(() {});
                            },
                            icon: Icon(
                              !obsecureTax1
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: appWhiteColor,
                            )),
                      ),
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
                              color: appButtonWhiteColor,
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
                                        // setState(() {
                                        //   _valueOne = !_valueOne;
                                        // });
                                      },
                                      child: Container(
                                        width: 15.w,
                                        height: 15.h,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
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
                                                  color: Colors.white,
                                                  weight: 10,
                                                ),
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
                                    color: appWhiteColor,
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
                                    // setState(() {
                                    //   _valueTwo = !_valueTwo;
                                    // });
                                  },
                                  child: Container(
                                    width: 15.w,
                                    height: 15.h,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
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
                                              color: Colors.white,
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
                                  text:
                                      'May not include your name or birth date',
                                  size: 12.sp,
                                  color: appWhiteColor,
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
                        onTap: () {
                          log(phoneNumberController.text);

                          if (_signFormKey.currentState!.validate()) {
                            _signFormKey.currentState?.save();
                            RegisterUserBloc().registerUserBlocMethod(
                              context: context,
                              setProgressBar: () {
                                AppDialogs.progressAlertDialog(
                                    context: context);
                              },
                              email: emailController.text,
                              displayName: displayNameController.text,
                              userName: userNameController.text,
                              password: signupPasswordController.text,
                              confirmPassword:
                                  signupConfirmPasswordController.text,
                              phoneNumber: phoneNumberController.text,
                              onSuccess: (p0) {
                                {
                                  setState(() {
                                    activeIndex++;
                                  });
                                }
                              },
                            );
                          }
                        },
                        child: CustomButton(
                          text: 'Continue',
                          fontWeight: FontWeight.w500,
                          textColor: appBlackColor,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By clicking continue, you agree to our',
                          style: TextStyle(
                              color: appGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Terms of Service',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text: ' and',
                              style: TextStyle(
                                  color: appGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: ' Privacy Policy',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(const LogInScreen());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(
                                  color: appGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Log in >',
                                  style: TextStyle(
                                      color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
