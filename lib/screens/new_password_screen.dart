import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/bloc/auth/change_password_bloc.dart';
import 'package:safe_hunt/bloc/auth/reset_password_bloc.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/custom_scafold.dart';
import 'package:safe_hunt/utils/validators.dart';
import 'package:safe_hunt/widgets/app_text_field.dart';
import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/get_back_button.dart';

class NewPasswordScreen extends StatefulWidget {
  final bool isChangePassword;
  final String? email;
  const NewPasswordScreen(
      {super.key, this.isChangePassword = false, this.email});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController currentPasswordTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  // bool _valueOne = false;
  // bool _valueTwo = false;
  bool obsecureTax1 = true;
  bool obsecureTax2 = true;
  bool obsecureTax3 = true;

  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

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
            text: '${widget.isChangePassword ? 'Change' : 'Forgot'} Password',
            fontWeight: FontWeight.bold,
            size: 20.sp,
            color: appWhiteColor,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _passwordFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  BigText(
                    text: 'Create new password',
                    size: 20.sp,
                    color: appWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (widget.isChangePassword) ...[
                    AppTextField(
                      textController: currentPasswordTextController,
                      hintText: 'Current Password *',
                      maxLength: 35,
                      isObscure: obsecureTax3,
                      isSuffixIcons: true,
                      validator: (value) {
                        return CommonFieldValidators.passwordValidator(value);
                      },
                      suffixIcon: IconButton(
                          onPressed: () {
                            obsecureTax3 = !obsecureTax3;
                            setState(() {});
                          },
                          icon: Icon(
                            !obsecureTax3
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: appWhiteColor,
                          )),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                  AppTextField(
                    textController: passwordTextController,
                    hintText: 'New Password *',
                    maxLength: 35,
                    isObscure: obsecureTax1,
                    isSuffixIcons: true,
                    validator: (value) {
                      return CommonFieldValidators.passwordValidator(value);
                    },
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
                    height: 20.h,
                  ),
                  AppTextField(
                    textController: confirmPasswordTextController,
                    hintText: 'New Confirm Password *',
                    maxLength: 35,
                    validator: (value) {
                      return CommonFieldValidators.confirmPasswordValidator(
                        passwordTextController.text,
                        value,
                      );
                    },
                    isObscure: obsecureTax2,
                    isSuffixIcons: true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          obsecureTax2 = !obsecureTax2;
                          setState(() {});
                        },
                        icon: Icon(
                          !obsecureTax2
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
                                Container(
                                  width: 15.w,
                                  height: 15.h,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: appButtonColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
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
                            Container(
                              width: 15.w,
                              height: 15.h,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: appButtonColor),
                              child: const Padding(
                                padding: EdgeInsets.all(1.0),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
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
                    onTap: () {
                      if (_passwordFormKey.currentState!.validate()) {
                        _passwordFormKey.currentState?.save();
                        if (widget.isChangePassword) {
                          ChangePasswordBloc().changePasswordBlocMethod(
                            context: context,
                            setProgressBar: () {
                              AppDialogs.progressAlertDialog(context: context);
                            },
                            newPassword: confirmPasswordTextController.text,
                            currentPassword: currentPasswordTextController.text,
                          );
                        } else {
                          ResetPasswordBloc().resetPasswordBlocMethod(
                            context: context,
                            setProgressBar: () {
                              AppDialogs.progressAlertDialog(context: context);
                            },
                            email: widget.email,
                            newPassword: confirmPasswordTextController.text,
                          );
                        }
                      }
                    },
                    child: CustomButton(
                      text: widget.isChangePassword
                          ? 'Change Password'
                          : 'Reset Password',
                      color: appButtonColor,
                      textColor: appBrownColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
