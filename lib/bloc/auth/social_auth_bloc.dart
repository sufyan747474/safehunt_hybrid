// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthBloc {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _userCredential;
  User? _user;
  // final SocialLoginBloc _socialLoginBloc = SocialLoginBloc();

  ///-------------------- Google Sign In -------------------- ///
  Future<void> signInWithGoogle({
    required BuildContext mainContext,
  }) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      await googleSignIn.signOut();

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // log("Access Token"+data.accessToken);
        log("Google Sign in Account : $googleSignInAccount");
        bool containsSpace = false;
        String fName = googleSignInAccount.displayName ?? "";
        String lName = '';
        String email = googleSignInAccount.email;
        if (googleSignInAccount.displayName != null) {
          containsSpace = googleSignInAccount.displayName!.contains(" ");
          if (containsSpace) {
            fName = googleSignInAccount.displayName!.split(" ")[0];
            lName = googleSignInAccount.displayName!.split(" ")[1];
          }
        }
        _socialLoginMethod(
          context: mainContext,
          email: email,
          userFirstName: fName,
          userLastName: lName,
          socialToken: googleSignInAccount.id,
          socialType: 'google',
        );
      }
    } catch (error) {
      log("error.toString(");
      log(error.toString());
      AppDialogs.showToast(message: "Something Went Wrong");
    }
  }

  ///  -------------------- Apple Sign In -------------------- //

  Future<void> signInWithApple({
    required BuildContext context,
  }) async {
    try {
      log("apple data");

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      log(credential.email ?? "");

      _socialLoginMethod(
        userFirstName: credential.givenName ?? "",
        userLastName: credential.familyName ?? "",
        context: context,
        socialToken: credential.userIdentifier,
        socialType: 'apple',
        email: credential.email ?? '',
      );
    } catch (error) {
      print(error.toString());
      // AppDialogs.showToast(message: "Something Went Wrong");
    }
  }

  //-------------------- Sign In Phone -------------------- ///
  Future<void> signInWithPhone(
      {required BuildContext context,
      String? countryCode,
      required String dialCode,
      required String phoneNumber,
      required VoidCallback setProgressBar,
      required VoidCallback cancelProgressBar}) async {
    try {
      log('phone number:  $phoneNumber');
      log('dial code:  $dialCode');

      // final authController = GetxController.Get.find<AuthController>();
      setProgressBar();

      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: dialCode + phoneNumber,
          // phoneNumber: '+1 1234567890',
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential authCredential) async {},
          verificationFailed: (FirebaseAuthException authException) {
            log(authException.message.toString());
            log(authException.code);

            if (authException.code == NetworkStrings.INVALID_PHONE_NUMBER) {
              cancelProgressBar();
              AppDialogs.showToast(message: "Invalid phone number");
            } else {
              cancelProgressBar();
              AppDialogs.showToast(message: authException.message ?? "");
            }
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            cancelProgressBar();
            log("verificationId : $verificationId");
            // authController.phoneController.text = "";
            // Get.find<AuthController>().verificationId =
            //     verificationId.toString();

            // AppNavigation.navigateReplacementNamed(
            //     AppRouteName.OTP_VERIFICATION_SCREEN_ROUTE,
            //     arguments: OtpVerificationScreenArguements(
            //         isFromPhoneNumber: true,
            //         phoneNumber: phoneNumber,
            //         dialCode: dialCode,
            //         email: "",
            //         verification: verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (error) {
      log("error");
      cancelProgressBar();
      AppDialogs.showToast(message: error.toString());
    }
  }

  ///-------------------- Verify Phone No -------------------- ///
  Future<void> verifyPhoneCode(
      {required BuildContext context,
      String? phoneNo,
      String? countryCode,
      String? dialCode,
      required String verificationId,
      required String verificationCode,
      required VoidCallback setProgressBar,
      required VoidCallback cancelProgressBar}) async {
    try {
      setProgressBar();

      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: verificationCode);
      _userCredential = await _firebaseAuth.signInWithCredential(credential);
      _user = _userCredential?.user;

      if (_user != null) {
        cancelProgressBar();

        await _firebaseUserSignOut();
        _socialLoginMethod(
          dialCode: dialCode,
          phone: phoneNo,
          context: context,
          countryCode: countryCode,
          socialToken: _user?.uid,
          socialType: "phone",
        );
      }
    } catch (error) {
      cancelProgressBar();

      AppDialogs.showToast(message: "Invalid OTP code");
    }
  }

  ///-------------------- Resend Code for Phone No -------------------- ///
  Future<void> resendPhoneCode(
      {required BuildContext context,
      String? countryCode,
      required String phoneNumber,
      required String dialCode,
      required ValueChanged<String?> getVerificationId,
      required VoidCallback setProgressBar,
      required VoidCallback cancelProgressBar}) async {
    try {
      setProgressBar();
      log('Phone Number : $phoneNumber');
      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: dialCode + phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential authCredential) async {},
          verificationFailed: (FirebaseAuthException authException) {
            cancelProgressBar();
            AppDialogs.showToast(message: authException.message!);
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            cancelProgressBar();
            getVerificationId(verificationId);
            AppDialogs.showToast(
                message:
                    "We have resend  OTP verification code at your phone number");
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            log(verificationId.toString());
          });
    } catch (error) {
      cancelProgressBar();
      AppDialogs.showToast(message: error.toString());
    }
  }

  void _socialLoginMethod({
    required BuildContext context,
    String? socialToken,
    String? socialType,
    String? countryCode,
    String? dialCode,
    String? phone,
    String? email,
    String? userFirstName,
    String? userLastName,
  }) {
    log("data");
    log("socialToken:$socialToken");

    // _socialLoginBloc.socialLoginBlocMethod(
    //   context: context,
    //   email: email,
    //   userSocialType: socialType,
    //   userSocialToken: socialToken ?? "123",
    //   userFirstName: userFirstName,
    //   userLastName: userLastName,
    //   phoneNumber: '$dialCode $phone',
    //   setProgressBar: () {
    //     AppDialogs.progressAlertDialog(context: context);
    //   },
    // );
  }

  ///-------------------- Sign out from firebase -------------------- ///
  Future<void> _firebaseUserSignOut() async {
    await _firebaseAuth.signOut();
  }
}
